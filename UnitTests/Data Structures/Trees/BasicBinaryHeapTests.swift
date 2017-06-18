//
//  BasicBinaryHeapTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 06/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class BasicBinaryMinHeapTests: XCTestCase {
    
    func testInsertionWithValueType() {
        let heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(3))
        heap.insert(item: p(4))
        heap.insert(item: p(6))
        heap.insert(item: p(8))
        heap.insert(item: p(1))
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 1)
        XCTAssertTrue(heap.top()?.item?.key == 3)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 3)
        XCTAssertTrue(heap.top()?.item?.key == 4)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 4)
        XCTAssertTrue(heap.top()?.item?.key == 5)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 5)
        XCTAssertTrue(heap.top()?.item?.key == 6)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 6)
        XCTAssertTrue(heap.top()?.item?.key == 8)

        XCTAssertTrue(heap.extractTop()?.item?.key == 8)
        XCTAssertTrue(heap.top() == nil)
        XCTAssertTrue(heap.item == nil)
        XCTAssertTrue(heap.leftChild == nil)
        XCTAssertTrue(heap.rightChild == nil)

        heap.insert(item: p(1))
        XCTAssertTrue(heap.top()?.item?.key == 1)

    }
    
    func testInsertionWithReferenceType() {
        let heap = BasicBinaryHeap<DataContainer>(value: DataContainer(key:5.0, value:"adf"), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: DataContainer(key:3.0, value:"adf"))
        heap.insert(item: DataContainer(key:4.0, value:"adf"))
        heap.insert(item: DataContainer(key:6.0, value:"adf"))
        heap.insert(item: DataContainer(key:8.0, value:"adf"))
        heap.insert(item: DataContainer(key:1.0, value:"adf"))
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 1.0)
        XCTAssertTrue(heap.top()?.item?.key == 3.0)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 3.0)
        XCTAssertTrue(heap.top()?.item?.key == 4.0)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 4.0)
        XCTAssertTrue(heap.top()?.item?.key == 5.0)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 5.0)
        XCTAssertTrue(heap.top()?.item?.key == 6.0)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 6.0)
        XCTAssertTrue(heap.top()?.item?.key == 8.0)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 8.0)
        XCTAssertTrue(heap.top() == nil)
        XCTAssertTrue(heap.item == nil)
        XCTAssertTrue(heap.leftChild == nil)
        XCTAssertTrue(heap.rightChild == nil)

        heap.insert(item: DataContainer(key: 1.1, value: ""))
        XCTAssertTrue(heap.top()?.item?.key == 1.1)
    }
    
    func testNextFreeNode() {
        var heap = BasicBinaryHeap<IntegerPair>(value: p(20), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(15))
        heap.insert(item: p(25))
        heap.insert(item: p(14))
        heap.insert(item: p(16))
        heap.insert(item: p(23))
        heap.insert(item: p(26))
        
        var next = heap.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 20)
        
        heap = BasicBinaryHeap<IntegerPair>(value: p(20), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(15))
        heap.insert(item: p(25))
        heap.insert(item: p(14))
        heap.insert(item: p(16))
        heap.insert(item: p(23))
        next = heap.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 23)
        
        heap = BasicBinaryHeap<IntegerPair>(value: p(20), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(15))
        heap.insert(item: p(25))
        heap.insert(item: p(14))
        heap.insert(item: p(16))
        next = heap.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 25)
        
        heap = BasicBinaryHeap<IntegerPair>(value: p(20), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(15))
        heap.insert(item: p(25))
        heap.insert(item: p(14))
        next = heap.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 15)
        
        heap = BasicBinaryHeap<IntegerPair>(value: p(20), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(15))
        heap.insert(item: p(25))
        next = heap.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 20)
        
        heap = BasicBinaryHeap<IntegerPair>(value: p(20), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(15))
        next = heap.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 15)
        
        heap = BasicBinaryHeap<IntegerPair>(value: p(20), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        next = heap.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 20)
    }
    
    func testBalancedTreeWhenInsertionOrderIsConvenient() {
        let heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(3))
        heap.insert(item: p(7))
        heap.insert(item: p(1))
        heap.insert(item: p(6))
        
        XCTAssertTrue(heap.isBalanced())
    }
    
    func testBalancedTreeWhenInsertionOrderIsUnconvenient() {
        var heap = BasicBinaryHeap<IntegerPair>(value: p(1), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(2))
        heap.insert(item: p(3))
        heap.insert(item: p(4))
        heap.insert(item: p(5))
        heap.insert(item: p(6))
        XCTAssertTrue(heap.isBalanced())
        
        heap = BasicBinaryHeap<IntegerPair>(value: p(7), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(6))
        heap.insert(item: p(5))
        heap.insert(item: p(4))
        heap.insert(item: p(3))
        heap.insert(item: p(2))
        heap.insert(item: p(1))
        XCTAssertTrue(heap.isBalanced())
        
        heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(3))
        heap.insert(item: p(17))
        heap.insert(item: p(1))
        heap.insert(item: p(6))
        heap.insert(item: p(19))
        heap.insert(item: p(20))
        
        XCTAssertTrue(heap.isBalanced())
    }
    
    func testIsBinarySearchTreeFalse() {
        var heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        XCTAssertTrue(heap.isBinarySearchTree())
        heap.insert(item: p(70))
        XCTAssertFalse(heap.isBinarySearchTree())
        
        heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        XCTAssertTrue(heap.isBinarySearchTree())
        heap.insert(item: p(4))
        XCTAssertFalse(heap.isBinarySearchTree())
        heap.insert(item: p(70))
        XCTAssertFalse(heap.isBinarySearchTree())
    }
}


