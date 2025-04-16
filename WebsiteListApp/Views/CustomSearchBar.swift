//
//  CustomSearchBar.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25.
//

/**
 Key points:
 - The magnifying glass icon gives a visual cue.
 - Padding inside and outside makes it easier on the eyes.
 - The light-gray background (.systemGray6) and rounded corners (10 points) give it a modern look.
 - Disabling autocapitalization and auto-correction can also be beneficial for search.
 - disabled autocapitalisation & autocorrection: most toolbars have them nowadays
 */

import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search websites...", text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .padding(.horizontal, 12)
        .accessibilityElement(children: .combine)
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBar(text: .constant(""))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
