//
//  MockPublisherProvider.swift
//  StarWars
//
//  Created by JoseAlvarez on 10/3/25.
//

import Combine
import Foundation

@testable import StarWars

struct MockPublisherProvider: DataPublisherProviderProtocol {
    let result: Result<(Data, URLResponse), URLError>
    func dataPublisher(for request: URLRequest) -> AnyPublisher<
        (data: Data, response: URLResponse), URLError
    > {
        result
            .map { data, response in (data: data, response: response) }
            .publisher
            .eraseToAnyPublisher()
    }

}
