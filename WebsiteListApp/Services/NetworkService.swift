
/**
 Created by Ayush Kumar on 4/13/25.
 NetworkService.swift
 WebsiteListApp
 
 Key points:
 - I adopt WebsiteFetchingService, so if I later create a LocalMockService or a different API, I just swap out the class used in the ViewModel.
 - session is injected, which is ideal for unit testing.
 - class NetworkService: WebsiteFetchingService { … } ensures it conforms to the protocol.
 - fetchWebsites tries the network first, then calls loadFromDiskFallback if it fails or if decoding fails.
 - saveToDisk writes the JSON for future offline usage.
 - also robust error handling
 - separation of concerns
 - atomic file writing
 - http status code validation
 - memory management: captuing self weakly
 - structured logs instead of print
 */

import Foundation
import os

enum NetworkError: Error {
    case invalidURL
    case invalidData
}

/// Concrete implementation of WebsiteFetchingService that fetches websites
/// and caches them for offline usage.
class NetworkService: WebsiteFetchingService {
    private let session: URLSession

    // Remote JSON endpoint.
    private let urlString = "https://gist.githubusercontent.com/davidjarvis-TE/414edf2b4e878ab7ba1bf6bb1291a89e/raw/7537d5a0a37120e4a7127cc8f65f5265e723ff7b/websites_info.json"

    /// Local file path for offline caching.
    private var localFileURL: URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent("websites_info.json")
    }
    
    // Logger for structured logging.
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "WebsiteListApp", category: "NetworkService")
    
    /// Inject session for easy testing or mocking.
    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchWebsites(completion: @escaping (Result<[Website], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        // 1) Attempt network request.
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                self.logger.error("Network fetch failed: \(error.localizedDescription, privacy: .public), trying offline cache...")
                self.loadFromDiskFallback(completion)
                return
            }
            
            // Validate HTTP status code.
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                self.logger.error("HTTP error: status code \(httpResponse.statusCode), trying offline cache...")
                self.loadFromDiskFallback(completion)
                return
            }
            
            guard let data = data else {
                self.logger.error("No data from network, trying offline cache...")
                self.loadFromDiskFallback(completion)
                return
            }
            
            do {
                let websites = try JSONDecoder().decode([Website].self, from: data)
                // 3) On success, save for offline usage.
                self.saveToDisk(data: data)
                completion(.success(websites))
            } catch {
                self.logger.error("Decode error: \(error.localizedDescription, privacy: .public), trying offline cache...")
                self.loadFromDiskFallback(completion)
            }
        }
        task.resume()
    }

    // MARK: - Offline Caching

    private func saveToDisk(data: Data) {
        do {
            try data.write(to: localFileURL, options: .atomicWrite)
            logger.info("Offline cache updated at \(self.localFileURL.path, privacy: .public)")
        } catch {
            logger.error("Failed to save offline cache: \(error.localizedDescription, privacy: .public)")
        }
    }

    private func loadFromDiskFallback(_ completion: @escaping (Result<[Website], Error>) -> Void) {
        do {
            let data = try Data(contentsOf: localFileURL)
            let websites = try JSONDecoder().decode([Website].self, from: data)
            completion(.success(websites))
        } catch {
            completion(.failure(error))
        }
    }
}
