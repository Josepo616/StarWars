//
//  NoDataViewUITests.swift
//  StarWars
//
//  Created by JoseAlvarez on 10/1/25.
//

import XCTest

final class NoDataViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()

        app.launchEnvironment["UITestingValidForm"] = "1"
        app.launchEnvironment["UITestingForceError"] = "1"

        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testNoDataAlertShowsAndOKDismisses() throws {
        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(submitButton.waitForExistence(timeout: 5), "Submit button should exist")
        submitButton.tap()

        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(errorAlert.waitForExistence(timeout: 5.0), "Expected Error alert to be presented")

        let okButton = errorAlert.buttons["OK"]
        XCTAssertTrue(okButton.exists, "OK button should exist in the Error alert")
        okButton.tap()

        XCTAssertFalse(errorAlert.exists, "Error alert should be dismissed after tapping OK")
    }


    func testNoDataAlertTryAgainTriggersReload() throws {
        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(submitButton.waitForExistence(timeout: 5), "Submit button should exist")
        submitButton.tap()

        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(errorAlert.waitForExistence(timeout: 5.0), "Expected Error alert to be presented")

        let tryAgainButton = errorAlert.buttons["Try Again"]
        XCTAssertTrue(tryAgainButton.exists, "Try Again button should exist in the Error alert")
        tryAgainButton.tap()

        let loadingText = app.staticTexts["Loading planets..."]
        XCTAssertTrue(loadingText.waitForExistence(timeout: 5.0), "Expected Loading planets... to appear after tapping Try Again")
    }
}
