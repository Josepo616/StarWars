//
//  httpStatusCode.swift
//  StarWars
//
//  Created by JoseAlvarez on 10/3/25.
//

enum HTTPStatusCode: Int {
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case tooManyRequests = 429
    case serverError = 500
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case unexpectedStatusCode = 418
}
