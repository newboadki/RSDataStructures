//
//  SinglyLinkedListTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 30/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class FindTailInNodeTests: XCTestCase {
    
    func testExample() {
        let n1 = SinglyLinkedListNode<Int>(value: 34)
        let n2 = SinglyLinkedListNode<Int>(value: 35)
        let n3 = SinglyLinkedListNode<Int>(value: 36)
        let n4 = SinglyLinkedListNode<Int>(value: 37)
        
        n1.next = n2
        n2.next = n3
        n3.next = n4
        
        XCTAssertTrue(findTail(in: n1).tail === n4)
        XCTAssertTrue(findTail(in: n2).tail === n4)
        XCTAssertTrue(findTail(in: n4).tail === n4)
        XCTAssertTrue(findTail(in: n4).tail === n4)
    }
    
}

class SinglyLinkedListTests: XCTestCase {
    
    func testAppendOneNodeFromEmptyList() {
        var list = SinglyLinkedList<Int>()
        let n1 = SinglyLinkedListNode<Int>(value: 34)
        list.append(node: n1)
        XCTAssertTrue(list.head === n1)
        XCTAssertTrue(list.tail === n1)
        XCTAssertTrue(list.count == 1, "Found \(list.count)")
    }

    func testAppendMultipleNodesFromEmptyList() {
        var list = SinglyLinkedList<Int>()
        let n1 = SinglyLinkedListNode<Int>(value: 34)
        let n2 = SinglyLinkedListNode<Int>(value: 35)
        let n3 = SinglyLinkedListNode<Int>(value: 36)
        n1.next = n2
        n2.next = n3
        list.append(node: n1)
        XCTAssertTrue(list.head === n1)
        XCTAssertTrue(list.tail === n3)
        XCTAssertTrue(list.count == 3, "Found \(list.count)")
    }

