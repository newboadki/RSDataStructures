//
//  IsPermutationOfPalindromeTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 26/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

// Can only use character between 'a' and 'z' due to simplification in implementation to allow one integer to represent characters
class IsPermutationOfPalindromeTests: XCTestCase {
    
    func testExample() {
        XCTAssertTrue(isPermutationOfPalindrome(str: "oaooo"))
    }

    func testExample1() {
        XCTAssertTrue(isPermutationOfPalindrome(str: "abcdcba"))
    }

    func testExample2() {
        XCTAssertFalse(isPermutationOfPalindrome(str: "madremia"))
    }

    
    func testExample3() {
        XCTAssertTrue(isPermutationOfPalindrome2(str: "oaooo"))
    }
    
    func testExample4() {
        XCTAssertTrue(isPermutationOfPalindrome2(str: "abcdcba"))
    }
    
    func testExample5() {
        XCTAssertFalse(isPermutationOfPalindrome2(str: "madremia"))
    }

}
