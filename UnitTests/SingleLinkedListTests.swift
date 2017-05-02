//
//  SingleLinkedListTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 30/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class FindTailInNodeTests: XCTestCase {
    
    func testExample() {
        let n1 = SingleLinkedListNode<Int>(value: 34)
        let n2 = SingleLinkedListNode<Int>(value: 35)
        let n3 = SingleLinkedListNode<Int>(value: 36)
        let n4 = SingleLinkedListNode<Int>(value: 37)
        
        n1.next = n2
        n2.next = n3
        n3.next = n4
        
        XCTAssertTrue(findTail(in: n1) === n4)
        XCTAssertTrue(findTail(in: n2) === n4)
        XCTAssertTrue(findTail(in: n4) === n4)
        XCTAssertTrue(findTail(in: n4) === n4)
    }
    
}

class SingleLinkedListTests: XCTestCase {
    
    func testAppendingNodes() {
        let n1 = SingleLinkedListNode<Int>(value: 34)
        let n2 = SingleLinkedListNode<Int>(value: 35)
        let n3 = SingleLinkedListNode<Int>(value: 36)
        let n4 = SingleLinkedListNode<Int>(value: 37)
        
        
        var list = SingleLinkedList<Int>(head: n1)
        XCTAssertTrue(list.head === n1)
        XCTAssertTrue(list.tail === n1)
        XCTAssertTrue(list.count == 1, "Found \(list.count)")
        
        list.append(node: n2)
        XCTAssertTrue(list.head === n1)
        XCTAssertTrue(n1.next === n2)
        XCTAssertTrue(list.tail === n2)
        XCTAssertTrue(list.count == 2, "Found \(list.count)")
        
        list.append(node: n3)
        XCTAssertTrue(list.head === n1)
        XCTAssertTrue(n1.next === n2)
        XCTAssertTrue(n2.next === n3)
        XCTAssertTrue(list.tail === n3)
        XCTAssertTrue(list.count == 3, "Found \(list.count)")
        
        list.append(node: n4)
        XCTAssertTrue(list.head === n1)
        XCTAssertTrue(n1.next === n2)
        XCTAssertTrue(n2.next === n3)
        XCTAssertTrue(n3.next === n4)
        XCTAssertTrue(list.tail === n4)
        XCTAssertTrue(list.count == 4, "Found \(list.count)")
    }

    func testDelete() {
        let n1 = SingleLinkedListNode<Int>(value: 1)
        let n2 = SingleLinkedListNode<Int>(value: 2)
        let n3 = SingleLinkedListNode<Int>(value: 3)
        let n4 = SingleLinkedListNode<Int>(value: 4)
        let n5 = SingleLinkedListNode<Int>(value: 5)
        
        
        var list = SingleLinkedList<Int>(head: n1)
        list.append(node: n2)
        list.append(node: n3)
        list.append(node: n4)
        list.append(node: n5)
        
        list.deleteNode(withValue: 1)
        XCTAssertTrue(list.head === n2)
        XCTAssertTrue(n2.next === n3)
        XCTAssertTrue(n3.next === n4)
        XCTAssertTrue(n4.next === n5)
        XCTAssertTrue(list.tail === n5)
        XCTAssertTrue(list.count == 4)
        
        list.deleteNode(withValue: 5)
        XCTAssertTrue(list.head === n2)
        XCTAssertTrue(n2.next === n3)
        XCTAssertTrue(n3.next === n4)
        XCTAssertTrue(n4.next == nil)
        XCTAssertTrue(list.tail === n4)
        XCTAssertTrue(list.count == 3)
        
        list.deleteNode(withValue: 3)
        XCTAssertTrue(list.head === n2)
        XCTAssertTrue(n2.next === n4)
        XCTAssertTrue(n4.next == nil)
        XCTAssertTrue(list.tail === n4)
        XCTAssertTrue(list.count == 2)

        list.deleteNode(withValue: 2)
        XCTAssertTrue(list.head === n4)
        XCTAssertTrue(n4.next == nil)
        XCTAssertTrue(list.tail === n4)
        XCTAssertTrue(list.count == 1)
        
        list.deleteNode(withValue: 4)
        XCTAssertTrue(list.head == nil)
        XCTAssertTrue(list.tail == nil)
        XCTAssertTrue(list.count == 0)
    }
    
    
    
    func testDeleteDuplicates() {
        let n1 = SingleLinkedListNode<Int>(value: 2)
        let n2 = SingleLinkedListNode<Int>(value: 2)
        let n3 = SingleLinkedListNode<Int>(value: 3)
        let n4 = SingleLinkedListNode<Int>(value: 5)
        let n5 = SingleLinkedListNode<Int>(value: 2)
        let n6 = SingleLinkedListNode<Int>(value: 4)
        let n7 = SingleLinkedListNode<Int>(value: 2)
        let n8 = SingleLinkedListNode<Int>(value: 5)
        
        var list = SingleLinkedList<Int>(head: n1)
        list.append(node: n2)
        list.append(node: n3)
        list.append(node: n4)
        list.append(node: n5)
        list.append(node: n6)
        list.append(node: n7)
        list.append(node: n8)
        
        list.deleteDuplicates()
        XCTAssertTrue(list.head === n1)
        XCTAssertTrue(n1.next === n3)
        XCTAssertTrue(n3.next === n4)
        XCTAssertTrue(n4.next === n6)
        XCTAssertTrue(n6.next == nil)
        XCTAssertTrue(list.tail === n6)
        XCTAssertTrue(list.count == 4)
    }
    
