//
//  DragonsListViewControllerTests.swift
//  DragonsAppTests
//
//  Created by Gabriel Silveira on 14/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//
// swiftlint:disable force_cast
import XCTest
@testable import DragonsApp

class DragonsListViewControllerTests: XCTestCase {
    var fakeDragonsListViewModel: FakeDragonsListViewModel!
    var dragonsListViewController: DragonsListViewController!
    
    override func setUp() {
        super.setUp()
        fakeDragonsListViewModel = FakeDragonsListViewModel()
        dragonsListViewController = DragonsListViewController(viewModel: fakeDragonsListViewModel)
        _ = dragonsListViewController.view
    }

    override func tearDown() {
        super.tearDown()
        fakeDragonsListViewModel = nil
        dragonsListViewController = nil
    }
    
    func testBind() {
        XCTAssertTrue(fakeDragonsListViewModel.loading.isBinded())
        XCTAssertTrue(fakeDragonsListViewModel.dragonCells.isBinded())
        XCTAssertTrue(fakeDragonsListViewModel.error.isBinded())
    }
    
    func testTableViewRow() {
        let tableView = dragonsListViewController.baseView.tableView
        XCTAssertEqual(dragonsListViewController.tableView(tableView, numberOfRowsInSection: 0), 0)
        fakeDragonsListViewModel.dragonCells.value = [DragonsListCellViewModel(model: Dragon(title: "Dragon Test"))]
        XCTAssertEqual(dragonsListViewController.tableView(tableView, numberOfRowsInSection: 0), 1)
        let cell = dragonsListViewController.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, "Dragon Test")
    }
    
    func testShowError() {
        UIApplication.shared.keyWindow?.rootViewController = dragonsListViewController
        fakeDragonsListViewModel.error.value = "Error Test"
        XCTAssertTrue(UIApplication.shared.keyWindow?.rootViewController?.presentedViewController is UIAlertController)
        let alert = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController as! UIAlertController
        XCTAssertEqual(alert.message, "Error Test")
    }
    
    func testLoading() {
        let window = UIWindow()
        window.addSubview(dragonsListViewController.view)
        XCTAssertTrue(dragonsListViewController.baseView.activityIndicator.isHidden)
        fakeDragonsListViewModel.loading.value = true
        XCTAssertFalse(dragonsListViewController.baseView.activityIndicator.isHidden)
    }
}

class FakeDragonsListViewModel: DragonsListViewModelProtocol {
    var dragonCells: Dynamic<[DragonsListCellViewModelProtocol]> = Dynamic([])
    var loading: Dynamic<Bool> = Dynamic(false)
    var error: Dynamic<String?> = Dynamic(nil)
}
