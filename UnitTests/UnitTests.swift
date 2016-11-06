//
//  UnitTests.swift
//  UnitTests
//
//  Created by Borja Arias Drake on 04/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import XCTest

class UnitTests: XCTestCase {
    
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
        
        do {
            try heap.add(item: item1)
            try heap.add(item: item2)
            try heap.add(item: item3)
            try heap.add(item: item4)
            try heap.add(item: item5)
            try heap.add(item: item6)
            try heap.add(item: item7)
            try heap.add(item: item8)
            try heap.add(item: item9)
            try heap.add(item: item10)
            
            heap.printElements()
            
            XCTAssert(heap.count == 10)
            
            XCTAssert( heap.extractTop()?.key == 1492); XCTAssert(heap.count == 9)
            XCTAssert( heap.extractTop()?.key == 1776); XCTAssert(heap.count == 8)
            XCTAssert( heap.extractTop()?.key == 1783); XCTAssert(heap.count == 7)
            XCTAssert( heap.extractTop()?.key == 1804); XCTAssert(heap.count == 6)
            XCTAssert( heap.extractTop()?.key == 1865); XCTAssert(heap.count == 5)
            XCTAssert( heap.extractTop()?.key == 1918); XCTAssert(heap.count == 4)
            XCTAssert( heap.extractTop()?.key == 1941); XCTAssert(heap.count == 3)
            XCTAssert( heap.extractTop()?.key == 1945); XCTAssert(heap.count == 2)
            XCTAssert( heap.extractTop()?.key == 1963); XCTAssert(heap.count == 1)
            XCTAssert( heap.extractTop()?.key == 2001); XCTAssert(heap.count == 0)
            XCTAssert( heap.extractTop() == nil); XCTAssert(heap.count == 0)
            
                        
            try heap.add(item: IntegerPair(key:1492, value: 1987)); XCTAssert(heap.count == 1)
            try heap.add(item: IntegerPair(key:2001, value: 1987)); XCTAssert(heap.count == 2)
            XCTAssert( heap.getTop()?.key == 1492); XCTAssert(heap.count == 2)
            XCTAssert( heap.extractTop()?.key == 1492); XCTAssert(heap.count == 1)
            try heap.add(item: IntegerPair(key:1000, value: 1987)); XCTAssert(heap.count == 2)
            XCTAssert( heap.extractTop()?.key == 1000); XCTAssert(heap.count == 1)
            XCTAssert( heap.extractTop()?.key == 2001); XCTAssert(heap.count == 0)
            XCTAssert( heap.extractTop() == nil); XCTAssert(heap.count == 0)
            
            
           // XCTAssert(heap.capacity == 1000)
            
            
            
        } catch {
            print("ERROR \(error)")
            XCTFail()
        }
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
