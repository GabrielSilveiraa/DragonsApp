//
//  DragonDetailsViewControllerTests.swift
//  DragonsAppTests
//
//  Created by Gabriel Silveira on 16/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//
// swiftlint:disable force_cast

import XCTest
@testable import DragonsApp

class DragonDetailsViewControllerTests: XCTestCase {
    var dragonDetailsFakeViewModel: FakeDragonDetailsViewModel!
    var dragonDetailsViewController: DragonDetailsViewController!
    
    override func setUp() {
        super.setUp()
        dragonDetailsFakeViewModel = FakeDragonDetailsViewModel()
        dragonDetailsViewController = DragonDetailsViewController(viewModel: dragonDetailsFakeViewModel)
        _ = dragonDetailsViewController.view
    }

    override func tearDown() {
        super.tearDown()
        dragonDetailsFakeViewModel = nil
    }
    
    func testBind() {
        XCTAssertTrue(dragonDetailsFakeViewModel.greetingType.isBinded())
    }
    
    func testGreetinAlert() {
        UIApplication.shared.keyWindow?.rootViewController = dragonDetailsViewController
        dragonDetailsFakeViewModel.greetingType.value = .groar
        XCTAssertTrue(UIApplication.shared.keyWindow?.rootViewController?.presentedViewController is UIAlertController)
        let alert = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController as! UIAlertController
        XCTAssertEqual(alert.message, "Groarrrrrrr!")
    }
    
    func testNavigationTitle() {
        XCTAssertEqual(dragonDetailsViewController.title, "Navigation test")
    }
    
    func testDragonDescriptionLabel() {
        XCTAssertEqual(dragonDetailsViewController.baseView.descriptionLabel.text, "Description test")
    }
    
    func testDragonAgeLabel() {
        XCTAssertEqual(dragonDetailsViewController.baseView.ageLabel.text, "Age test")
    }
    
    func testGreetButton() {
        XCTAssertFalse(dragonDetailsFakeViewModel.greetButtonPressed)
        dragonDetailsViewController.baseView.greetingButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(dragonDetailsFakeViewModel.greetButtonPressed)
    }
    
    func testImagePlaceholder() {
        let label = dragonDetailsViewController.baseView.dragonImageView.subviews.first { $0 is UILabel } as! UILabel
        XCTAssertEqual(label.text, "Placeholder test")
    }
}

class FakeDragonDetailsViewModel: DragonDetailsViewModelProtocol {
    var greetingType: Dynamic<GreetingType?> = Dynamic(nil)
    var imagePlaceholderTitle = "Placeholder test"
    var dragonDescription = "Description test"
    var navigationTitle = "Navigation test"
    var dragonImageUrl: URL?
    var dragonAge = "Age test"
    var greetButtonPressed = false
    
    func didPressGreetButton() {
        greetButtonPressed = true
    }
}
