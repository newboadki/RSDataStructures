//
//  BoundedHeightPriorityQueueTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 13/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import XCTest
import RSDataStructures

class BoundedHeightPriorityQueueTests: XCTestCase {
    
    var pq : BoundedHeightPriorityQueue<IntegerPair>!
    
    
    
    override func setUp() {
        pq = BoundedHeightPriorityQueue<IntegerPair>(type: PriorityQueueType.min, maximumKey: 1000)
        do {
            try pq.enqueue(item: IntegerPair(key: 45, value: 0))
            try pq.enqueue(item: IntegerPair(key: 25, value: 0))
            try pq.enqueue(item: IntegerPair(key: 45, value: 0))
            try pq.enqueue(item: IntegerPair(key: 780, value: 0))
            try pq.enqueue(item: IntegerPair(key: 98, value: 0))
            try pq.enqueue(item: IntegerPair(key: 5, value: 0))
            try pq.enqueue(item: IntegerPair(key: 45, value: 0))
            try pq.enqueue(item: IntegerPair(key: 3, value: 0))
            try pq.enqueue(item: IntegerPair(key: 3, value: 0))
            try pq.enqueue(item: IntegerPair(key: 800, value: 0))
            try pq.enqueue(item: IntegerPair(key: 2, value: 0))
            try pq.enqueue(item: IntegerPair(key: 278, value: 0))
        } catch {
            XCTFail()
        }
    }
    
    func test_minimum() {
        XCTAssert(pq.getFirst()!.key == 2)
    }
    
    func test_extract_top() {
        XCTAssert(pq.dequeue()!.key == 2)
        XCTAssert(pq.dequeue()!.key == 3)
        XCTAssert(pq.dequeue()!.key == 3)
        XCTAssert(pq.dequeue()!.key == 5)
        XCTAssert(pq.dequeue()!.key == 25)
        XCTAssert(pq.dequeue()!.key == 45)
        XCTAssert(pq.dequeue()!.key == 45)
        XCTAssert(pq.dequeue()!.key == 45)
        XCTAssert(pq.dequeue()!.key == 98)
        XCTAssert(pq.dequeue()!.key == 278)
        XCTAssert(pq.dequeue()!.key == 780)
        XCTAssert(pq.dequeue()!.key == 800)
    }


}
