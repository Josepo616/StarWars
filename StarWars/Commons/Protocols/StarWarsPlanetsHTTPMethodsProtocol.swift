//
//  StarWarsPlanetsHTTPMethodsProtocol.swift
//  StarWars
//
//  Created by JoseAlvarez on 10/3/25.
//

import Combine
import Foundation

protocol StarWarsPlanetsHTTPMethodsProtocol {
    func getMethod<T: Decodable>(
        from urlString: String,
        type: T.Type,
        decoder: JSONDecoder?
    ) -> AnyPublisher<T, APIError>
}
