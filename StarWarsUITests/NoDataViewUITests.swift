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
        /// Given
        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(
            submitButton.waitForExistence(timeout: 5),
            "Submit button should exist"
        )
        /// When
        submitButton.tap()
        /// Then
        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(
            errorAlert.waitForExistence(timeout: 5.0),
            "Expected Error alert to be presented"
        )
        /// Then
        let okButton = errorAlert.buttons["OK"]
        XCTAssertTrue(
            okButton.exists,
            "OK button should exist in the Error alert"
        )
        /// When
        okButton.tap()
        /// Then
        XCTAssertFalse(
            errorAlert.exists,
            "Error alert should be dismissed after tapping OK"
        )
    }

    func testNoDataAlertTryAgainTriggersReload() throws {
        /// Given
        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(
            submitButton.waitForExistence(timeout: 5),
            "Submit button should exist"
        )
        /// When
        submitButton.tap()
        /// Then
        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(
            errorAlert.waitForExistence(timeout: 5.0),
            "Expected Error alert to be presented"
        )
        /// Then
        let tryAgainButton = errorAlert.buttons["Try Again"]
        XCTAssertTrue(
            tryAgainButton.exists,
            "Try Again button should exist in the Error alert"
        )
        /// When
        tryAgainButton.tap()
        /// Then
        let loadingText = app.staticTexts["Loading planets..."]
        XCTAssertTrue(
            loadingText.waitForExistence(timeout: 5.0),
            "Expected Loading planets... to appear after tapping Try Again"
        )
    }
}
