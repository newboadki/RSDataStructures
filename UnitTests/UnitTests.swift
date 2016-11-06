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
        let item1 = KeyValuePair<Int, Int>(key: 3, value: 873)
        let item2 = KeyValuePair<Int, Int>(key: 1, value: 873)
        let item3 = KeyValuePair<Int, Int>(key: 34, value: 873)
        let item4 = KeyValuePair<Int, Int>(key: 30, value: 873)
        let item5 = KeyValuePair<Int, Int>(key: 2, value: 873)
        var heap = ArrayBasedHeap<KeyValuePair<Int, Int>>(type: PriorityQueueType.min)
        
        do {
            try heap.add(item: item1)
            try heap.add(item: item2)
            try heap.add(item: item3)
            try heap.add(item: item4)
            try heap.add(item: item5)
            
            XCTAssert(heap.count == 5)
            XCTAssert(heap.capacity == 1000)
            
            
            
        } catch {
            
        }
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
