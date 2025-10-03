//
//  StarWarsTests.swift
//  StarWarsTests
//
//  Created by JoseAlvarez on 10/1/25.
//

import Combine
import XCTest

@testable import StarWars

final class StarWarsTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []
    var service: PlanetsService!

    override func setUpWithError() throws {
        try super.setUpWithError()
        service = MockPlanetsServiceSuccess()
        cancellables = []
    }

    override func tearDownWithError() throws {
        service = nil
        cancellables.removeAll()
        try super.tearDownWithError()
    }

    func testFetchPlanetsSuccessReturnsExpectedData() {
        /// Given
        let exp = expectation(description: "Fetch planets success")
        var resultPlanets: [PlanetsModel]?
        /// When
        service.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("Expected success but got error: \(error)")
                        exp.fulfill()
                    }
                },
                receiveValue: { planets in
                    resultPlanets = planets
                    exp.fulfill()
                }
            )
            .store(in: &cancellables)

        wait(for: [exp], timeout: 1.0)
        /// Then
        XCTAssertEqual(resultPlanets?.first?.name, "Tatooine")
    }
    
    func testDecodePlanetJSON() {
        /// Given
        guard let jsonData = TestFactory.samplePlanetJSON() else {
            XCTFail("Failed to load mock planet JSON.")
            return
        }
        
        let decoder = JSONDecoder()
        do {
            /// When
            let planets = try decoder.decode([PlanetsModel].self, from: jsonData)
            /// Then
            XCTAssertEqual(planets.count, 1)
            XCTAssertEqual(planets.first?.name, "Tatooine")
            XCTAssertEqual(planets.first?.diameter, "10465")
        } catch {
            /// Then
            XCTFail("Failed to decode planet JSON: \(error)")
        }
    }
}
