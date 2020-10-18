//
//  AnyQueueTests.swift
//  
//
//  Created by Borja Arias Drake on 18/10/2020.
//

import XCTest
import RSDataStructures

class AnyQueueTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testArrayBasedHeap() throws {
        let heap = ArrayBasedHeap<IntegerPair>(type: PriorityQueueType.min)
        let boundedHeightQueue = BoundedHeightPriorityQueue<IntegerPair>(type: PriorityQueueType.min, maximumKey: 1000)
        let queues = [AnyQueue(heap), AnyQueue(boundedHeightQueue)]
       
        let item1 = IntegerPair(key:0, value: 1987)
        let item2 = IntegerPair(key:1, value: 1987)

        for q in queues {
            try q.enqueue(item: item1)
            try q.enqueue(item: item2)
        }
        
        
        for q in queues {
            q.dequeue()
            q.dequeue()
            XCTAssertNil(q.dequeue())
        }        
    }
}


