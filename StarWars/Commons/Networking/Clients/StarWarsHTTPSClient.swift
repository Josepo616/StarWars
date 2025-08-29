//
//  StarWarsHTTPSClient.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/27/25.
//

import Combine
import Foundation

struct StarWarsHTTPSClient: PlanetsService {

    func fetchPlanets(from url: String) -> AnyPublisher<
        [PlanetsModel], APIError
    > {
        return getMethod(from: url, type: [PlanetsModel].self)
    }

    func getMethod<T: Decodable>(
        from urlString: String,
        type: T.Type,
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<T, APIError> {

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return Fail(error: APIError.badUrl).eraseToAnyPublisher()
        }

        let urlRequest = URLRequest(url: url)

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
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
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                self.urlError(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Error handling

    private func httpError(for statusCode: Int) -> APIError {
        switch statusCode {
        case 400:
            return APIError.badRequest
        case 401:
            return APIError.unauthorized
        case 403:
            return APIError.forbidden
        case 404:
            return APIError.notFound
        case 429:
            return APIError.tooManyRequests
        case 500:
            return APIError.serverError
        case 502:
            return APIError.badGateway
        case 503:
            return APIError.serviceUnavailable
        case 504:
            return APIError.gatewayTimeout
        default:
            return APIError.unexpectedStatusCode(statusCode)
        }
    }

    private func urlError(_ error: Error) -> APIError {

        if let apiError = error as? APIError {
            return apiError
        }

        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return .noConnection

            case .timedOut:
                return .timeout

            case .cannotFindHost:
                return .hostNotFound

            case .cannotConnectToHost:
                return .connectionFailed

            case .secureConnectionFailed:
                return .sslError

            case .networkConnectionLost:
                return .connectionLost

            default:
                return .badConnection
            }
        }

        if error is DecodingError {
            return .decodingError
        }

        return .badResponse
    }
}
