//
//  WebsiteListAppUITestsLaunchTests.swift
//  WebsiteListAppUITests
//
//  Created by Ayush Kumar on 4/13/25.
//

import XCTest

final class WebsiteListAppUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        // Stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        


        // Take a screenshot and attach it for debugging purposes.
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
