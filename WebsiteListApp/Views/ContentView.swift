//
//  ContentView.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25.

/**
Key points:
 - SwiftUI’s List for smooth scrolling.
 - Automatic animated updates when filteredWebsites changes.
 - The .listStyle(.insetGrouped) is used only for iOS; macOS falls back to .plain.
 - The .toolbar modifiers are wrapped in #if os(iOS) because macOS doesn’t support the same navigation toolbar placements.
 - In the preview macro, I pass a trait to simulate an iPhone layout (using .init(userInterfaceIdiom: .
 - theming via appstorage to synchronise theme across app easily
 
Features:
  - Pull-to-refresh via .refreshable
  - Sorting by name
  - Search text filter
  - Theme menu (light/dark)
  - Offline fallback is handled in your NetworkService or ViewModel
*/

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WebsitesViewModel(service: NetworkService())

    // Using AppStorage to synchronize the selected theme across app launches.
    @AppStorage("selectedTheme") var selectedTheme: String = "Light"
    
    // Custom initializer that chooses a service based on launch arguments.
    init() {
        if ProcessInfo.processInfo.arguments.contains("-useDummyData") {
            // Use a dummy service or directly inject dummy data.
            let dummyService = DummyWebsiteFetchingService(result: .success([
                Website(name: "Dummy", url: "https://dummy.com", icon: "dummy_icon", description: "A dummy website")
            ]))
            _viewModel = StateObject(wrappedValue: WebsitesViewModel(service: dummyService))
        } else {
            _viewModel = StateObject(wrappedValue: WebsitesViewModel(service: NetworkService()))
        }
    }
    
    var body: some View {
        ZStack {
            // Full-screen background that extends into safe areas.
            Color(.systemBackground)
                .ignoresSafeArea()
            
            NavigationStack {
                VStack(spacing: 0) {
                    // Custom search bar with a slight vertical offset.
                    CustomSearchBar(text: $viewModel.searchText)
                        .offset(y: -8)
                    
                    if viewModel.isLoading {
                        ProgressView("Fetching websites...")
                            .padding()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        // Main list showing filtered websites.
                        List(viewModel.filteredWebsites) { website in
                            NavigationLink(destination: WebsiteDetailView(website: website)) {
                                WebsiteRowView(
                                    website: website,
                                    isFavorite: viewModel.isFavorite(website),
                                    onToggleFavorite: { viewModel.toggleFavorite(website) }
                                )
                            }
                        }
                        .refreshable {
                            viewModel.fetchWebsites()
                        }
                        #if os(iOS)
                        .listStyle(.insetGrouped)
                        #else
                        .listStyle(.plain)
                        #endif
                        .animation(.default, value: viewModel.filteredWebsites)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("Websites")
                #if os(iOS)
                .toolbar {
                    // Updated Reset Button: It clears favorites and resets the filter to show all websites.
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            // Clear favorites and reset filter to "All", then fetch data.
                            viewModel.favorites.removeAll()
                            viewModel.showFavoritesOnly = false
                            viewModel.fetchWebsites()
                        } label: {
                            Image(systemName: "arrow.clockwise")
                        }
                        // Accessibility Identifier added for UI testing.
                        .accessibilityIdentifier("resetButton")

                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            viewModel.sortByName()
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                        .accessibilityIdentifier("sortButton")
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu("Filter") {
                            Button("All") { viewModel.showFavoritesOnly = false }
                            Button("Favorites Only") { viewModel.showFavoritesOnly = true }
                        }
                        .accessibilityIdentifier("filterMenu")
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu("Theme") {
                            Button("Light Theme") { selectedTheme = "Light" }
                            Button("Dark Theme") { selectedTheme = "Dark" }
                        }
                    }
                }
                #endif
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .preferredColorScheme(selectedTheme == "Dark" ? .dark : .light)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
    }
}

class DummyWebsiteFetchingService: WebsiteFetchingService {
    let result: Result<[Website], Error>
    
    init(result: Result<[Website], Error>) {
        self.result = result
    }
    
    func fetchWebsites(completion: @escaping (Result<[Website], Error>) -> Void) {
        completion(result)
    }
}
