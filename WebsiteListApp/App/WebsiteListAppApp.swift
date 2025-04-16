//
//  WebsiteListAppApp.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25. This is the entry point of the app

import SwiftUI

@main
struct WebsiteListAppApp: App {
    // Store user’s theme preference in AppStorage
    @AppStorage("selectedTheme") var selectedTheme: String = "Light"

    var body: some Scene {
        WindowGroup {
            ContentView()
                // Switch color scheme based on user’s preference
                .preferredColorScheme(selectedTheme == "Dark" ? .dark : .light)
        }
    }
}
