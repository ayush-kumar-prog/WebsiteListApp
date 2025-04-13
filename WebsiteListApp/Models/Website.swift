//
//  Website.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25.
//

import Foundation

/// Represents a website with metadata
struct Website: Codable, Identifiable, Equatable {
    // Since JSON does not provide an ID, we supply a default here.
    // We exclude it from decoding by declaring custom CodingKeys.
    let id = UUID()
    
    let name: String
    let url: String
    let icon: String
    let description: String

    // Only these keys are decoded; 'id' is generated automatically.
    enum CodingKeys: String, CodingKey {
        case name, url, icon, description
    }
}
