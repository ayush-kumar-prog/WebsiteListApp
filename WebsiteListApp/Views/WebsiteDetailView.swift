//
//  WebsiteDetailView.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25.

/**
 Key points:
 - We wrap the .navigationBarTitleDisplayMode(.inline) modifier within #if os(iOS) so that it’s applied only on iOS.
 - The preview also uses a phone trait.
 */

import SwiftUI

struct WebsiteDetailView: View {
    let website: Website
    @Environment(\.openURL) var openURL

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: website.icon)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 16))

                Text(website.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(website.description)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button {
                    if let url = URL(string: website.url) {
                        openURL(url)
                    }
                } label: {
                    Text("Open Website")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.blue.cornerRadius(8))
                }
            }
            .padding()
        }
        .navigationTitle(website.name)
        // Wrap navigationBarTitleDisplayMode for iOS only.
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

// MARK: - PREVIEW
#if DEBUG
struct WebsiteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WebsiteDetailView(
                website: Website(
                    name: "Google",
                    url: "https://www.google.com",
                    icon: "https://upload.wikimedia.org/wikipedia/commons/2/2f/Google_2015_logo.svg",
                    description: "Search engine for the world's information."
                )
            )
        }
        .previewDevice("iPhone 14")
    }
}
#endif
