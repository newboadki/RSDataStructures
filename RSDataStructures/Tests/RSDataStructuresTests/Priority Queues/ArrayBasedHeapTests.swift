//
//  UnitTests.swift
//  UnitTests
//
//  Created by Borja Arias Drake on 04/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import XCTest
import RSDataStructures

class ArrayBasedHeapTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testArrayBasedHeap() {
        let item1 = IntegerPair(key:1963, value: 1987)
        let item2 = IntegerPair(key:1804, value: 1987)
        let item3 = IntegerPair(key:1776, value: 1987)
        let item4 = IntegerPair(key:1783, value: 1987)
        let item5 = IntegerPair(key:2001, value: 1987)
        let item6 = IntegerPair(key:1945, value: 1987)
        let item7 = IntegerPair(key:1918, value: 1987)
        let item8 = IntegerPair(key:1492, value: 1987)
        let item9 = IntegerPair(key:1865, value: 1987)
        let item10 = IntegerPair(key:1941, value: 1987)
        var heap = ArrayBasedHeap<IntegerPair>(type: PriorityQueueType.min)
        
        XCTAssert(heap.capacity == 10000)
        
        do {
            try heap.enqueue(item: item1)
            try heap.enqueue(item: item2)
            try heap.enqueue(item: item3)
            try heap.enqueue(item: item4)
            try heap.enqueue(item: item5)
            try heap.enqueue(item: item6)
            try heap.enqueue(item: item7)
            try heap.enqueue(item: item8)
            try heap.enqueue(item: item9)
            try heap.enqueue(item: item10)
            
            XCTAssert(heap.count == 10)
            XCTAssert( heap.dequeue()?.key == 1492); XCTAssert(heap.count == 9)
            XCTAssert( heap.dequeue()?.key == 1776); XCTAssert(heap.count == 8)
            XCTAssert( heap.dequeue()?.key == 1783); XCTAssert(heap.count == 7)
            XCTAssert( heap.dequeue()?.key == 1804); XCTAssert(heap.count == 6)
            XCTAssert( heap.dequeue()?.key == 1865); XCTAssert(heap.count == 5)
            XCTAssert( heap.dequeue()?.key == 1918); XCTAssert(heap.count == 4)
            XCTAssert( heap.dequeue()?.key == 1941); XCTAssert(heap.count == 3)
            XCTAssert( heap.dequeue()?.key == 1945); XCTAssert(heap.count == 2)
            XCTAssert( heap.dequeue()?.key == 1963); XCTAssert(heap.count == 1)
            XCTAssert( heap.dequeue()?.key == 2001); XCTAssert(heap.count == 0)
            XCTAssert( heap.dequeue() == nil); XCTAssert(heap.count == 0)
            
            try heap.enqueue(item: IntegerPair(key:1492, value: 1987)); XCTAssert(heap.count == 1)
            try heap.enqueue(item: IntegerPair(key:2001, value: 1987)); XCTAssert(heap.count == 2)
            XCTAssert( heap.getFirst()?.key == 1492); XCTAssert(heap.count == 2)
            XCTAssert( heap.dequeue()?.key == 1492); XCTAssert(heap.count == 1)
            try heap.enqueue(item: IntegerPair(key:1000, value: 1987)); XCTAssert(heap.count == 2)
            XCTAssert( heap.dequeue()?.key == 1000); XCTAssert(heap.count == 1)
            XCTAssert( heap.dequeue()?.key == 2001); XCTAssert(heap.count == 0)
            XCTAssert( heap.dequeue() == nil); XCTAssert(heap.count == 0)
        } catch {
            XCTFail()
        }
    }
}
