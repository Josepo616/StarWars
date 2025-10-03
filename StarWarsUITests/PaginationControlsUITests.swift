//
//  PaginationControlsUITests.swift
//  StarWarsUITests
//
//  Created by JoseAlvarez on 10/1/25.
//

import XCTest

final class PaginationControlsUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchEnvironment["UITestingShowPagination"] = "1"
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testInitialPageIsOne() throws {
        /// Given
        let currentPageLabel = app.staticTexts["currentPageLabel"]
        XCTAssertTrue(currentPageLabel.waitForExistence(timeout: 2))
        /// Then
        XCTAssertEqual(currentPageLabel.label, "Current page: 1")
    }

    func testTappingPageButtonUpdatesCurrentPageLabel() throws {
        /// Given
        let button3 = app.buttons["pageButton3"]
        XCTAssertTrue(button3.waitForExistence(timeout: 2))
        /// When
        button3.tap()
        ///Then
        let currentPageLabel = app.staticTexts["currentPageLabel"]
        XCTAssertTrue(currentPageLabel.waitForExistence(timeout: 2))
        XCTAssertEqual(currentPageLabel.label, "Current page: 3")
    }
    
    func testTappingPage3ShowsFollowingPages() throws {
        /// Given
        let button3 = app.buttons["pageButton3"]
        XCTAssertTrue(button3.waitForExistence(timeout: 2))
        /// When
        button3.tap()
        let button4 = app.buttons["pageButton4"]
        let button5 = app.buttons["pageButton5"]
        if !button4.exists || !button5.exists || !button4.isHittable {
            let scrollView = app.scrollViews.firstMatch
            if scrollView.exists {
                scrollView.swipeLeft()
                scrollView.swipeLeft()
            }
        }
        /// Then
        XCTAssertTrue(button4.waitForExistence(timeout: 2), "Expected page 4 button to exist after tapping page 3")
        XCTAssertTrue(button5.waitForExistence(timeout: 2), "Expected page 5 button to exist after tapping page 3")
        /// Given
        button4.tap()
        /// Then
        let currentPageLabel = app.staticTexts["currentPageLabel"]
        XCTAssertTrue(currentPageLabel.waitForExistence(timeout: 2))
        XCTAssertEqual(currentPageLabel.label, "Current page: 4")
    }

    func testTappingLastPageButtonUpdatesCurrentPageLabel() throws {
        /// Given
        let buttonLast = app.buttons["pageButton15"]
        XCTAssertTrue(buttonLast.waitForExistence(timeout: 2))
        /// When
        buttonLast.tap()
        /// Then
        let currentPageLabel = app.staticTexts["currentPageLabel"]
        XCTAssertTrue(currentPageLabel.waitForExistence(timeout: 2))
        XCTAssertEqual(currentPageLabel.label, "Current page: 15")
    }

    func testEllipsisExistsWhenPagesTruncated() throws {
        /// Given
        let ellipsis = app.staticTexts["paginationEllipsis"]
        XCTAssertTrue(ellipsis.waitForExistence(timeout: 2), "Expected ellipsis identifier to exist")
        if !ellipsis.isHittable {
            let scrollView = app.scrollViews.firstMatch
            if scrollView.exists {
                scrollView.swipeLeft()
            }
        }
        /// Then
        XCTAssertTrue(ellipsis.exists)
    }
}
