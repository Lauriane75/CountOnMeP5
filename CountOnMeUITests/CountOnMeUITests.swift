//
//  CountOnMeUITests.swift
//  CountOnMeUITests
//
//  Created by Lauriane Haydari on 22/08/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest

class CountOnMeUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        // Since UI tests are more expensive to run, it's usually a good idea
        // to exit if a failure was encountered
        continueAfterFailure = false

        app = XCUIApplication()

        // We send a command line argument to our app,
        // to enable it to reset its state
        app.launchArguments.append("--uitesting")
}

    // MARK: - Tests

    func testGoingThroughOnboarding() {
        app.launch()

        // Make sure we're displaying onboarding
//        XCTAssertTrue(app.isDisplayingOnboarding)

        let app = XCUIApplication()
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()

        // Tap the "Done" button


        // Onboarding should no longer be displayed
//        XCTAssertFalse(app.isDisplayingOnboarding)
    }

}
