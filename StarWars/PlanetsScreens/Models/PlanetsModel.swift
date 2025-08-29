//
//  PlanetsModel.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/27/25.
//

import Foundation

struct PlanetsModel: Decodable, Identifiable {
    let id: String
    let name: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let population: String

    private enum CodingKeys: String, CodingKey {
        case id = "url"
        case name = "name"
        case diameter = "diameter"
        case climate = "climate"
        case gravity = "gravity"
        case terrain = "terrain"
        case population = "population"
    }
}
