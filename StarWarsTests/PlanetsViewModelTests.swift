//
//  PlanetsViewModelTests.swift
//  StarWars
//
//  Created by JoseAlvarez on 9/30/25.
//

import Combine
import XCTest

@testable import StarWars

final class PlanetsViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }

    // MARK: - Tests

    func testPlanetsViewModelLoadsPlanetsUsingMockService() {
        /// Given
        let vm = PlanetsViewModel(planetsService: MockPlanetsServiceSuccess())
        let exp = expectation(description: "planets loaded")

        /// When
        vm.$planets
            .dropFirst()
            .sink { planets in
                /// Then
                XCTAssertEqual(planets.count, 1)
                XCTAssertEqual(planets.first?.name, "Tatooine")
                exp.fulfill()
            }
            .store(in: &cancellables)

        vm.loadPlanetsOnStart()
        wait(for: [exp], timeout: 1.0)
    }

    func testPlanetsViewModelHandlesFailureUsingMockService() {
        /// Given
        let vm = PlanetsViewModel(planetsService: MockPlanetsServiceFailure())
        let exp = expectation(description: "planets failed")

        /// When
        vm.$planets
            .sink { planets in
                /// Then
                XCTAssertEqual(planets.count, 0)
                exp.fulfill()
            }
            .store(in: &cancellables)

        vm.loadPlanetsOnStart()
        wait(for: [exp], timeout: 3.0)
    }

    func testTotalPagesCalculationWithExactAndPartialPages() {
        /// Given
        let planets = HelperFunctions.TestFactory.samplePlanets(count: 10)
        let vm = PlanetsViewModel(
            planetsService: MockPlanetsServiceArray(planets: planets)
        )
        let exp = expectation(description: "planets loaded")

        /// When
        vm.$planets
            .dropFirst()
            .sink { loaded in
                if loaded.count == planets.count {
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)

        vm.loadPlanetsOnStart()
        wait(for: [exp], timeout: 1.0)

        /// Then
        XCTAssertEqual(vm.planets.count, 10)
        XCTAssertEqual(vm.totalPages(4), 3)
        XCTAssertEqual(vm.totalPages(5), 2)
        XCTAssertEqual(vm.totalPages(1), 10)
    }

    func testCurrentPageItemsReturnsCorrectSlices() {
        /// Given
        let planets = HelperFunctions.TestFactory.samplePlanets(count: 10)
        let vm = PlanetsViewModel(
            planetsService: MockPlanetsServiceArray(planets: planets)
        )
        let exp = expectation(description: "planets loaded for slicing")

        /// When
        vm.$planets
            .dropFirst()
            .sink { loaded in
                if loaded.count == planets.count {
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)

        vm.loadPlanetsOnStart()
        wait(for: [exp], timeout: 1.0)

        /// Then
        let page0 = vm.currentPageItems(0, 4)
        XCTAssertEqual(page0.count, 4)
        XCTAssertEqual(page0.first?.name, "Planet 1")
        XCTAssertEqual(page0.last?.name, "Planet 4")

        let page1 = vm.currentPageItems(1, 4)
        XCTAssertEqual(page1.count, 4)
        XCTAssertEqual(page1.first?.name, "Planet 5")
        XCTAssertEqual(page1.last?.name, "Planet 8")

        let page2 = vm.currentPageItems(2, 4)
        XCTAssertEqual(page2.count, 2)
        XCTAssertEqual(page2.first?.name, "Planet 9")
        XCTAssertEqual(page2.last?.name, "Planet 10")

        let page3 = vm.currentPageItems(3, 4)
        XCTAssertTrue(page3.isEmpty)
    }
}
