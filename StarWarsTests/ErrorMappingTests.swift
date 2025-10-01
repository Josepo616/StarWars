//
//  ErrorMappingTests.swift
//  StarWarsTests
//
//  Created by JoseAlvarez on 10/1/25.
//

import XCTest
import Combine
@testable import StarWars

final class ErrorMappingTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Setup / Teardown
    
    override func tearDown() {
        super.tearDown()
        URLProtocolStub.stub(data: nil, response: nil, error: nil)
        cancellables.removeAll()
        URLProtocolStub.observeRequests(nil)
    }
    
    private func makeSessionUsingStub() -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        return URLSession(configuration: config)
    }
    
    // MARK: - URLError Tests
    
    func testGetMethodMapsURLErrorToBadUrl() {
        let urlError = URLError(.badURL)
        URLProtocolStub.stub(data: nil, response: nil, error: urlError)
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive url error")
        var receivedError: APIError?
        client.fetchPlanets(from: "invalid-url")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.badUrl.localizedDescription)
    }

    
    func test_getMethod_mapsURLError_toNoConnection() {
        let urlError = URLError(.notConnectedToInternet)
        URLProtocolStub.stub(data: nil, response: nil, error: urlError)
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive url error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.noConnection.localizedDescription)
    }
    
    func testGetMethodMapsURLErrorToTimeout() {
        let urlError = URLError(.timedOut)
        URLProtocolStub.stub(data: nil, response: nil, error: urlError)
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive url error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.timeout.localizedDescription)
    }
    
    func testGetMethodMapsURLErrorToCannotFindHost() {
        let urlError = URLError(.cannotFindHost)
        URLProtocolStub.stub(data: nil, response: nil, error: urlError)
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive url error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.hostNotFound.localizedDescription)
    }
    
    func testGetMethodMapsURLErrorToCannontConnectToHost() {
        let urlError = URLError(.cannotConnectToHost)
        URLProtocolStub.stub(data: nil, response: nil, error: urlError)
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive url error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.connectionFailed.localizedDescription)
    }
    
    func testGetMethodMapsURLErrorToSecureConnectionFailed() {
        let urlError = URLError(.secureConnectionFailed)
        URLProtocolStub.stub(data: nil, response: nil, error: urlError)
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive url error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.sslError.localizedDescription)
    }
    
    func testGetMethodMapsURLErrorToNetworkConnectionLost() {
        let urlError = URLError(.networkConnectionLost)
        URLProtocolStub.stub(data: nil, response: nil, error: urlError)
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive url error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.connectionLost.localizedDescription)
    }
    
    func testGetMethodMapsURLErrorToAnyURLError() {
        let urlError = URLError(.unsupportedURL)
        URLProtocolStub.stub(data: nil, response: nil, error: urlError)
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive url error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.badConnection.localizedDescription)
    }
    // MARK: - StarWarsHTTPSClient Tests
    
    func test_getMethod_decodesPlanets_on200() {
        let json = TestFactory.samplePlanetJSON()
        let response = HTTPURLResponse(
            url: URL(string: "https://swapi.info/api/planets/")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        URLProtocolStub.stub(data: json, response: response, error: nil)
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "fetch planets")
        var resultPlanets: [PlanetsModel]?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    XCTFail("Expected success but got error: \(err)")
                    exp.fulfill()
                }
            }, receiveValue: { planets in
                resultPlanets = planets
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(resultPlanets?.first?.name, "Tatooine")
    }
    
    // MARK: - Status HTTP Error Tests
    func testGetMethodMapsHTTPStatusToAPIErrorOn400() {
        URLProtocolStub.stub(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "https://swapi.info/api/planets/")!,
                statusCode: 400,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.badRequest.localizedDescription)
    }
    
    func testGetMethodMapsHTTPStatusToAPIErrorOn401() {
        URLProtocolStub.stub(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "https://swapi.info/api/planets/")!,
                statusCode: 401,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.unauthorized.localizedDescription)
    }
    
    func testGetMethodMapsHTTPStatusToAPIErrorOn403() {
        URLProtocolStub.stub(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "https://swapi.info/api/planets/")!,
                statusCode: 403,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.forbidden.localizedDescription)
    }
    
    func testGetMethodMapsHTTPStatusToAPIErrorOn404() {
        URLProtocolStub.stub(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "https://swapi.info/api/planets/")!,
                statusCode: 404,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.notFound.localizedDescription)
    }
    
    func testGetMethodMapsHTTPStatusToAPIErrorOn429() {
        URLProtocolStub.stub(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "https://swapi.info/api/planets/")!,
                statusCode: 429,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.tooManyRequests.localizedDescription)
    }
    
    func testGetMethodMapsHTTPStatusToAPIErrorOn500() {
        URLProtocolStub.stub(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "https://swapi.info/api/planets/")!,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.serverError.localizedDescription)
    }
    
    func testGetMethodMapsHTTPStatusToAPIErrorOn502() {
        URLProtocolStub.stub(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "https://swapi.info/api/planets/")!,
                statusCode: 502,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.badGateway.localizedDescription)
    }
    
    func testGetMethodMapsHTTPStatusToAPIErrorOn503() {
        URLProtocolStub.stub(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "https://swapi.info/api/planets/")!,
                statusCode: 503,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.serviceUnavailable.localizedDescription)
    }
    
    func testGetMethodMapsHTTPStatusToAPIErrorOn505() {
        URLProtocolStub.stub(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "https://swapi.info/api/planets/")!,
                statusCode: 504,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.gatewayTimeout.localizedDescription)
    }
    
    func testGetMethodMapsHTTPStatusToAPIErrorOnAnyOtherStatusCode() {
        URLProtocolStub.stub(
            data: Data(),
            response: HTTPURLResponse(
                url: URL(string: "https://swapi.info/api/planets/")!,
                statusCode: 418,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "receive error")
        var receivedError: APIError?
        
        client.fetchPlanets(from: "https://swapi.info/api/planets/")
            .sink(receiveCompletion: { completion in
                if case .failure(let err) = completion {
                    receivedError = err
                    exp.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Unexpected success")
                exp.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [exp], timeout: 1.0)
        XCTAssertEqual(receivedError?.localizedDescription, APIError.unexpectedStatusCode(418).localizedDescription)
    }
    
    
    
    func test_getMethod_makesGETRequestToExpectedURL() {
        let expectedURL = "https://swapi.info/api/planets/"
        let expRequest = expectation(description: "request observed")
        
        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url?.absoluteString, expectedURL)
            XCTAssertEqual(request.httpMethod, "GET")
            expRequest.fulfill()
        }
        
        URLProtocolStub.stub(
            data: TestFactory.samplePlanetJSON(),
            response: HTTPURLResponse(url: URL(string: expectedURL)!, statusCode: 200, httpVersion: nil, headerFields: nil),
            error: nil
        )
        
        let session = makeSessionUsingStub()
        let client = StarWarsHTTPSClient(session: session)
        let exp = expectation(description: "fetch")
        
        client.fetchPlanets(from: expectedURL)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in exp.fulfill() })
            .store(in: &cancellables)
        
        wait(for: [expRequest, exp], timeout: 1.0)
    }

}
