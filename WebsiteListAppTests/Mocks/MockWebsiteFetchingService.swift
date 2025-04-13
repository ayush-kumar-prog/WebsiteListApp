//
//  MockWebsiteFetchingService.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25.

/**
 Key points:
 
 */

import Foundation
@testable import WebsiteListApp

class MockWebsiteFetchingService: WebsiteFetchingService {
    let result: Result<[Website], Error>

    init(result: Result<[Website], Error>) {
        self.result = result
    }

    func fetchWebsites(completion: @escaping (Result<[Website], Error>) -> Void) {
        // Simulate async network call
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.2) {
            completion(self.result)
        }
    }
}
