//
//  HelperFunctions.swift
//  StarWarsTests
//
//  Created by JoseAlvarez on 10/3/25.
//

import Foundation
import XCTest
import Combine
@testable import StarWars

final class HelperFunctions: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []

    // MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }
    
    func performErrorMappingTest(
        result: Result<(Data, URLResponse), URLError>,
        expectedError: APIError,
        description: String
    ) {
        let mockProvider = MockPublisherProvider(result: result)
        let client = StarWarsHTTPSClient(publisherProvider: mockProvider)

        let exp = expectation(description: description)
        var receivedError: APIError?

        client.fetchPlanets(from: "https://starwars.api")
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        receivedError = error
                        exp.fulfill()
                    }
                },
                receiveValue: { _ in
                    XCTFail("Expected failure but got success")
                    exp.fulfill()
                }
            )
            .store(in: &cancellables)

        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(
            receivedError?.localizedDescription,
            expectedError.localizedDescription,
            "❌ Failed mapping: \(description)"
        )
    }
    
    enum TestFactory {
        static func samplePlanet(id: Int) -> PlanetsModel {
            PlanetsModel(
                id: "https://swapi.info/api/planets/\(id)/",
                name: "Planet \(id)",
                diameter: "\(1000 + id)",
                climate: "climate-\(id)",
                gravity: "\(1 + id % 3) standard",
                terrain: "terrain-\(id)",
                population: "\(1000 * id)"
            )
        }

        static func samplePlanets(count: Int) -> [PlanetsModel] {
            (1...count).map { samplePlanet(id: $0) }
        }
    }
    
    // MARK: - Helpers

    static func fillValidFormExcept<T>(_ vm: SignInViewModel, except keyPath: WritableKeyPath<SignInFormModel, T>) {
        vm.formModel.name = "John"
        vm.formModel.lastName = "Doe"
        vm.formModel.age = 30
        vm.formModel.numberPhone = "12345678"
        vm.formModel.email = "a@b.com"
        vm.formModel.documentType = "ID"
        vm.formModel.documentNumber = "12345678"

        // Set the excluded field to a "bad" value
        switch keyPath {
        case \SignInFormModel.name: vm.formModel.name = ""
        case \SignInFormModel.lastName: vm.formModel.lastName = ""
        case \SignInFormModel.age: vm.formModel.age = 0
        case \SignInFormModel.numberPhone: vm.formModel.numberPhone = ""
        case \SignInFormModel.email: vm.formModel.email = "invalid"
        case \SignInFormModel.documentType: vm.formModel.documentType = ""
        case \SignInFormModel.documentNumber: vm.formModel.documentNumber = ""
        default: break
        }
    }
}
