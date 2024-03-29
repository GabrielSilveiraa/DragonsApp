//
//  DragonModelTests.swift
//  DragonsAppTests
//
//  Created by Gabriel Silveira on 15/06/19.
//  Copyright © 2019 Gabriel Silveira. All rights reserved.
//
// swiftlint:disable force_unwrapping
// swiftlint:disable line_length

import XCTest
@testable import DragonsApp

class DragonModelTests: XCTestCase {
    
    var dragon: Dragon!
    
    func testDecodeDragon() {
        dragon = loadJson(filename: "Dragon")!
        let imageUrl = URL(string: "https://stamgent.be/assets/files/site/events/tentoonstellingen/_752x572_crop_center-center/draakblauw.jpg")!
        let expectedDragon = Dragon(id: 84375012,
                                    age: 3434,
                                    description: "A beautiful japanese dragon.",
                                    title: "The japanese dragon",
                                    image: imageUrl,
                                    greetingType: .whoa)
        XCTAssertEqual(dragon, expectedDragon)
    }
    
    func testDecodeIncompleteDragon() {
        dragon = loadJson(filename: "IncompleteDragon")!
        XCTAssertNil(dragon.title)
        XCTAssertNil(dragon.image)
        XCTAssertEqual(dragon.id, 84375012)
        XCTAssertEqual(dragon.age, 3434)
        XCTAssertEqual(dragon.greetingType, .gr)
        XCTAssertEqual(dragon.description, "A beautiful japanese dragon.")
    }
    
    func testDragonGreetingGroar() {
        dragon = Dragon(id: 1,
                        age: 1,
                        description: "test", title: nil,
                        image: nil,
                        greetingType: .groar)
        XCTAssertEqual(dragon.greetingType.greeting, "Groarrrrrrr!")
    }
    
    func testDragonGreetingRoar() {
        dragon = Dragon(id: 1,
                        age: 1,
                        description: "test", title: nil,
                        image: nil,
                        greetingType: .roar)
        XCTAssertEqual(dragon.greetingType.greeting, "Roarrrrrrrr!")
    }
    
    func testDragonGreetingGr() {
        dragon = Dragon(id: 1,
                        age: 1,
                        description: "test", title: nil,
                        image: nil,
                        greetingType: .gr)
        XCTAssertEqual(dragon.greetingType.greeting, "Grrrrrrrrrrr!")
    }
    
    func testDragonGreetingWhoa() {
        dragon = Dragon(id: 1,
                        age: 1,
                        description: "test", title: nil,
                        image: nil,
                        greetingType: .whoa)
        XCTAssertEqual(dragon.greetingType.greeting, "Whoaaaaaaa")
    }
}
