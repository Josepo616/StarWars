//
//  PlanetsViewModelTests.swift
//  StarWars
//
//  Created by JoseAlvarez on 9/30/25.
//

import XCTest
import Combine
@testable import StarWars

final class PlanetsViewModelTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    override func tearDown() {
        super.tearDown()
        cancellables.removeAll()
    }

    // MARK: - Mocks
    struct MockPlanetsServiceSuccess: PlanetsService {
        func fetchPlanets(from url: String) -> AnyPublisher<[PlanetsModel], APIError> {
            let planet = TestFactory.samplePlanetModel()
            return Just([planet])
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        }
    }

    struct MockPlanetsServiceFailure: PlanetsService {
        func fetchPlanets(from url: String) -> AnyPublisher<[PlanetsModel], APIError> {
            Fail(error: APIError.notFound).eraseToAnyPublisher()
        }
    }

    // MARK: - Tests
    func test_planetsViewModel_loadsPlanets_usingMockService() {
        let vm = PlanetsViewModel(planetsService: MockPlanetsServiceSuccess())
        let exp = expectation(description: "planets loaded")

        vm.$planets.dropFirst()
            .sink { planets in
                XCTAssertEqual(planets.count, 1)
                XCTAssertEqual(planets.first?.name, "Tatooine")
                exp.fulfill()
            }
            .store(in: &cancellables)

        vm.loadPlanetsOnStart()
        wait(for: [exp], timeout: 1.0)
    }

    func test_planetsViewModel_handlesFailure_usingMockService() {
        let vm = PlanetsViewModel(planetsService: MockPlanetsServiceFailure())
        let exp = expectation(description: "planets failed")
        
        vm.$planets
            .sink { planets in
                XCTAssertEqual(planets.count, 0)
                exp.fulfill()
            }
            .store(in: &cancellables)
        vm.loadPlanetsOnStart()
        wait(for: [exp], timeout: 3.0)
    }
}
