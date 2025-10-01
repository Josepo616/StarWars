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
        let planet = PlanetsModel(
            id: "https://swapi.info/api/planets/1/",
            name: "Tatooine",
            diameter: "10465",
            climate: "arid",
            gravity: "1 standard",
            terrain: "desert",
            population: "200000"
        )
        return Just([planet])
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}

struct MockPlanetsServiceFailure: PlanetsService {
    func fetchPlanets(from url: String) -> AnyPublisher<[PlanetsModel], APIError> {
        return Fail(error: APIError.notFound).eraseToAnyPublisher()
    }
}

struct MockPlanetsServiceEmpty: PlanetsService {
    func fetchPlanets(from url: String) -> AnyPublisher<[PlanetsModel], APIError> {
        return Just<[PlanetsModel]>([]) // respuesta vacía
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}