    func testAppendFromNode() {
        let n1 = SinglyLinkedListNode<Int>(value: 34)
        let n2 = SinglyLinkedListNode<Int>(value: 35)
        let n3 = SinglyLinkedListNode<Int>(value: 36)
        let n4 = SinglyLinkedListNode<Int>(value: 37)
        
        var list = SinglyLinkedList<Int>(head: n1)
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
        let n1 = SinglyLinkedListNode<Int>(value: 1)
        let n2 = SinglyLinkedListNode<Int>(value: 2)
        let n3 = SinglyLinkedListNode<Int>(value: 3)
        let n4 = SinglyLinkedListNode<Int>(value: 4)
        let n5 = SinglyLinkedListNode<Int>(value: 5)
        
        var list = SinglyLinkedList<Int>(head: n1)
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
    
    /*
    func testDeleteDuplicates() {
        let n1 = SinglyLinkedListNode<Int>(value: 2)
        let n2 = SinglyLinkedListNode<Int>(value: 2)
        let n3 = SinglyLinkedListNode<Int>(value: 3)
        let n4 = SinglyLinkedListNode<Int>(value: 5)
        let n5 = SinglyLinkedListNode<Int>(value: 2)
        let n6 = SinglyLinkedListNode<Int>(value: 4)
        let n7 = SinglyLinkedListNode<Int>(value: 2)
        let n8 = SinglyLinkedListNode<Int>(value: 5)
        
        var list = SinglyLinkedList<Int>(head: n1)
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
    */
    
    func testDeleteDuplicatesInPlace() {
        let n1 = SinglyLinkedListNode<Int>(value: 2)
        let n2 = SinglyLinkedListNode<Int>(value: 2)
        let n3 = SinglyLinkedListNode<Int>(value: 3)
        let n4 = SinglyLinkedListNode<Int>(value: 5)
        let n5 = SinglyLinkedListNode<Int>(value: 2)
        let n6 = SinglyLinkedListNode<Int>(value: 4)
        let n7 = SinglyLinkedListNode<Int>(value: 2)
        let n8 = SinglyLinkedListNode<Int>(value: 5)
        
        var list = SinglyLinkedList<Int>(head: n1)
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
        let list: SinglyLinkedList<Int> = [2,2,3,5,2,4,2,5]
        XCTAssertTrue(list.find(kthToLast: 1)?.value == 5)
        XCTAssertTrue(list.find(kthToLast: 2)?.value == 2)
        XCTAssertTrue(list.find(kthToLast: 3)?.value == 4)
        XCTAssertTrue(list.find(kthToLast: 4)?.value == 2)
        XCTAssertTrue(list.find(kthToLast: 5)?.value == 5)
        XCTAssertTrue(list.find(kthToLast: 6)?.value == 3)
        XCTAssertTrue(list.find(kthToLast: 7)?.value == 2)
        XCTAssertTrue(list.find(kthToLast: 8)?.value == 2)
        XCTAssertTrue(list.find(kthToLast: 9)?.value == nil)
        XCTAssertFalse(list.containsLoop())
    }
    
    
    func testSumOfNumbersLeftToRight() {
        /*
         This assumes that the numbers we are summing up are 617 + 295 = 912
         However, the lists represent the digits in reverse order to make the summing process easier,
         since we always start with the units (rightmost digits) followed by d*10, d*100, etc.
         */
        let l1: SinglyLinkedList<Int> = [7,1,6]
        let l2: SinglyLinkedList<Int> = [5,9,2]
        let sum = sumLeftToRight(l1: l1, l2: l2)
        let result = string(from: sum)
        XCTAssertTrue(result == "219", "Found \(result)")
    }

    func testSumOfNumbersRightToLeft1() {
        /*
         This assumes that the numbers we are summing up are 716 + 592 = 1308
         Therefore, the summing process iterates from rightmost digit to leftmost digit.
         */
        let l1: SinglyLinkedList<Int> = [7,1,6]
        let l2: SinglyLinkedList<Int> = [5,9,2]
        let sum = sumRightToLeft(l1: l1, l2: l2)
        let result = string(from: sum)
        XCTAssertTrue(result == "1308", "Found \(result)")
    }
    
    func testSumOfNumbersRightToLeft2() {
        /*
         This assumes that the numbers we are summing up are 716 + 592 = 1308
         Therefore, the summing process iterates from rightmost digit to leftmost digit.
         */
        let l1: SinglyLinkedList<Int> = [6,1,7]
        let l2: SinglyLinkedList<Int> = [2,9,5]
        let sum = sumRightToLeft(l1: l1, l2: l2)
        let result = string(from: sum)
        XCTAssertTrue(result == "912", "Found \(result)")
    }

    func testContainsLoop() {
        let n1 = SinglyLinkedListNode<Int>(value: 1)
        let n2 = SinglyLinkedListNode<Int>(value: 2)
        let n3 = SinglyLinkedListNode<Int>(value: 3)
        let n4 = SinglyLinkedListNode<Int>(value: 4)
        let n5 = SinglyLinkedListNode<Int>(value: 5)
        let n6 = SinglyLinkedListNode<Int>(value: 6)
        let n7 = SinglyLinkedListNode<Int>(value: 7)
        let n8 = SinglyLinkedListNode<Int>(value: 8)
        n8.next = n2
        
        var list = SinglyLinkedList<Int>(head: n1)
        list.append(node: n2)
        list.append(node: n3)
        list.append(node: n4)
        list.append(node: n5)
        list.append(node: n6)
        list.append(node: n7)
        list.append(node: n8)

        XCTAssertNil(list.tail)
        XCTAssertTrue(list.containsLoop())
    }

    func testContainsLoopFalse() {
        let list: SinglyLinkedList<Int> = [1,2,3,4,5,6,7,8]
        XCTAssertTrue(list.tail?.value == 8, "Found \(String(describing: list.tail?.value))")
        XCTAssertFalse(list.containsLoop())
    }

    func testConstructorFromArrayLiteralWhenEmpty() {
        let list: SinglyLinkedList<Int> = []
        XCTAssertTrue(list.head == nil)
        XCTAssertTrue(list.tail == nil)
        XCTAssertTrue(list.count == 0, "Found \(list.count)")
    }

    func testConstructorFromArrayLiteralWithSingleElement() {
        let list: SinglyLinkedList<Int> = [5]
        XCTAssertTrue(list.head?.value == 5)
        XCTAssertTrue(list.tail?.value == 5)
        XCTAssertTrue(list.count == 1, "Found \(list.count)")
    }
    
    
    func testAppendValue() {
        var list = SinglyLinkedList<Int>()
        list.append(value: 1)
        list.append(value: 1)
        list.append(value: 2)
        list.append(value: 2)
        list.append(value: 4)
        
        let result = string(from: list)
        XCTAssertTrue(result == "11224", "Found \(result)")
        XCTAssertTrue(list.count == 5, "Found \(list.count)")
        XCTAssertTrue(list.tail?.value == 4, "Found \(String(describing: list.tail?.value))")
    }
    
    func testPrependValue() {
        var list = SinglyLinkedList<Int>()
        list.prepend(value: 1)
        list.prepend(value: 2)
        list.prepend(value: 3)
        list.prepend(value: 4)
        list.prepend(value: 5)
        list.prepend(value: 6)
        
        let result = string(from: list)
        XCTAssertTrue(result == "654321", "Found \(result)")
        XCTAssertTrue(list.count == 6, "Found \(list.count)")
        XCTAssertTrue(list.tail?.value == 1, "Found \(String(describing: list.tail?.value))")
    }

    func testDeleteHeadInListWithMultipleItems() {
        var list: SinglyLinkedList<Int> = [1,2,3,4,5,6,7,8]
        
        let _ = list.deleteItem(at: 0)
        let result = string(from: list)
        XCTAssertTrue(result == "2345678", "Found \(result)")
        XCTAssertTrue(list.head?.value == 2, "Found \(String(describing: list.head?.value))")
        XCTAssertTrue(list.count == 7, "Found \(list.count)")
    }

    func testDeleteTailInListWithMultipleItems() {
        var list: SinglyLinkedList<Int> = [1,2,3,4,5,6,7,8]
        
        let _ = list.deleteItem(at: 7)
        let result = string(from: list)
        XCTAssertTrue(result == "1234567", "Found \(result)")
        XCTAssertTrue(list.tail?.value == 7, "Found \(String(describing: list.tail?.value))")
        XCTAssertTrue(list.count == 7, "Found \(list.count)")
    }

    func testDeleteItemInListWithMultipleItems() {
        var list: SinglyLinkedList<Int> = [1,2,3,4,5,6,7,8]
        
        let _ = list.deleteItem(at: 4)
        let result = string(from: list)
        XCTAssertTrue(result == "1234678", "Found \(result)")
        XCTAssertTrue(list.head?.value == 1, "Found \(String(describing: list.head?.value))")
        XCTAssertTrue(list.tail?.value == 8, "Found \(String(describing: list.tail?.value))")
        XCTAssertTrue(list.count == 7, "Found \(list.count)")
    }

    func testDeleteHeadInListWithSingleElement() {
        var list: SinglyLinkedList<Int> = [1]
        
        let _ = list.deleteItem(at: 0)
        let result = string(from: list)
        XCTAssertTrue(result == "", "Found \(result)")
        XCTAssertTrue(list.head == nil, "Found \(String(describing: list.head))")
        XCTAssertTrue(list.tail == nil, "Found \(String(describing: list.tail))")
        XCTAssertTrue(list.count == 0, "Found \(list.count)")
    }
    
    func testDirectIndexAccess() {
        let list: SinglyLinkedList<Int> = [1,2,3,4,5,6,7,8]        
        let fifthElementIndex = list.index(list.startIndex, offsetBy: 5)
        XCTAssertTrue(list[fifthElementIndex].value == 6 ,  "Found \(list.count)")
    }


    func string(from list: SinglyLinkedList<Int>) -> String {
        var result = ""
        var current = list.head
        while current != nil {
            result += String(describing: (current?.value)!)
            current = current?.next
        }
        
        return result
    }
}

class SinglyLinkedListQueueTests: XCTestCase {
    
    func testQueue() {
        var queue = SinglyLinkedList<Int>()
        
        try! queue.enqueue(item: 1)
        XCTAssertTrue(queue.getFirst()! == 1)
        XCTAssertTrue(queue.count == 1)
     
        try! queue.enqueue(item: 2)
        XCTAssertTrue(queue.getFirst()! == 1)
        XCTAssertTrue(queue.count == 2)

        try! queue.enqueue(item: 3)
        XCTAssertTrue(queue.getFirst()! == 1)
        XCTAssertTrue(queue.count == 3)
        
        XCTAssertTrue(queue.dequeue() == 1)
        XCTAssertTrue(queue.count == 2)

        XCTAssertTrue(queue.dequeue() == 2)
        XCTAssertTrue(queue.count == 1)
        
        XCTAssertTrue(queue.dequeue() == 3)
        XCTAssertTrue(queue.count == 0)

        XCTAssertTrue(queue.dequeue() == nil)
        XCTAssertTrue(queue.count == 0)
        
        try! queue.enqueue(item: 9)
        XCTAssertTrue(queue.getFirst()! == 9)
        XCTAssertTrue(queue.count == 1)

    }
}
