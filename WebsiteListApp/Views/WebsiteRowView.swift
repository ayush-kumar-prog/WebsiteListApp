//
//  WebsiteRowView.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25.

/**
 Key points:
 - We removed the deprecated use of .previewLayout by using the traits parameter in the preview macro, which tells SwiftUI to preview with the “sizeThatFits” trait for a phone.
 - Used  the Old (Reliable) PreviewProvider Approach SwiftUI preview mechanism that’s worked since Xcode 11. It always supports specifying a device with .previewDevice(...)
   or controlling layout with .previewLayout(...).
 
 */

import SwiftUI

struct WebsiteRowView: View {
    let website: Website

    var body: some View {
        //display icon
        HStack {
            AsyncImage(url: URL(string: website.icon)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 36, height: 36)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading) {
                Text(website.name)
                    .font(.headline)
                Text(website.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - PREVIEW
#if DEBUG
struct WebsiteRowView_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteRowView(
            website: Website(
                name: "Google",
                url: "https://www.google.com",
                icon: "https://upload.wikimedia.org/wikipedia/commons/2/2f/Google_2015_logo.svg",
                description: "Search engine for the world's information."
            )
        )
        // If you want a “sizeThatFits” layout in the preview:
        .previewLayout(.sizeThatFits)
    }
}
#endif
