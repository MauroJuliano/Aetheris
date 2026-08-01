//
//  AetherisAppUITestsLaunchTests.swift
//  AetherisAppUITests
//
//  Created by maclau on 28/07/25.
//

import XCTest

final class AetherisAppUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-uiTesting"]
        app.launch()

        XCTAssertTrue(
            app.descendants(matching: .any)
                .matching(identifier: "login.screen")
                .firstMatch
                .waitForExistence(timeout: 3)
        )

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
