//
//  TestFactory.swift
//  StarWars
//
//  Created by JoseAlvarez on 9/30/25.
//

import Foundation
@testable import StarWars

enum TestFactory {
    static func samplePlanetModel() -> PlanetsModel {
        PlanetsModel(
            id: "https://swapi.info/api/planets/1/",
            name: "Tatooine",
            diameter: "10465",
            climate: "arid",
            gravity: "1 standard",
            terrain: "desert",
            population: "200000"
        )
    }

    static func samplePlanetJSON() -> Data {
        let planet = samplePlanetModel()
        let dict: [String: Any] = [
            "url": planet.id,
            "name": planet.name,
            "diameter": planet.diameter,
            "climate": planet.climate,
            "gravity": planet.gravity,
            "terrain": planet.terrain,
            "population": planet.population
        ]
        let arr = [dict]
        return try! JSONSerialization.data(withJSONObject: arr, options: [])
    }
}
