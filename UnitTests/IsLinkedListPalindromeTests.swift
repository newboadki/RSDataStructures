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
        let n1 = SingleLinkedListNode<Int>(value: 1)
        let n2 = SingleLinkedListNode<Int>(value: 2)
        let n3 = SingleLinkedListNode<Int>(value: 3)
        let n4 = SingleLinkedListNode<Int>(value: 4)
        let n5 = SingleLinkedListNode<Int>(value: 4)
        let n6 = SingleLinkedListNode<Int>(value: 3)
        let n7 = SingleLinkedListNode<Int>(value: 2)
        let n8 = SingleLinkedListNode<Int>(value: 1)
        
        var list = SingleLinkedList<Int>(head: n1)
        list.append(node: n2)
        list.append(node: n3)
        list.append(node: n4)
        list.append(node: n5)
        list.append(node: n6)
        list.append(node: n7)
        list.append(node: n8)
        
        XCTAssertTrue(isPalindrome(list: list))
    }
    
    func testPositiveOddExample()
    {
        let n1 = SingleLinkedListNode<Int>(value: 1)
        let n2 = SingleLinkedListNode<Int>(value: 2)
        let n3 = SingleLinkedListNode<Int>(value: 3)
        let n4 = SingleLinkedListNode<Int>(value: 4)
        let n5 = SingleLinkedListNode<Int>(value: 3)
        let n6 = SingleLinkedListNode<Int>(value: 2)
        let n7 = SingleLinkedListNode<Int>(value: 1)
        
        var list = SingleLinkedList<Int>(head: n1)
        list.append(node: n2)
        list.append(node: n3)
        list.append(node: n4)
        list.append(node: n5)
        list.append(node: n6)
        list.append(node: n7)
        
        XCTAssertTrue(isPalindrome(list: list))
    }
    
    func testSingleElement()
    {
        let n1 = SingleLinkedListNode<Int>(value: 1)
        let list = SingleLinkedList<Int>(head: n1)
        
        XCTAssertTrue(isPalindrome(list: list))
    }

    func testEmptyList()
    {
        let list = SingleLinkedList<Int>()
        XCTAssertFalse(isPalindrome(list: list))
    }


    func testNegativeEvenExample()
    {
        let n1 = SingleLinkedListNode<Int>(value: 1)
        let n2 = SingleLinkedListNode<Int>(value: 2)
        let n3 = SingleLinkedListNode<Int>(value: 3)
        let n4 = SingleLinkedListNode<Int>(value: 4)
        let n5 = SingleLinkedListNode<Int>(value: 4)
        let n6 = SingleLinkedListNode<Int>(value: 2)
        let n7 = SingleLinkedListNode<Int>(value: 2)
        let n8 = SingleLinkedListNode<Int>(value: 1)
        
        var list = SingleLinkedList<Int>(head: n1)
        list.append(node: n2)
        list.append(node: n3)
        list.append(node: n4)
        list.append(node: n5)
        list.append(node: n6)
        list.append(node: n7)
        list.append(node: n8)
        
        XCTAssertFalse(isPalindrome(list: list))
    }

    func testNegativeOddExample()
    {
        let n1 = SingleLinkedListNode<Int>(value: 1)
        let n2 = SingleLinkedListNode<Int>(value: 3)
        let n3 = SingleLinkedListNode<Int>(value: 3)
        let n4 = SingleLinkedListNode<Int>(value: 4)
        let n5 = SingleLinkedListNode<Int>(value: 3)
        let n6 = SingleLinkedListNode<Int>(value: 2)
        let n7 = SingleLinkedListNode<Int>(value: 1)
        
        var list = SingleLinkedList<Int>(head: n1)
        list.append(node: n2)
        list.append(node: n3)
        list.append(node: n4)
        list.append(node: n5)
        list.append(node: n6)
        list.append(node: n7)
        
        XCTAssertFalse(isPalindrome(list: list))
    }

}
