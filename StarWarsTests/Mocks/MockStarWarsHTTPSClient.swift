//
//  MockStarWarsHTTPSClient.swift
//  StarWars
//
//  Created by JoseAlvarez on 10/3/25.
//

import Combine
import Foundation

@testable import StarWars

final class MockStarWarsHTTPSClient: PlanetsService,
    StarWarsPlanetsHTTPMethodsProtocol
{

    private let responseData: Data?
    private let error: APIError?

    /// Success case
    init<T: Encodable>(mockedModel: T) {
        self.error = nil
        self.responseData = try? JSONEncoder().encode(mockedModel)
    }

    /// Error case
    init(simulatedError: APIError) {
        self.error = simulatedError
        self.responseData = nil
    }

    func fetchPlanets(from url: String) -> AnyPublisher<
        [PlanetsModel], APIError
    > {
        return getMethod(from: url, type: [PlanetsModel].self, decoder: nil)
    }

    func getMethod<T: Decodable>(
        from urlString: String,
        type: T.Type,
        decoder: JSONDecoder?
    ) -> AnyPublisher<T, APIError> {

        if let error = error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }

        guard let data = responseData else {
            return Fail(error: .decodingError)
                .eraseToAnyPublisher()
        }

        let decoder = decoder ?? JSONDecoder()
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return Just(decoded)
                .setFailureType(to: APIError.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: .decodingError)
                .eraseToAnyPublisher()
        }
    }
}
