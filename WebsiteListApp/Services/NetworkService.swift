
/**
 Created by Ayush Kumar on 4/13/25.
 NetworkService.swift
 WebsiteListApp
 
 Key points:
 - We adopt WebsiteFetchingService, so if we later create a LocalMockService or a different API, we just swap out the class used in the ViewModel.
 - session is injected, which is ideal for unit testing.
 */

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
}

/// Concrete implementation of WebsiteFetchingService that hits a remote endpoint
class NetworkService: WebsiteFetchingService {
    private let session: URLSession
    private let urlString = "https://gist.githubusercontent.com/davidjarvis-TE/414edf2b4e878ab7ba1bf6bb1291a89e/raw/7537d5a0a37120e4a7127cc8f65f5265e723ff7b/websites_info.json"

    /// Dependency-injected session for easy testing
    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchWebsites(completion: @escaping (Result<[Website], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            // Networking or server error
            if let error = error {
                completion(.failure(error))
                return
            }

            // Data validation
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }

            // JSON Parsing
            do {
                let websites = try JSONDecoder().decode([Website].self, from: data)
                completion(.success(websites))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
