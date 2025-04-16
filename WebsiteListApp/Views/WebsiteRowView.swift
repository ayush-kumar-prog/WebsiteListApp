//
//  WebsiteRowView.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25.

/**
 Key points:
 - I removed the deprecated use of .previewLayout by using the traits parameter in the preview macro, which tells SwiftUI to preview with the “sizeThatFits” trait for a phone.
 - Used  the Old (Reliable) PreviewProvider Approach SwiftUI preview mechanism that’s worked since Xcode 11. It always supports specifying a device with .previewDevice(...)
   or controlling layout with .previewLayout(...).
 - resilient image loading using kingfisher & fallback mechanism
 
 */

import SwiftUI
import Kingfisher

struct WebsiteRowView: View {
    let website: Website
    let isFavorite: Bool
    let onToggleFavorite: () -> Void

    @State private var loadFailed = false
    @State private var isReloading = false
    @State private var reloadKey = UUID()

    var body: some View {
        HStack {
            // LEFT ICON AREA
            if loadFailed {
                // If reloading is triggered, show a spinner.
                if isReloading {
                    ProgressView()
                        .frame(width: 60, height: 50)
                } else {
                    // Otherwise, display an error icon with a "Tap to Reload" button.
                    VStack(spacing: 4) {
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 50)
                            .foregroundColor(.gray)
                        
                        Button("Tap to Reload") {
                            withAnimation {
                                isReloading = true
                                loadFailed = false
                                reloadKey = UUID()
                            }
                        }
                        .font(.caption2)
                        .buttonStyle(.plain)
                    }
                    .frame(width: 60, height: 50)
                }
            } else {
                // The Kingfisher image, with an overlay to indicate reloading if needed.
                KFImage(URL(string: "\(website.icon)?forceReload=\(reloadKey.uuidString)"))
                    .placeholder { ProgressView() }
                    .onFailure { _ in
                        loadFailed = true
                    }
                    .onSuccess { _ in
                        isReloading = false
                    }
                    .retry(maxCount: 2, interval: .seconds(2))
                    .cacheMemoryOnly()
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        Group {
                            if isReloading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                            }
                        }
                    )
            }
            
            // MIDDLE TEXT AREA
            VStack(alignment: .leading) {
                Text(website.name)
                    .font(.headline)
                Text(website.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
            
            // FAVORITE BUTTON
            Button {
                withAnimation(.spring()) {
                    onToggleFavorite()
                }
            } label: {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
                    .font(.title3)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
    }
}

struct WebsiteRowView_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteRowView(
            website: Website(
                name: "Google",
                url: "https://www.google.com",
                icon: "https://upload.wikimedia.org/wikipedia/commons/2/2f/Google_2015_logo.svg",
                description: "Search engine for the world's information."
            ),
            isFavorite: false,
            onToggleFavorite: {}
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
