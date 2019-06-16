//
//  DragonDetailsViewModelTests.swift
//  DragonsAppTests
//
//  Created by Gabriel Silveira on 15/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//
// swiftlint:disable line_length
// swiftlint:disable force_unwrapping

import XCTest
@testable import DragonsApp

class DragonDetailsViewModelTests: XCTestCase {

    var dragonDetailsViewModel: DragonDetailsViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        let mockedDragon: Dragon = loadJson(filename: "Dragon")!
        dragonDetailsViewModel = DragonDetailsViewModel(dragon: mockedDragon)
    }

    override func tearDown() {
        super.tearDown()
        dragonDetailsViewModel = nil
    }
    
    func testDragonAge() {
        XCTAssertEqual(dragonDetailsViewModel.dragonAge, "Age: 3434")
    }
    
    func testImagePlaceholderTitle() {
        XCTAssertEqual(dragonDetailsViewModel.imagePlaceholderTitle,
                       "Unavailable image")
    }
    
    func testDragonDescription() {
        XCTAssertEqual(dragonDetailsViewModel.dragonDescription,
                       "A beautiful japanese dragon.")
    }
    
    func testDragonImageUrl() {
        XCTAssertEqual(dragonDetailsViewModel.dragonImageUrl,
                       URL(string: "https://stamgent.be/assets/files/site/events/tentoonstellingen/_752x572_crop_center-center/draakblauw.jpg"))
    }
    
    func testNavigationTitle() {
        XCTAssertEqual(dragonDetailsViewModel.navigationTitle, "The japanese dragon")
    }
    
    func testGreetButton() {
        dragonDetailsViewModel.didPressGreetButton()
        XCTAssertEqual(dragonDetailsViewModel.greetingType.value,
                       .whoa)
    }
}
