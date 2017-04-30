//
//  SmallDifference.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 29/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class SmallDifferenceTests: XCTestCase {
    
    func testStringsWithSamllDifferences() {
        XCTAssertTrue(differentBy0Or1(s1: "borja", s2: "corja"))
        XCTAssertTrue(differentBy0Or1(s1: "borja", s2: "borjo"))
        XCTAssertTrue(differentBy0Or1(s1: "borja", s2: "bolja"))
        XCTAssertTrue(differentBy0Or1(s1: "borja", s2: "borj"))
    }
    
    func testStringsWithBigDifferences() {
        XCTAssertFalse(differentBy0Or1(s1: "borja", s2: "coeja"))
        XCTAssertFalse(differentBy0Or1(s1: "borja", s2: "borjaaa"))
        XCTAssertFalse(differentBy0Or1(s1: "asdfs", s2: "f"))
        XCTAssertFalse(differentBy0Or1(s1: "borja", s2: ""))
    }
}