class BasicBinaryMaxHeapTests: XCTestCase {
    
    func testInsertionAndExtraction() {
        let heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type:.max)        
        heap.insert(item: p(3))
        heap.insert(item: p(4))
        heap.insert(item: p(6))
        heap.insert(item: p(8))
        heap.insert(item: p(1))
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 8)
        XCTAssertTrue(heap.maximum()?.item?.key == 6)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 6)
        XCTAssertTrue(heap.maximum()?.item?.key == 5)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 5)
        XCTAssertTrue(heap.maximum()?.item?.key == 4)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 4)
        XCTAssertTrue(heap.maximum()?.item?.key == 3)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 3)
        XCTAssertTrue(heap.maximum()?.item?.key == 1)
        
        XCTAssertTrue(heap.extractTop()?.item?.key == 1)
        XCTAssertTrue(heap.maximum() == nil)
        XCTAssertTrue(heap.item == nil)
        XCTAssertTrue(heap.leftChild == nil)
        XCTAssertTrue(heap.rightChild == nil)
        
        heap.insert(item: p(1))
        XCTAssertTrue(heap.maximum()?.item?.key == 1)
    }
}

class BasicBinaryHeapUpdateTests: XCTestCase {
    
    func testUpdateThatDoesNotCauseBubbling() {
        let heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type:.max)
        heap.insert(item: p(3))
        heap.insert(item: p(4))
        heap.insert(item: p(6))
        heap.insert(item: p(8))
        heap.insert(item: p(1))
        
        // Node with key 1 has key 4 as parent. We set the new value to
        // continue to keep the heap property < 4.
        heap.update(key: 3, to: 2)
        
        // Node with key 5 has key 6 as parent. We set the new value to
        // continue to keep the heap property < 6.
        heap.update(key: 1, to: 3)
        
        // Node with key 6 has key 8 as parent. We set the new value to
        // continue to keep the heap property < 8.
        heap.update(key: 6, to: 7)
        
        // Node with key 8 is the root. We set the new value to
        // continue to keep the heap property >= 8.
        heap.update(key: 8, to: 9)
        
        var keys = [Int]()
        while let top = heap.extractTop() {
            keys.append(top.item!.key)
        }
        let expectation = [9,7,5,4,3,2]
        
        XCTAssertTrue(expectation == keys)
    }
    
    func testUpdateThatCausesBubbling() {
        let heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type:.max)
        heap.insert(item: p(3))
        heap.insert(item: p(4))
        heap.insert(item: p(6))
        heap.insert(item: p(8))
        heap.insert(item: p(1))
        
        // Node with key 1 has key 4 as parent. We set the new value to
        // continue to keep the heap property < 4.
        heap.update(key: 3, to: 10)
        
        // Node with key 5 has key 6 as parent. We set the new value to
        // continue to keep the heap property < 6.
        heap.update(key: 1, to: 9)
        
        // Node with key 6 has key 8 as parent. We set the new value to
        // continue to keep the heap property < 8.
        heap.update(key: 6, to: 7)
        
        // Node with key 8 is the root. We set the new value to
        // continue to keep the heap property >= 8.
        heap.update(key: 10, to: 11)
        
        var keys = [Int]()
        while let top = heap.extractTop() {
            keys.append(top.item!.key)
        }
        let expectation = [11,9,8,7,5,4]
        
        XCTAssertTrue(expectation == keys)
    }
}

final class DataContainer : KeyValuePair {
    
    typealias K = Float
    typealias V = String
    
    
    var key: K
    var value: V
    
    required init(key: Float, value: String) {
        self.key = key
        self.value = value
    }

    func copy() -> DataContainer {
        return DataContainer(key: self.key, value: self.value)
    }
}
