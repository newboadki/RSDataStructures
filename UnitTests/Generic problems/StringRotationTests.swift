//
//  StringRotationTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 30/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class StringRotationTests: XCTestCase {
    
    func testSucessScenario() {
        XCTAssertTrue("waterbottle".isRotation(of: "erbottlewat"))
    }

    func testSucessScenario2() {
        XCTAssertTrue("waterbottle".isRotation(of: "aterbottlew"))
    }

    func testfailureScenario() {
        XCTAssertFalse("waterbottle".isRotation(of: "SurmanoRodriguez"))
    }

    func testfailureScenario2() {
        XCTAssertFalse("".isRotation(of: "SurmanoRodriguez"))
        XCTAssertFalse("waterbottle".isRotation(of: ""))
    }

}
