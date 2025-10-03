//
//  ErrorMappingTests.swift
//  StarWarsTests
//
//  Created by JoseAlvarez on 10/1/25.
//

import Combine
import XCTest

@testable import StarWars

final class ErrorMappingTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    // MARK: - Setup / Teardown
    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }

    // MARK: - URLError Tests
    func testFetchPlanetsMapsURLErrorToExpectedAPIError() {
        let testCases: [(URLError.Code, APIError)] = [
            (.badURL, .badUrl),
            (.notConnectedToInternet, .noConnection),
            (.timedOut, .timeout),
            (.cannotFindHost, .hostNotFound),
            (.cannotConnectToHost, .connectionFailed),
            (.secureConnectionFailed, .sslError),
            (.networkConnectionLost, .connectionLost),
            (.unsupportedURL, .badConnection),
        ]

        for (urlErrorCode, expectedError) in testCases {
            let error = URLError(urlErrorCode)
            HelperFunctions().performErrorMappingTest(
                result: .failure(error),
                expectedError: expectedError,
                description: "URLError: \(urlErrorCode)"
            )
        }
    }

    // MARK: - Status HTTP Error Tests
    func testFetchPlanetsMapsHTTPStatusCodeToExpectedAPIError() {
        let testCases: [(Int, APIError)] = [
            (400, .badRequest),
            (401, .unauthorized),
            (403, .forbidden),
            (404, .notFound),
            (429, .tooManyRequests),
            (500, .serverError),
            (502, .badGateway),
            (503, .serviceUnavailable),
            (504, .gatewayTimeout),
            (418, .unexpectedStatusCode(418)),
        ]

        for (statusCode, expectedError) in testCases {
            let response = HTTPURLResponse(
                url: URL(string: "https://starwars.api")!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )!
            let dummyData = Data()
            HelperFunctions().performErrorMappingTest(
                result: .success((dummyData, response)),
                expectedError: expectedError,
                description: "HTTPStatus: \(statusCode)"
            )
        }
    }
}
