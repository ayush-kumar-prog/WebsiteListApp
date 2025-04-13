//
//  ContentView.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25.

/**
 Key points:
 - Search via TextField.
 - Toolbar with refresh and sort icons.
 - SwiftUI’s List for smooth scrolling.
 - Automatic animated updates when filteredWebsites changes.
 - The .listStyle(.insetGrouped) is used only for iOS; macOS falls back to .plain.
 - The .toolbar modifiers are wrapped in #if os(iOS) because macOS doesn’t support the same navigation toolbar placements.
 - In the preview macro, we pass a trait to simulate an iPhone layout (using .init(userInterfaceIdiom: .phone)).
 */
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WebsitesViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                // Search Bar
                TextField("Search websites...", text: $viewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .padding(.top, 8)

                if viewModel.isLoading {
                    ProgressView("Fetching websites...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.filteredWebsites) { website in
                        NavigationLink(destination: WebsiteDetailView(website: website)) {
                            WebsiteRowView(website: website)
                        }
                    }
                    // If building for iOS, use insetGrouped; otherwise, use plain.
                    #if os(iOS)
                    .listStyle(.insetGrouped)
                    #else
                    .listStyle(.plain)
                    #endif
                    .animation(.default, value: viewModel.filteredWebsites)
                }
            }
            .navigationTitle("Websites")
            // Apply toolbars only if on iOS
            #if os(iOS)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { viewModel.fetchWebsites() }) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { viewModel.sortByName() }) {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
            #endif
        }
    }
}

#Preview {
    ContentView()
}

