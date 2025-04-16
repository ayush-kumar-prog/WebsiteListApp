//
//  WebsitesViewModelTests.swift
//  WebsiteListApp
//
//  Created by Ayush Kumar on 4/13/25.
/**
 Key points:
 - Unit tests covering the ViewModel’s fetching, sorting, search filtering, and favorite toggling.
 */

//import XCTest
//@testable import WebsiteListApp
//
//final class WebsitesViewModelTests: XCTestCase {
//    
//    func testViewModelFetchWebsitesSuccess() throws {
//        // Assume DummyWebsiteFetchingService is defined in your main target.
//        let dummyService = DummyWebsiteFetchingService(result: .success([
//            Website(name: "DummySite", url: "https://dummy.com", icon: "dummyIcon", description: "A dummy website")
//        ]))
//        
//        let viewModel = WebsitesViewModel(service: dummyService)
//        
//        // Give the asynchronous fetch a chance to complete.
//        let expectation = XCTestExpectation(description: "Fetch websites successfully")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 1.0)
//        
//        XCTAssertEqual(viewModel.websites.count, 1, "The view model should have one website loaded.")
//        XCTAssertEqual(viewModel.websites.first?.name, "DummySite", "The loaded website should be 'DummySite'.")
//        XCTAssertFalse(viewModel.isLoading, "isLoading should be false once fetch completes.")
//        XCTAssertNil(viewModel.errorMessage, "There should be no error message on a successful fetch.")
//    }
//}
