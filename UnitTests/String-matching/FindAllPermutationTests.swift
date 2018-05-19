//
//  FindAllPermutationTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 12/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class FindAllPermutationTests: XCTestCase {

    func testMatchAtBeginning() {
        XCTAssert(findAllPermutations(of: "cac", in: "accdicbcbac") == [0])
    }

    func testMatchAtEnd() {
        XCTAssert(findAllPermutations(of: "cac", in: "adicbcbcca") == [7])
    }

    func testMatchInTheMiddle() {
        XCTAssert(findAllPermutations(of: "ddc", in: "adicddcbcddbdcdacc") == [3, 4, 8, 12])
    }

    func testNoMatch() {
        XCTAssert(findAllPermutations(of: "ddc", in: "daaaadcaaaaaadc") == [])
    }

    func testEmptyText() {
        XCTAssert(findAllPermutations(of: "ddc", in: "") == [])
    }

    func testEmptyPattern() {
        XCTAssert(findAllPermutations(of: "", in: "adicddcbcddbdcdacc") == [])
    }
    
    func testEmptyPatternAndEmptyText() {
        XCTAssert(findAllPermutations(of: "", in: "") == [])
    }

    func testTextOnlyContainsThePattern() {
        XCTAssert(findAllPermutations(of: "ddca", in: "ddcaddca") == [0,1,2,3,4])
    }
}
