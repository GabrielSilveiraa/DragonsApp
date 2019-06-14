//
//  DragonsListServiceTests.swift
//  DragonsAppTests
//
//  Created by Gabriel Silveira on 13/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//
// swiftlint:disable force_cast
// swiftlint:disable force_unwrapping
// swiftlint:disable force_try
import XCTest
@testable import DragonsApp

class DragonsListServiceTests: XCTestCase {
    func testServiceSuccessResponse() {
        let path = Bundle(for: type(of: self)).path(forResource: "SuccessDragonsList", ofType: "json")!
        let data = NSData(contentsOfFile: path)! as Data
        let httpReponse = HTTPURLResponse(statusCode: 200)
        let session = URLSessionMock(data: data, response: httpReponse)
        let service = DragonsListService(session: session)
        var dragonsResponse: [Dragon]!
        service.getDragonsList { (result: Result<[Dragon], Error>) in
            dragonsResponse = try! result.get() as [Dragon]
        }
        let expectedDragons: [Dragon] = loadJson(filename: "DragonsList")!
        XCTAssertEqual(dragonsResponse, expectedDragons)
    }
    
    func testServiceResponseError() {
        let path = Bundle(for: type(of: self)).path(forResource: "ErrorDragonsList", ofType: "json")!
        let data = NSData(contentsOfFile: path)! as Data
        let httpReponse = HTTPURLResponse(statusCode: 200)
        let session = URLSessionMock(data: data, response: httpReponse)
        let service = DragonsListService(session: session)
        var serviceResult: Result<[Dragon], Error>!
        service.getDragonsList { (result: Result<[Dragon], Error>) in
            serviceResult = result
        }
        XCTAssertThrowsError(try serviceResult.get()) { error in
            XCTAssertEqual(error as! DragonsListServiceError, DragonsListServiceError.failed)
            XCTAssertEqual(error.localizedDescription, "A requisição falhou")
        }
    }
    
    func testServiceRequestError() {
        let session = URLSessionMock()
        let service = DragonsListService(session: session)
        var serviceResult: Result<[Dragon], Error>!
        service.getDragonsList { (result: Result<[Dragon], Error>) in
            serviceResult = result
        }
        XCTAssertThrowsError(try serviceResult.get())
    }
}
