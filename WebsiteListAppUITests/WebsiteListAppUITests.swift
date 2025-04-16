//
//  WebsiteListAppUITests.swift
//  WebsiteListAppUITests
//
//  Created by Ayush Kumar on 4/13/25.


import XCTest

final class WebsiteListAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Stop immediately when a failure occurs.
        continueAfterFailure = false
    }
    
    /// Launch the app with dummy data for consistent tests.
    private func launchAppWithDummyData() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments.append("-useDummyData")
        app.launch()
        return app
    }
    
    /// Verify that the navigation bar with the title "Websites" is visible.
    func testNavigationTitleExists() throws {
        let app = launchAppWithDummyData()
        let navBar = app.navigationBars["Websites"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5), "The navigation bar with title 'Websites' should exist.")
    }
    
    /// Verify that the search field is present and can be tapped and typed into.
    func testSearchFieldCanTypeText() throws {
        let app = launchAppWithDummyData()
        let searchField = app.textFields["Search websites..."]
        XCTAssertTrue(searchField.waitForExistence(timeout: 5), "The search field should exist.")
        searchField.tap()
        searchField.typeText("google")
        XCTAssertTrue(searchField.exists, "After typing, the search field should still exist.")
    }
    
    /// Verify that the reset button (with identifier "resetButton") exists and is tappable.
    func testResetButtonExistsAndIsTappable() throws {
        let app = launchAppWithDummyData()
        let resetButton = app.buttons["resetButton"]
        XCTAssertTrue(resetButton.waitForExistence(timeout: 5), "The reset button should exist.")
        resetButton.tap()
        XCTAssertTrue(resetButton.exists, "The reset button should still exist after tapping.")
    }
    
    func testNavigationToDetailView() throws {
        let app = launchAppWithDummyData()
        let firstCell = app.tables.cells.element(boundBy: 0)
        // Increase timeout in case it needs extra time to appear.
        XCTAssertTrue(firstCell.waitForExistence(timeout: 15), "At least one website cell should exist.")
        firstCell.tap()
        
        let openWebsiteButton = app.buttons["Open Website"]
        XCTAssertTrue(openWebsiteButton.waitForExistence(timeout: 10), "Detail view should show an 'Open Website' button.")
    }

    func testFilterMenuOptions() throws {
        let app = launchAppWithDummyData()
        
        let filterMenu = app.buttons["filterMenu"]
        // Increase wait time for the filter menu to be fully loaded and visible.
        XCTAssertTrue(filterMenu.waitForExistence(timeout: 10), "The filter menu should exist.")
        
        if !filterMenu.isHittable {
            // If not hittable, tap using coordinate.
            filterMenu.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        } else {
            filterMenu.tap()
        }
        
        let allOption = app.buttons["All"]
        let favoritesOption = app.buttons["Favorites Only"]
        XCTAssertTrue(allOption.waitForExistence(timeout: 5), "The filter menu should show an 'All' option.")
        XCTAssertTrue(favoritesOption.waitForExistence(timeout: 5), "The filter menu should show a 'Favorites Only' option.")
    }
    
    /// Verify that the sort button (with identifier "sortButton") exists and is tappable.
    func testSortButtonExistsAndIsTappable() throws {
        let app = launchAppWithDummyData()
        let sortButton = app.navigationBars.buttons["sortButton"]
        XCTAssertTrue(sortButton.waitForExistence(timeout: 5), "The sort button should exist.")
        sortButton.tap()
        XCTAssertTrue(sortButton.exists, "The sort button should still exist after tapping.")
    }
}