    func testDeleteDuplicatesInPlace() {
        let n1 = SingleLinkedListNode<Int>(value: 2)
        let n2 = SingleLinkedListNode<Int>(value: 2)
        let n3 = SingleLinkedListNode<Int>(value: 3)
        let n4 = SingleLinkedListNode<Int>(value: 5)
        let n5 = SingleLinkedListNode<Int>(value: 2)
        let n6 = SingleLinkedListNode<Int>(value: 4)
        let n7 = SingleLinkedListNode<Int>(value: 2)
        let n8 = SingleLinkedListNode<Int>(value: 5)
        
        var list = SingleLinkedList<Int>(head: n1)
        list.append(node: n2)
        list.append(node: n3)
        list.append(node: n4)
        list.append(node: n5)
        list.append(node: n6)
        list.append(node: n7)
        list.append(node: n8)
        
        list.deleteDuplicatesInPlace()
        XCTAssertTrue(list.head === n1)
        XCTAssertTrue(n1.next === n3)
        XCTAssertTrue(n3.next === n4)
        XCTAssertTrue(n4.next === n6)
        XCTAssertTrue(n6.next == nil)
        XCTAssertTrue(list.tail === n6)
        XCTAssertTrue(list.count == 4)
    }
    
    func testFindKthToLast() {
        let n1 = SingleLinkedListNode<Int>(value: 2)
        let n2 = SingleLinkedListNode<Int>(value: 2)
        let n3 = SingleLinkedListNode<Int>(value: 3)
        let n4 = SingleLinkedListNode<Int>(value: 5)
        let n5 = SingleLinkedListNode<Int>(value: 2)
        let n6 = SingleLinkedListNode<Int>(value: 4)
        let n7 = SingleLinkedListNode<Int>(value: 2)
        let n8 = SingleLinkedListNode<Int>(value: 5)
        
        var list = SingleLinkedList<Int>(head: n1)
        list.append(node: n2)
        list.append(node: n3)
        list.append(node: n4)
        list.append(node: n5)
        list.append(node: n6)
        list.append(node: n7)
        list.append(node: n8)

        XCTAssertTrue(list.find(kthToLast: 1) === n8)
        XCTAssertTrue(list.find(kthToLast: 2) === n7)
        XCTAssertTrue(list.find(kthToLast: 3) === n6)
        XCTAssertTrue(list.find(kthToLast: 4) === n5)
        XCTAssertTrue(list.find(kthToLast: 5) === n4)
        XCTAssertTrue(list.find(kthToLast: 6) === n3)
        XCTAssertTrue(list.find(kthToLast: 7) === n2)
        XCTAssertTrue(list.find(kthToLast: 8) === n1)
        XCTAssertTrue(list.find(kthToLast: 9) == nil)
    }
    
    
    func testSumOfNumbers() {
        let a1 = SingleLinkedListNode<Int>(value: 7)
        let a2 = SingleLinkedListNode<Int>(value: 1)
        let a3 = SingleLinkedListNode<Int>(value: 6)
        var l1 = SingleLinkedList<Int>(head: a1)
        l1.append(node: a2)
        l1.append(node: a3)
        
        let b1 = SingleLinkedListNode<Int>(value: 5)
        let b2 = SingleLinkedListNode<Int>(value: 9)
        let b3 = SingleLinkedListNode<Int>(value: 2)
        var l2 = SingleLinkedList<Int>(head: b1)
        l2.append(node: b2)
        l2.append(node: b3)

        let sum = sumLeftToRight(l1: l1, l2: l2)
        printList(list: sum)
    }

    func testSumOfNumbersRightToLeft() {
        let a1 = SingleLinkedListNode<Int>(value: 7)
        let a2 = SingleLinkedListNode<Int>(value: 1)
        let a3 = SingleLinkedListNode<Int>(value: 6)
        var l1 = SingleLinkedList<Int>(head: a1)
        l1.append(node: a2)
        l1.append(node: a3)
        
        let b1 = SingleLinkedListNode<Int>(value: 5)
        let b2 = SingleLinkedListNode<Int>(value: 9)
        let b3 = SingleLinkedListNode<Int>(value: 2)
        var l2 = SingleLinkedList<Int>(head: b1)
        l2.append(node: b2)
        l2.append(node: b3)
        
        let sum = sumRightToLeft(l1: l1, l2: l2)
        printList(list: sum)
    }

    
    func printList(list: SingleLinkedList<Int>) {
        var current = list.head
        while current != nil {
            print("\(String(describing: current?.value))")
            current = current?.next
        }
    }
}
