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
        let n1 = SinglyLinkedListNode<Int>(value: 1)
        let n2 = SinglyLinkedListNode<Int>(value: 2)
        let n3 = SinglyLinkedListNode<Int>(value: 3)
        let n4 = SinglyLinkedListNode<Int>(value: 4)
        let n5 = SinglyLinkedListNode<Int>(value: 4)
        let n6 = SinglyLinkedListNode<Int>(value: 3)
        let n7 = SinglyLinkedListNode<Int>(value: 2)
        let n8 = SinglyLinkedListNode<Int>(value: 1)
        
        var list = SinglyLinkedList<Int>(head: n1)
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
        let n1 = SinglyLinkedListNode<Int>(value: 1)
        let n2 = SinglyLinkedListNode<Int>(value: 2)
        let n3 = SinglyLinkedListNode<Int>(value: 3)
        let n4 = SinglyLinkedListNode<Int>(value: 4)
        let n5 = SinglyLinkedListNode<Int>(value: 3)
        let n6 = SinglyLinkedListNode<Int>(value: 2)
        let n7 = SinglyLinkedListNode<Int>(value: 1)
        
        var list = SinglyLinkedList<Int>(head: n1)
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
        let n1 = SinglyLinkedListNode<Int>(value: 1)
        let list = SinglyLinkedList<Int>(head: n1)
        
        XCTAssertTrue(isPalindrome(list: list))
    }

    func testEmptyList()
    {
        let list = SinglyLinkedList<Int>()
        XCTAssertFalse(isPalindrome(list: list))
    }


    func testNegativeEvenExample()
    {
        let n1 = SinglyLinkedListNode<Int>(value: 1)
        let n2 = SinglyLinkedListNode<Int>(value: 2)
        let n3 = SinglyLinkedListNode<Int>(value: 3)
        let n4 = SinglyLinkedListNode<Int>(value: 4)
        let n5 = SinglyLinkedListNode<Int>(value: 4)
        let n6 = SinglyLinkedListNode<Int>(value: 2)
        let n7 = SinglyLinkedListNode<Int>(value: 2)
        let n8 = SinglyLinkedListNode<Int>(value: 1)
        
        var list = SinglyLinkedList<Int>(head: n1)
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
        let n1 = SinglyLinkedListNode<Int>(value: 1)
        let n2 = SinglyLinkedListNode<Int>(value: 3)
        let n3 = SinglyLinkedListNode<Int>(value: 3)
        let n4 = SinglyLinkedListNode<Int>(value: 4)
        let n5 = SinglyLinkedListNode<Int>(value: 3)
        let n6 = SinglyLinkedListNode<Int>(value: 2)
        let n7 = SinglyLinkedListNode<Int>(value: 1)
        
        var list = SinglyLinkedList<Int>(head: n1)
        list.append(node: n2)
        list.append(node: n3)
        list.append(node: n4)
        list.append(node: n5)
        list.append(node: n6)
        list.append(node: n7)
        
        XCTAssertFalse(isPalindrome(list: list))
    }

}
