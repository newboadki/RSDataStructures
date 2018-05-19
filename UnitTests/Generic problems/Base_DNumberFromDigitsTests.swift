//
//  Base_DNumberFromDigitsTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 13/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class Base_DNumberFromDigitsTests: XCTestCase {
    
    func testNumberIsCorrectlyFormed() {
        XCTAssert(number(from: [4, 6, 7, 2, 2], base: 10) == Int(46722))
    }

    func testEmptyDigits() {
        XCTAssert(number(from: [], base: 10) == Int(0))
    }

    func testNumberWithZeros() {
        XCTAssert(number(from: [0,0,0,0,9], base: 10) == Int(9))
    }

}
