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
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_heap_returns_elements_sorted_when_input_was_unsorted() throws {
        let items = unsortedItems()
        let expectedResult = items.sorted { a, b in a < b }
        var heap = ArrayBasedHeap<IntegerPair>(type: .min, elements: items)
        
        XCTAssert(heap.capacity == 10000)
        XCTAssert(heap.count == items.count)
        let dequeuedItems = dequeuedItems(&heap)
        XCTAssert(heap.count == 0)
        XCTAssertTrue(dequeuedItems.elementsEqual(expectedResult))
    }

    func test_heap_returns_elements_sorted_when_input_was_already_sorted() throws {
        let items = sortedItems()
        let expectedResult = items
        var heap = ArrayBasedHeap<IntegerPair>(type: .min, elements: items)
        
        XCTAssert(heap.capacity == 10000)
        XCTAssert(heap.count == items.count)
        let dequeuedItems = dequeuedItems(&heap)
        XCTAssert(heap.count == 0)
        XCTAssertTrue(dequeuedItems.elementsEqual(expectedResult))
    }
    
    func test_inserting_new_element_after_emptying_heap() throws {
        let items = unsortedItems()
        var heap = ArrayBasedHeap<IntegerPair>(type: .min, elements: items)
        
        _ = dequeuedItems(&heap)
        
        try heap.enqueue(item: IntegerPair(key:1492, value: 1987)); XCTAssert(heap.count == 1)
        try heap.enqueue(item: IntegerPair(key:2001, value: 1987)); XCTAssert(heap.count == 2)
        XCTAssert( heap.getFirst()?.key == 1492); XCTAssert(heap.count == 2)
        XCTAssert( heap.dequeue()?.key == 1492); XCTAssert(heap.count == 1)
        try heap.enqueue(item: IntegerPair(key:1000, value: 1987)); XCTAssert(heap.count == 2)
        XCTAssert( heap.dequeue()?.key == 1000); XCTAssert(heap.count == 1)
        XCTAssert( heap.dequeue()?.key == 2001); XCTAssert(heap.count == 0)
        XCTAssert( heap.dequeue() == nil); XCTAssert(heap.count == 0)
    }
}

// MARK: - Helpers
private extension ArrayBasedHeapTests {
    
    func unsortedItems() -> [IntegerPair] {
        return [IntegerPair(key:1963, value: 1987),
                IntegerPair(key:1804, value: 1987),
                IntegerPair(key:1776, value: 1987),
                IntegerPair(key:1783, value: 1987),
                IntegerPair(key:2001, value: 1987),
                IntegerPair(key:1945, value: 1987),
                IntegerPair(key:1918, value: 1987),
                IntegerPair(key:1492, value: 1987),
                IntegerPair(key:1865, value: 1987),
                IntegerPair(key:1941, value: 1987)]
    }

    func sortedItems() -> [IntegerPair] {
        return [IntegerPair(key:1492, value: 1987),
                IntegerPair(key:1776, value: 1987),
                IntegerPair(key:1783, value: 1987),
                IntegerPair(key:1804, value: 1987),
                IntegerPair(key:1865, value: 1987),
                IntegerPair(key:1918, value: 1987),
                IntegerPair(key:1941, value: 1987),
                IntegerPair(key:1945, value: 1987),
                IntegerPair(key:1963, value: 1987),
                IntegerPair(key:2001, value: 1987)]
    }

    
    func dequeuedItems(_ heap: inout ArrayBasedHeap<IntegerPair>) -> [IntegerPair] {
        var dequeuedItems = [IntegerPair]()
        
        while heap.count > 0 {
            if let el = heap.dequeue() {
                dequeuedItems.append(el)
            }
        }
        
        return dequeuedItems
    }
}
