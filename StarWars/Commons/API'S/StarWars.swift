//
//  SWAPIURL.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import Foundation

// MARK: - API model
struct StarWars: Identifiable, Hashable {
    var id: UUID
    var endpoint: String
    var url: URL

    init(id: UUID, endpoint: String, baseURL: URL = URL(string: "https://swapi.info/api")!) {
        self.id = id
        self.endpoint = endpoint
        self.url = baseURL.appendingPathComponent(endpoint)
    }
}

// MARK: - API endpoints
enum endpointEnum: String {
    case planets = "/planets"
    
}
