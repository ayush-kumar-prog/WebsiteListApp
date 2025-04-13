//
//  WebsitesViewModelTests.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25.
/**
 Key points:
 */

import XCTest
@testable import WebsiteListApp

final class WebsitesViewModelTests: XCTestCase {

    func testFetchWebsites_Success() {
        // Given
        let mockService = MockWebsiteFetchingService(
            result: .success([
                Website(name: "Google", url: "", icon: "", description: ""),
                Website(name: "Amazon", url: "", icon: "", description: "")
            ])
        )
        let viewModel = WebsitesViewModel(service: mockService)

        // Wait a little bit for async
        let expectation = XCTestExpectation(description: "Fetch websites")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Then
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertEqual(viewModel.websites.count, 2)
            XCTAssertNil(viewModel.errorMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchWebsites_Failure() {
        // Given
        let mockService = MockWebsiteFetchingService(
            result: .failure(NSError(domain: "TestError", code: 999))
        )
        let viewModel = WebsitesViewModel(service: mockService)

        let expectation = XCTestExpectation(description: "Fetch websites failure")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // Then
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertTrue(viewModel.websites.isEmpty)
            XCTAssertNotNil(viewModel.errorMessage)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testSortByName() {
        // Given
        let mockService = MockWebsiteFetchingService(
            result: .success([
                Website(name: "YouTube", url: "", icon: "", description: ""),
                Website(name: "Amazon", url: "", icon: "", description: ""),
                Website(name: "Google", url: "", icon: "", description: "")
            ])
        )
        let viewModel = WebsitesViewModel(service: mockService)

        let expectation = XCTestExpectation(description: "Sort websites")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // When
            viewModel.sortByName()
            
            // Then
            XCTAssertEqual(viewModel.websites.map(\.name), ["Amazon", "Google", "YouTube"])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func testSearchTextFiltering() {
        // Given
        let mockService = MockWebsiteFetchingService(
            result: .success([
                Website(name: "Google", url: "", icon: "", description: "Search engine"),
                Website(name: "YouTube", url: "", icon: "", description: "Video platform"),
                Website(name: "Amazon", url: "", icon: "", description: "Shopping site")
            ])
        )
        let viewModel = WebsitesViewModel(service: mockService)
        
        let expectation = XCTestExpectation(description: "Filter websites")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // When
            viewModel.searchText = "oo"  // match 'Google', 'YouTube' has "ou" but not "oo", 'Amazon' no match
            
            // Then
            XCTAssertEqual(viewModel.filteredWebsites.count, 1) // only Google
            XCTAssertEqual(viewModel.filteredWebsites.first?.name, "Google")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
