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
        app.launchEnvironment["UITesting_ShowPagination"] = "1"
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_initialPageIsOne() throws {
        // El host muestra "Current page: X" con accessibilityIdentifier "currentPageLabel"
        let currentPageLabel = app.staticTexts["currentPageLabel"]
        XCTAssertTrue(currentPageLabel.waitForExistence(timeout: 2))
        XCTAssertEqual(currentPageLabel.label, "Current page: 1")
    }

    func test_tappingPageButton_updatesCurrentPageLabel() throws {
        let button3 = app.buttons["pageButton_3"]
        XCTAssertTrue(button3.waitForExistence(timeout: 2))
        button3.tap()

        let currentPageLabel = app.staticTexts["currentPageLabel"]
        XCTAssertTrue(currentPageLabel.waitForExistence(timeout: 2))
        XCTAssertEqual(currentPageLabel.label, "Current page: 3")
    }
    
    func test_tappingPage3_showsFollowingPages() throws {
        // Tap page 3 (index 3 -> label "3")
        let button3 = app.buttons["pageButton_3"]
        XCTAssertTrue(button3.waitForExistence(timeout: 2))
        button3.tap()

        // Now page 4 and 5 should appear in the pagination controls (since window centers around currentPage)
        let button4 = app.buttons["pageButton_4"]
        let button5 = app.buttons["pageButton_5"]

        // If they are offscreen, try to swipe the scrollView until they exist/hittable
        if !button4.exists || !button5.exists || !button4.isHittable {
            let scrollView = app.scrollViews.firstMatch
            if scrollView.exists {
                // try a few swipes to bring buttons into view
                scrollView.swipeLeft()
                scrollView.swipeLeft()
            }
        }

        XCTAssertTrue(button4.waitForExistence(timeout: 2), "Expected page 4 button to exist after tapping page 3")
        XCTAssertTrue(button5.waitForExistence(timeout: 2), "Expected page 5 button to exist after tapping page 3")

        // Optionally tap page 4 and assert label changes
        button4.tap()
        let currentPageLabel = app.staticTexts["currentPageLabel"]
        XCTAssertTrue(currentPageLabel.waitForExistence(timeout: 2))
        XCTAssertEqual(currentPageLabel.label, "Current page: 4")
    }

    func test_tappingLastPageButton_updatesCurrentPageLabel() throws {
        let buttonLast = app.buttons["pageButton_15"]
        XCTAssertTrue(buttonLast.waitForExistence(timeout: 2))
        buttonLast.tap()

        let currentPageLabel = app.staticTexts["currentPageLabel"]
        XCTAssertTrue(currentPageLabel.waitForExistence(timeout: 2))
        XCTAssertEqual(currentPageLabel.label, "Current page: 15")
    }

    func test_ellipsisExists_whenPagesTruncated() throws {
        let ellipsis = app.staticTexts["pagination_ellipsis"]
        XCTAssertTrue(ellipsis.waitForExistence(timeout: 2), "Expected ellipsis identifier to exist")

        // si hace falta hacer scroll para verlo:
        if !ellipsis.isHittable {
            let scrollView = app.scrollViews.firstMatch
            if scrollView.exists {
                scrollView.swipeLeft()
            }
        }
        XCTAssertTrue(ellipsis.exists)
    }

}
