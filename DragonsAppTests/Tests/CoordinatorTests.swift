//
//  CoordinatorTests.swift
//  DragonsAppTests
//
//  Created by Gabriel Silveira on 12/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//

import XCTest
@testable import DragonsApp

class CoordinatorTests: XCTestCase {
    var coordinator: FakeCoordinator!
    
    override func setUp() {
        super.setUp()
        coordinator = FakeCoordinator()
    }

    override func tearDown() {
        super.tearDown()
        coordinator = nil
    }

    func testCoordinatorStart() {
        coordinator.start()
        XCTAssertTrue(coordinator.hasStarted)
    }
    
    func testAddAndRemoveChildCoordinator() {
        let childCoordinator = FakeCoordinator()
        coordinator.add(childCoordinator: childCoordinator)
        XCTAssertEqual(coordinator.childCoordinators.count, 1)
        coordinator.remove(childCoordinator: childCoordinator)
        XCTAssertEqual(coordinator.childCoordinators.count, 0)
    }
}

class FakeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var hasStarted = false
    
    func start() {
        hasStarted = true
    }
}
