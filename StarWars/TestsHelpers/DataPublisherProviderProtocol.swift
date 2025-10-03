//
//  DataPublisherProvider.swift
//  StarWars
//
//  Created by JoseAlvarez on 10/3/25.
//

import Combine
import Foundation

protocol DataPublisherProviderProtocol {
    func dataPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}
