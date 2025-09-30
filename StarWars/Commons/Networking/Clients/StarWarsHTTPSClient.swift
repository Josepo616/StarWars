//
//  StarWarsHTTPSClient.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/27/25.
//

import Combine
import Foundation

struct StarWarsHTTPSClient: PlanetsService {

    private let session: URLSession
    private let jsonDecoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.jsonDecoder = decoder
    }

    func fetchPlanets(from url: String) -> AnyPublisher<
        [PlanetsModel], APIError
    > {
        return getMethod(from: url, type: [PlanetsModel].self)
    }

    func getMethod<T: Decodable>(
        from urlString: String,
        type: T.Type,
        decoder: JSONDecoder? = nil
    ) -> AnyPublisher<T, APIError> {

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return Fail(error: APIError.badUrl).eraseToAnyPublisher()
        }

        let urlRequest = URLRequest(url: url)

        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse
                else {
                    throw APIError.badResponse
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    throw self.httpError(for: httpResponse.statusCode)
                }

                return result.data
            }
            .decode(type: T.self, decoder: decoder ?? self.jsonDecoder)
            .mapError { error in
                self.urlError(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Error handling

    private func httpError(for statusCode: Int) -> APIError {
        switch statusCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        case 429: return .tooManyRequests
        case 500: return .serverError
        case 502: return .badGateway
        case 503: return .serviceUnavailable
        case 504: return .gatewayTimeout
        default: return .unexpectedStatusCode(statusCode)
        }
    }

    private func urlError(_ error: Error) -> APIError {

        if let apiError = error as? APIError {
            return apiError
        }

        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet: return .noConnection
            case .timedOut: return .timeout
            case .cannotFindHost: return .hostNotFound
            case .cannotConnectToHost: return .connectionFailed
            case .secureConnectionFailed: return .sslError
            case .networkConnectionLost: return .connectionLost
            default: return .badConnection
            }
        }

        if error is DecodingError {
            return .decodingError
        }

        return .badResponse
    }
}
