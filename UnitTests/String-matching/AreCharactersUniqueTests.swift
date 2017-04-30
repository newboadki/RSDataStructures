//
//  AreCharactersUnique.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 23/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

// Can only use character between 'a' and 'z' due to simplification in implementation to allow one integer to represent characters
class AreCharactersUniqueTests: XCTestCase {
    
    func testSucessWhenCharactersAreUnique() {
        XCTAssertTrue(areCharactersUnique(string: "borja"))
        XCTAssertTrue(areCharactersUnique(string: "blank"))
        XCTAssertTrue(areCharactersUnique(string: "rotacines"))
    }
    
    func testFailureWhenCharactersAreNotUnique() {
        XCTAssertFalse(areCharactersUnique(string: "beaver"))
        XCTAssertFalse(areCharactersUnique(string: "ooaoo"))
    }

}
