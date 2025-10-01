//
//  APIError.swift
//  StarWars
//
//  Created by JoseAlvarez on 8/28/25.
//

import Foundation

enum APIError: Error, Equatable {
    // URL / red
    case badUrl
    case badConnection
    case noConnection
    case timeout
    case connectionFailed
    case hostNotFound
    case sslError
    case connectionLost

    // HTTP status
    case badRequest  // 400
    case unauthorized  // 401
    case forbidden  // 403
    case notFound  // 404
    case tooManyRequests  // 429
    case serverError  // 500
    case badGateway  // 502
    case serviceUnavailable  // 503
    case gatewayTimeout  // 504
    case unexpectedStatusCode(Int)

    // Others
    case decodingError
    case badResponse

    var localizedDescription: String {
        switch self {
        // URL / red
        case .badUrl:
            return "The URL is invalid."
        case .noConnection:
            return
                "Unable to connect to the server, check your internet connection."
        case .badConnection:
            return "Unable to connect to the server"
        case .timeout:
            return "The request timed out."
        case .connectionFailed:
            return "The connection failed, check your internet connection."
        case .hostNotFound:
            return "The server could not be found."
        case .sslError:
            return "A secure connection could not be established."
        case .connectionLost:
            return "The network connection was lost."

        // HTTP status
        case .badRequest:
            return "Bad request. Please try again."
        case .unauthorized:
            return "You are not authorized to perform this action."
        case .forbidden:
            return "Access is forbidden."
        case .notFound:
            return "The requested resource was not found."
        case .tooManyRequests:
            return "Too many requests. Please try again later."
        case .serverError:
            return "The server encountered an error. Please try again."
        case .badGateway:
            return "Bad gateway. Try again later."
        case .serviceUnavailable:
            return "The service is currently unavailable."
        case .gatewayTimeout:
            return "The server took too long to respond."
        case .unexpectedStatusCode(let code):
            return "Unexpected error (status code \(code))."

        // Others
        case .decodingError:
            return "Failed to process the server response."
        case .badResponse:
            return "The server returned an invalid response."
        }
    }
}
