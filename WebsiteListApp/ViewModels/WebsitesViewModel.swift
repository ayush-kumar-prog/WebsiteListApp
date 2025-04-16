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
 - marked as final class to not let it be subclasssed
 - minor improvement: filter functionality converts the search text to lowercase once for efficiency and future    extension with more websites
    
 
 */


import SwiftUI

/// The ViewModel for displaying and manipulating the list of websites.
final class WebsitesViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published private(set) var websites: [Website] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    
    // Keep track of favorites by storing their IDs.
    @Published var favorites: Set<UUID> = []
    // Optionally, show only favorites.
    @Published var showFavoritesOnly: Bool = false

    // Data-fetching service.
    private let service: WebsiteFetchingService

    // MARK: - Initialization
    init(service: WebsiteFetchingService) {
        self.service = service
        fetchWebsites()
    }

    // MARK: - Data Fetching
    /// Fetches websites via the service and updates published properties on the main thread.
    func fetchWebsites() {
        isLoading = true
        errorMessage = nil

        service.fetchWebsites { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false

                switch result {
                case .success(let sites):
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
    /// Sorts the list of websites by name (case insensitive) with animation.
    func sortByName() {
        withAnimation {
            websites.sort { $0.name.lowercased() < $1.name.lowercased() }
        }
    }

    // MARK: - Favorites Logic
    /// Returns a Boolean indicating whether the website is marked as favorite.
    func isFavorite(_ website: Website) -> Bool {
        favorites.contains(website.id)
    }

    /// Toggles the favorite status of the provided website with animation.
    func toggleFavorite(_ website: Website) {
        withAnimation {
            if isFavorite(website) {
                favorites.remove(website.id)
            } else {
                favorites.insert(website.id)
            }
        }
    }

    // MARK: - Filtering
    /// Returns the filtered list of websites.
    /// - If `showFavoritesOnly` is enabled, the list is first filtered to include only favorites.
    /// - If `searchText` is not empty, the list is further filtered using a case-insensitive search on the website’s name and description.
    var filteredWebsites: [Website] {
        var base = websites
        
        // Filter by favorites if enabled.
        if showFavoritesOnly {
            base = base.filter { isFavorite($0) }
        }
        
        // If search text is provided, apply text-based filtering.
        guard !searchText.isEmpty else { return base }
        let lowercasedQuery = searchText.lowercased()
        return base.filter { site in
            site.name.lowercased().contains(lowercasedQuery) ||
            site.description.lowercased().contains(lowercasedQuery)
        }
    }
}
