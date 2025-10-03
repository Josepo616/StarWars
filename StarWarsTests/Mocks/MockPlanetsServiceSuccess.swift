//
//  MockPlanetsServiceSuccess.swift
//  StarWars
//
//  Created by JoseAlvarez on 9/30/25.
//

import Combine
@testable import StarWars

struct MockPlanetsServiceSuccess: PlanetsService {
    func fetchPlanets(from url: String) -> AnyPublisher<[PlanetsModel], APIError> {
        let planet = TestFactory.samplePlanetModel()
        return Just([planet])
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
