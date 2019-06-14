//
//  DragonsListViewModelTests.swift
//  DragonsAppTests
//
//  Created by Gabriel Silveira on 14/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//
// swiftlint:disable force_unwrapping
import XCTest
@testable import DragonsApp

class DragonsListViewModelTests: XCTestCase {
    var dragonsListService: MockDragonsListService!
    
    override func setUp() {
        super.setUp()
        let dragonsMock: [Dragon] = loadJson(filename: "DragonsList")!
        dragonsListService = MockDragonsListService(mock: dragonsMock)
    }

    override func tearDown() {
        super.tearDown()
        dragonsListService = nil
    }
    
    func testGetDragonsSuccess() {
        let dragonsListViewModel = DragonsListViewModel(service: dragonsListService)
        XCTAssertTrue(dragonsListService.getDragonsCalled)
        XCTAssertEqual(dragonsListViewModel.dragonCells.value.count, 9)
        XCTAssertEqual(dragonsListViewModel.dragonCells.value[0].dragonTitle, "The japanese dragon")
    }
    
    func testGetDragonsError() {
        dragonsListService.getDragonsShouldReturnError = true
        let dragonsListViewModel = DragonsListViewModel(service: dragonsListService)
        XCTAssertTrue(dragonsListService.getDragonsCalled)
        XCTAssertEqual(dragonsListViewModel.error.value, "FakeError")
    }
}

class MockDragonsListService: DragonsListServiceProtocol {
    var getDragonsShouldReturnError = false
    private(set) var getDragonsCalled = false
    private let dragons: [Dragon]
    
    init(mock dragons: [Dragon]) {
        self.dragons = dragons
    }
    
    func getDragonsList(completion: @escaping (Result<[Dragon], Error>) -> Void) {
        getDragonsCalled = true
        if !getDragonsShouldReturnError {
            completion(.success(dragons))
        } else {
            completion(.failure(FakeError.whatever))
        }
    }
}
