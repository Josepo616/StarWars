//
//  MockPlanetsServiceFailure.swift
//  StarWars
//
//  Created by JoseAlvarez on 10/3/25.
//

import Combine
@testable import StarWars

struct MockPlanetsServiceFailure: PlanetsService {
    func fetchPlanets(from url: String) -> AnyPublisher<[PlanetsModel], APIError> {
        return Fail(error: APIError.notFound).eraseToAnyPublisher()
    }
}
