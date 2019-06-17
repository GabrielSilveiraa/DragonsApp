//
//  NetworkManagerTests.swift
//  DragonsAppTests
//
//  Created by Gabriel Silveira on 13/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//
// swiftlint:disable force_cast
// swiftlint:disable force_unwrapping

import XCTest
@testable import DragonsApp

class NetworkManagerTests: XCTestCase {
    func testServiceStatus401Response() {
        let httpReponse = HTTPURLResponse(statusCode: 401)
        let session = URLSessionMock(response: httpReponse)
        let networkManager = NetworkManager(session: session)
        var serviceResult: Result<Bool, Error>!
        networkManager.request(EndPoint.fake) { (result: Result<Bool, Error>) in
            serviceResult = result
        }
        XCTAssertThrowsError(try serviceResult.get()) { error in
            XCTAssertEqual(error as! NetworkError, NetworkError.authentication)
            XCTAssertEqual(error.localizedDescription, "Authentication failure")
        }
    }
    
    func testServiceStatus501Response() {
        let httpReponse = HTTPURLResponse(statusCode: 501)
        let session = URLSessionMock(response: httpReponse)
        let networkManager = NetworkManager(session: session)
        var serviceResult: Result<Bool, Error>!
        networkManager.request(EndPoint.fake) { (result: Result<Bool, Error>) in
            serviceResult = result
        }
        XCTAssertThrowsError(try serviceResult.get()) { error in
            XCTAssertEqual(error as! NetworkError, NetworkError.badRequest)
            XCTAssertEqual(error.localizedDescription, "Bad request")
        }
    }
    
    func testServiceStatus600Response() {
        let httpReponse = HTTPURLResponse(statusCode: 600)
        let session = URLSessionMock(response: httpReponse)
        let networkManager = NetworkManager(session: session)
        var serviceResult: Result<Bool, Error>!
        networkManager.request(EndPoint.fake) { (result: Result<Bool, Error>) in
            serviceResult = result
        }
        XCTAssertThrowsError(try serviceResult.get()) { error in
            XCTAssertEqual(error as! NetworkError, NetworkError.outdated)
            XCTAssertEqual(error.localizedDescription, "Outdated request")
        }
    }
    
    func testServiceStatus300Response() {
        let httpReponse = HTTPURLResponse(statusCode: 300)
        let session = URLSessionMock(response: httpReponse)
        let networkManager = NetworkManager(session: session)
        var serviceResult: Result<Bool, Error>!
        networkManager.request(EndPoint.fake) { (result: Result<Bool, Error>) in
            serviceResult = result
        }
        XCTAssertThrowsError(try serviceResult.get()) { error in
            XCTAssertEqual(error as! NetworkError, NetworkError.failed)
            XCTAssertEqual(error.localizedDescription, "Request failed")
        }
    }
    
    func testServiceNoConnectionError() {
        let session = URLSessionMock(error: FakeError.whatever)
        let networkManager = NetworkManager(session: session)
        var serviceResult: Result<Bool, Error>!
        networkManager.request(EndPoint.fake) { (result: Result<Bool, Error>) in
            serviceResult = result
        }
        XCTAssertThrowsError(try serviceResult.get()) { error in
            XCTAssertEqual(error as! NetworkError, NetworkError.noConnection)
            XCTAssertEqual(error.localizedDescription, "Check your connection")
        }
    }
    
    func testServiceNoDataError() {
        let httpReponse = HTTPURLResponse(statusCode: 200)
        let session = URLSessionMock(response: httpReponse)
        let networkManager = NetworkManager(session: session)
        var serviceResult: Result<Bool, Error>!
        networkManager.request(EndPoint.fake) { (result: Result<Bool, Error>) in
            serviceResult = result
        }
        XCTAssertThrowsError(try serviceResult.get()) { error in
            XCTAssertEqual(error as! NetworkError, NetworkError.noData)
            XCTAssertEqual(error.localizedDescription, "No data")
        }
    }
    
    func testServiceUnableToDecodeError() {
        let httpReponse = HTTPURLResponse(statusCode: 200)
        let data = Data()
        let session = URLSessionMock(data: data, response: httpReponse)
        let networkManager = NetworkManager(session: session)
        var serviceResult: Result<Bool, Error>!
        networkManager.request(EndPoint.fake) { (result: Result<Bool, Error>) in
            serviceResult = result
        }
        XCTAssertThrowsError(try serviceResult.get()) { error in
            XCTAssertEqual(error as! NetworkError, NetworkError.unableToDecode)
            XCTAssertEqual(error.localizedDescription, "Unable to decode data")
        }
    }
    
    func testServiceNoResponseError() {
        let session = URLSessionMock()
        let networkManager = NetworkManager(session: session)
        var serviceResult: Result<Bool, Error>!
        networkManager.request(EndPoint.fake) { (result: Result<Bool, Error>) in
            serviceResult = result
        }
        XCTAssertThrowsError(try serviceResult.get()) { error in
            XCTAssertEqual(error as! NetworkError, NetworkError.noResponse)
            XCTAssertEqual(error.localizedDescription, "No response")
        }
    }
}

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    // Properties that enable us to set exactly what data or error
    // we want our mocked URLSession to return for any request.
    init(data: Data? = nil, response: HTTPURLResponse? = nil, error: Error? = nil) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        let url = URL(string: "https://demo6649570.mockable.io")!
        self.init(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}

enum FakeError: Error {
    case whatever
}

extension FakeError: LocalizedError {
    var errorDescription: String? {
        return "FakeError"
    }
}

enum EndPoint: EndPointType {
    case fake
    
    var baseURL: URL {
        return URL(string: "https://demo6649570.mockable.io")!
    }
    
    var path: String {
        return "/test"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return .urlEncoding
    }
    
    var parameters: [String : Any] {
        return [:]
    }
}
