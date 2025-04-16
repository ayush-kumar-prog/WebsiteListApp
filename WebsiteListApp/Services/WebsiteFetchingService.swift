//
//  WebsiteFetchingService.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25.

/**
 Key points:
 - Protocol-based approach for fetching website data, makes the service mockable for tests and swappable if           networking layer is changed in future
 */

import Foundation

protocol WebsiteFetchingService {
    /// Fetch an array of Website objects asynchronously
    /// - Parameter completion: completion with Result<[Website], Error>
    func fetchWebsites(completion: @escaping (Result<[Website], Error>) -> Void)
}
