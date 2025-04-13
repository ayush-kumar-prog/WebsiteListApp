//
//  WebsiteListAppUITests.swift
//  WebsiteListAppUITests
//
//  Created by Ayush Kumar on 4/13/25.
/**
 Key points:
 */

import XCTest

final class WebsiteListAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // In UI tests it’s best to stop right away if a failure occurs.
        continueAfterFailure = false
    }

    func testLoadingTableView() throws {
        let app = XCUIApplication()
        app.launch()

        // Wait for list to appear
        let firstCell = app.tables.cells.element(boundBy: 0)
        let exists = firstCell.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "The first cell should exist, meaning data loaded successfully.")
    }

    func testSearchFunction() throws {
        let app = XCUIApplication()
        app.launch()

        // Type in the search field
        let searchField = app.textFields["Search websites..."]
        XCTAssertTrue(searchField.waitForExistence(timeout: 2))
        searchField.tap()
        searchField.typeText("google")

        // Check that the table updates
        let firstCell = app.tables.cells.element(boundBy: 0)
        let cellExists = firstCell.waitForExistence(timeout: 2)
        XCTAssertTrue(cellExists)
        // Optionally, check cell label text if needed
    }
}
