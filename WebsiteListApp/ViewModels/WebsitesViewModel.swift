//
//  WebsitesViewModel.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25.

/**
 Key points:
 - Dependency Injection via init(service:).
 - Separation of Concerns: The ViewModel does all data fetching + logic. The SwiftUI View just displays it.
 - MVVM: WebsitesViewModel is the “VM,” and Website is the “Model,” while the SwiftUI views are the “View.”
 */


import SwiftUI
import Combine

/// The ViewModel for displaying and manipulating the list of websites
class WebsitesViewModel: ObservableObject {
    // Published properties for SwiftUI updates
    @Published private(set) var websites: [Website] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""

    // Our data-fetching service, implementing the protocol
    private let service: WebsiteFetchingService

    // For canceling any Combine publishers if we used them
    private var cancellables = Set<AnyCancellable>()

    // Inject the service so we can swap for testing
    init(service: WebsiteFetchingService = NetworkService()) {
        self.service = service
        // Optionally, fetch the websites right away
        fetchWebsites()
    }

    // MARK: - Fetching
    func fetchWebsites() {
        isLoading = true
        errorMessage = nil

        service.fetchWebsites { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false

                switch result {
                case .success(let sites):
                    // Could animate insertion
                    withAnimation {
                        self.websites = sites
                    }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: - Sorting
    func sortByName() {
        // Sort by name ignoring case
        withAnimation {
            websites.sort { $0.name.lowercased() < $1.name.lowercased() }
        }
    }

    // MARK: - Filtering
    var filteredWebsites: [Website] {
        guard !searchText.isEmpty else {
            return websites
        }
        return websites.filter { website in
            website.name.localizedCaseInsensitiveContains(searchText) ||
            website.description.localizedCaseInsensitiveContains(searchText)
        }
    }
}
