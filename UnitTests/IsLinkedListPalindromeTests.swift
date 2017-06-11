//
//  IsLinkedListPalindromeTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 02/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class IsLinkedListPalindromeTests: XCTestCase {
    
    func testPositiveEvenExample()
    {
        let list: SinglyLinkedList<Int> = [1,2,3,4,4,3,2,1]
        XCTAssertTrue(isPalindrome(list: list))
    }
    
    func testPositiveOddExample()
    {
        let list: SinglyLinkedList<Int> = [1,2,3,4,3,2,1]
        XCTAssertTrue(isPalindrome(list: list))
    }
    
    func testSingleElement()
    {
        let list: SinglyLinkedList<Int> = [1]
        XCTAssertTrue(isPalindrome(list: list))
    }
    
    func testEmptyList()
    {
        let list = SinglyLinkedList<Int>()
        XCTAssertFalse(isPalindrome(list: list))
    }
    
    
    func testNegativeEvenExample()
    {
        let list: SinglyLinkedList<Int> = [1,2,3,4,2,2,1]
        XCTAssertFalse(isPalindrome(list: list))
    }
    
    func testNegativeOddExample()
    {
        let list: SinglyLinkedList<Int> = [1,3,3,4,3,2,1]
        XCTAssertFalse(isPalindrome(list: list))
    }
}
