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

        app.launchEnvironment["UITesting_ValidForm"] = "1"
        app.launchEnvironment["UITesting_ForceError"] = "1"

        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_noDataAlert_showsAndOKDismisses() throws {
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


    func test_noDataAlert_tryAgain_triggersReload() throws {
        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(submitButton.waitForExistence(timeout: 5), "Submit button should exist")
        submitButton.tap()

        // Asegúrate de que el error esté presente
        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(errorAlert.waitForExistence(timeout: 5.0), "Expected Error alert to be presented")

        // Toca el botón "Try Again" para intentar recargar
        let tryAgainButton = errorAlert.buttons["Try Again"]
        XCTAssertTrue(tryAgainButton.exists, "Try Again button should exist in the Error alert")
        tryAgainButton.tap()

        // Esperamos que el texto de "Loading planets..." reaparezca, indicando que se está intentando recargar
        let loadingText = app.staticTexts["Loading planets..."]
        XCTAssertTrue(loadingText.waitForExistence(timeout: 5.0), "Expected Loading planets... to appear after tapping Try Again")
    }
}
