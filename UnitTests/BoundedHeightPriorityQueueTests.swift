//
//  BoundedHeightPriorityQueueTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 13/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import XCTest

class BoundedHeightPriorityQueueTests: XCTestCase {
    
    var pq : BoundedHeightPriorityQueue<IntegerPair>!
    
    
    
    override func setUp() {
        pq = BoundedHeightPriorityQueue<IntegerPair>(type: PriorityQueueType.min, maximumKey: 1000)
        do {
            try pq.add(item: IntegerPair(key: 45, value: 0))
            try pq.add(item: IntegerPair(key: 25, value: 0))
            try pq.add(item: IntegerPair(key: 45, value: 0))
            try pq.add(item: IntegerPair(key: 780, value: 0))
            try pq.add(item: IntegerPair(key: 98, value: 0))
            try pq.add(item: IntegerPair(key: 5, value: 0))
            try pq.add(item: IntegerPair(key: 45, value: 0))
            try pq.add(item: IntegerPair(key: 3, value: 0))
            try pq.add(item: IntegerPair(key: 3, value: 0))
            try pq.add(item: IntegerPair(key: 800, value: 0))
            try pq.add(item: IntegerPair(key: 0, value: 0))
            try pq.add(item: IntegerPair(key: 278, value: 0))
            
            XCTAssert(pq.getTop()!.key == 0)            
        } catch {
            XCTFail()
        }
    }
    
    func test_minimum() {
        XCTAssert(pq.getTop()!.key == 0)
    }
    
    func test_extract_top() {
        XCTAssert(pq.extractTop()!.key == 0)
        XCTAssert(pq.extractTop()!.key == 3)
        XCTAssert(pq.extractTop()!.key == 3)
        XCTAssert(pq.extractTop()!.key == 5)
        XCTAssert(pq.extractTop()!.key == 25)
        XCTAssert(pq.extractTop()!.key == 45)
        XCTAssert(pq.extractTop()!.key == 45)
        XCTAssert(pq.extractTop()!.key == 45)
        XCTAssert(pq.extractTop()!.key == 98)
        XCTAssert(pq.extractTop()!.key == 278)
        XCTAssert(pq.extractTop()!.key == 780)
        XCTAssert(pq.extractTop()!.key == 800)
    }


}
