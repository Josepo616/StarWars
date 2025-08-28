//
//  HTTPClient.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/27/25.
//

import Combine
import Foundation

struct HTTPClient {
    
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
                self.handleError(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    // MARK: - Error handling

    private func httpError(for statusCode: Int) -> APIError {
        switch statusCode {
        case 400:
            print("Error: Bad Request (400)")
            return APIError.badRequest
        case 401:
            print("Error: Unauthorized (401)")
            return APIError.unauthorized
        case 403:
            print("Error: Forbidden (403)")
            return APIError.forbidden
        case 404:
            print("Error: Not Found (404)")
            return APIError.notFound
        case 429:
            print("Error: Too Many Requests (429)")
            return APIError.tooManyRequests
        case 500:
            print("Error: Internal Server Error (500)")
            return APIError.serverError
        case 502:
            print("Error: Bad Gateway (502)")
            return APIError.badGateway
        case 503:
            print("Error: Service Unavailable (503)")
            return APIError.serviceUnavailable
        case 504:
            print("Error: Gateway Timeout (504)")
            return APIError.gatewayTimeout
        default:
            print("Error: Unexpected Status Code (\(statusCode))")
            return APIError.unexpectedStatusCode(statusCode)
        }
    }

    private func handleError(_ error: Error) -> APIError {
        if let apiError = error as? APIError {
            print("Error launched manually: \(apiError)")
            return apiError
        }

        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                print(
                    "No internet connection (Code: \(urlError.code.rawValue))"
                )
                return .badConnection

            case .timedOut:
                print("Time response out (Code: \(urlError.code.rawValue))")
                return .timeout

            case .cannotFindHost:
                print(("Host not found (Code: \(urlError.code.rawValue))"))
                return .hostNotFound

            case .cannotConnectToHost:
                print(
                    ("Cannot connect to host (Code: \(urlError.code.rawValue))")
                )
                return .connectionFailed

            case .secureConnectionFailed:
                print(
                    "SSL connection failed, check certificates (Code: \(urlError.code.rawValue))"
                )
                return .sslError

            case .networkConnectionLost:
                print(
                    "Network connection lost (Code: \(urlError.code.rawValue))"
                )
                return .connectionLost

            default:
                print(
                    "Another error occurred: \(urlError.localizedDescription) (Code: \(urlError.code.rawValue))"
                )
                return .badConnection
            }
        }

        if error is DecodingError {
            print("Error in decoding")
            return .decodingError
        }

        print("Unknown error: \(error)")
        return .badResponse
    }
}
