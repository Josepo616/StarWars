//
//  URLSessionDataPublisher.swift
//  StarWars
//
//  Created by JoseAlvarez on 10/3/25.
//

import Combine
import Foundation

struct URLSessionDataPublisher: DataPublisherProviderProtocol {
    let session: URLSession

    func dataPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        session.dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}
