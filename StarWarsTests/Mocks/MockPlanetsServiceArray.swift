//
//  MockPlanetsServiceArray.swift
//  StarWars
//
//  Created by JoseAlvarez on 10/3/25.
//

import Combine
@testable import StarWars

struct MockPlanetsServiceArray: PlanetsService {
    let planets: [PlanetsModel]
    func fetchPlanets(from url: String) -> AnyPublisher<
        [PlanetsModel], APIError
    > {
        Just(planets)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
