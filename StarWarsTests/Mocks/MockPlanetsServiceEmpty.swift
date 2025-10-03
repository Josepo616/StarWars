//
//  MockPlanetsServiceEmpty.swift
//  StarWars
//
//  Created by JoseAlvarez on 10/3/25.
//

import Combine
@testable import StarWars

struct MockPlanetsServiceEmpty: PlanetsService {
    func fetchPlanets(from url: String) -> AnyPublisher<[PlanetsModel], APIError> {
        return Just<[PlanetsModel]>([]) // respuesta vacía
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
