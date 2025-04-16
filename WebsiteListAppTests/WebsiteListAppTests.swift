//
//  WebsiteList.swift
//  WebsiteListAppTests
//
//  Created by Ayush Kumar on 4/15/25.
//
//  ===========================================================
//  TDD-Driven Development: Early Iteration Tests
//  ===========================================================
//  In the early stages of developing WebsiteListApp, I embraced a TDD approach
//  to guide the design of the core models, networking, and view model logic.
//  I wrote extensive unit tests to drive the behavior of the Website model,
//  its decoding (via JSON), and how the WebsitesViewModel would load data
//  using a network service conforming to WebsiteFetchingService.
//
//  Due to time constraints, I eventually pivoted to focus primarily on
//  robust UI tests; however, the legacy unit tests remain as evidence of
//  this iterative, test-driven design process.
//  ===========================================================
 
//import XCTest
//@testable import WebsiteListApp
//
//final class WebsiteModelTests: XCTestCase {
//    
//    func testWebsiteModelDecoding() throws {
//        let jsonString = """
//        [
//            {
//                "name": "TestSite",
//                "url": "https://testsite.com",
//                "icon": "icon.png",
//                "description": "A test website"
//            }
//        ]
//        """
//        guard let data = jsonString.data(using: .utf8) else {
//            XCTFail("Could not convert JSON string to Data.")
//            return
//        }
//        
//        let websites = try JSONDecoder().decode([Website].self, from: data)
//        XCTAssertEqual(websites.count, 1, "One website should be decoded.")
//        XCTAssertEqual(websites.first?.name, "TestSite", "The website name should match.")
//    }
//    
//    func testWebsiteEquality() {
//        let website1 = Website(name: "TestSite", url: "https://testsite.com", icon: "icon.png", description: "A test website")
//        let website2 = Website(name: "TestSite", url: "https://testsite.com", icon: "icon.png", description: "A test website")
//        XCTAssertEqual(website1, website2, "Websites with identical properties should be equal.")
//    }
//    
//    func testReverseStringUtility() {
//        func reverseString(_ input: String) -> String {
//            return String(input.reversed())
//        }
//        XCTAssertEqual(reverseString("Swift"), "tfiwS", "The reverse of 'Swift' should be 'tfiwS'.")
//    }
//}
