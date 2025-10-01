//
//  URLProtocolStub.swift
//  StarWars
//
//  Created by JoseAlvarez on 9/30/25.
//

import Foundation

// URLProtocolStub.swift (Test target)

final class URLProtocolStub: URLProtocol {
    private static let queue = DispatchQueue(label: "URLProtocolStub.queue")
    private static var _stubData: Data?
    private static var _stubResponse: HTTPURLResponse?
    private static var _stubError: Error?
    private static var _requestObserver: ((URLRequest) -> Void)?

    static var stubData: Data? {
        get { queue.sync { _stubData } }
        set { queue.sync { _stubData = newValue } }
    }
    static var stubResponse: HTTPURLResponse? {
        get { queue.sync { _stubResponse } }
        set { queue.sync { _stubResponse = newValue } }
    }
    static var stubError: Error? {
        get { queue.sync { _stubError } }
        set { queue.sync { _stubError = newValue } }
    }

    static func stub(data: Data?, response: HTTPURLResponse?, error: Error?) {
        queue.sync {
            _stubData = data
            _stubResponse = response
            _stubError = error
        }
    }

    static func observeRequests(_ observer: ((URLRequest) -> Void)?) {
        queue.sync { _requestObserver = observer }
    }

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        // notify observer
        if let observer = URLProtocolStub.queue.sync(execute: { URLProtocolStub._requestObserver }) {
            observer(request)
        }

        if let error = URLProtocolStub.queue.sync(execute: { URLProtocolStub._stubError }) {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            if let response = URLProtocolStub.queue.sync(execute: { URLProtocolStub._stubResponse }) {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            if let data = URLProtocolStub.queue.sync(execute: { URLProtocolStub._stubData }) {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {}
}
