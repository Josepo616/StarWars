//
//  PlanetsService.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/29/25.
//

import Foundation
import Combine

protocol PlanetsService {
    
    func fetchPlanets(from url: String) -> AnyPublisher<[PlanetsModel], APIError>
}
