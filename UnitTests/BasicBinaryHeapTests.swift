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
        
        XCTAssertTrue(heap.extractMinimum()?.item?.key == 1)
        XCTAssertTrue(heap.minimum()?.item?.key == 3)
        
        XCTAssertTrue(heap.extractMinimum()?.item?.key == 3)
        XCTAssertTrue(heap.minimum()?.item?.key == 4)
        
        XCTAssertTrue(heap.extractMinimum()?.item?.key == 4)
        XCTAssertTrue(heap.minimum()?.item?.key == 5)
        
        XCTAssertTrue(heap.extractMinimum()?.item?.key == 5)
        XCTAssertTrue(heap.minimum()?.item?.key == 6)
        
        XCTAssertTrue(heap.extractMinimum()?.item?.key == 6)
        XCTAssertTrue(heap.minimum()?.item?.key == 8)

        XCTAssertTrue(heap.extractMinimum()?.item?.key == 8)
        XCTAssertTrue(heap.minimum() == nil)
        XCTAssertTrue(heap.item == nil)
        XCTAssertTrue(heap.leftChild == nil)
        XCTAssertTrue(heap.rightChild == nil)

        heap.insert(item: p(1))
        XCTAssertTrue(heap.minimum()?.item?.key == 1)

    }
    
    func testInsertionWithReferenceType() {
        let heap = BasicBinaryHeap<DataContainer>(value: DataContainer(key:5.0, value:"adf"), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: DataContainer(key:3.0, value:"adf"))
        heap.insert(item: DataContainer(key:4.0, value:"adf"))
        heap.insert(item: DataContainer(key:6.0, value:"adf"))
        heap.insert(item: DataContainer(key:8.0, value:"adf"))
        heap.insert(item: DataContainer(key:1.0, value:"adf"))
        
        XCTAssertTrue(heap.extractMinimum()?.item?.key == 1.0)
        XCTAssertTrue(heap.minimum()?.item?.key == 3.0)
        
        XCTAssertTrue(heap.extractMinimum()?.item?.key == 3.0)
        XCTAssertTrue(heap.minimum()?.item?.key == 4.0)
        
        XCTAssertTrue(heap.extractMinimum()?.item?.key == 4.0)
        XCTAssertTrue(heap.minimum()?.item?.key == 5.0)
        
        XCTAssertTrue(heap.extractMinimum()?.item?.key == 5.0)
        XCTAssertTrue(heap.minimum()?.item?.key == 6.0)
        
        XCTAssertTrue(heap.extractMinimum()?.item?.key == 6.0)
        XCTAssertTrue(heap.minimum()?.item?.key == 8.0)
        
        XCTAssertTrue(heap.extractMinimum()?.item?.key == 8.0)
        XCTAssertTrue(heap.minimum() == nil)
        XCTAssertTrue(heap.item == nil)
        XCTAssertTrue(heap.leftChild == nil)
        XCTAssertTrue(heap.rightChild == nil)

        heap.insert(item: DataContainer(key: 1.1, value: ""))
        XCTAssertTrue(heap.minimum()?.item?.key == 1.1)

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
        
        XCTAssertTrue(heap.extractMaximum()?.item?.key == 8)
        XCTAssertTrue(heap.maximum()?.item?.key == 6)
        
        XCTAssertTrue(heap.extractMaximum()?.item?.key == 6)
        XCTAssertTrue(heap.maximum()?.item?.key == 5)
        
        XCTAssertTrue(heap.extractMaximum()?.item?.key == 5)
        XCTAssertTrue(heap.maximum()?.item?.key == 4)
        
        XCTAssertTrue(heap.extractMaximum()?.item?.key == 4)
        XCTAssertTrue(heap.maximum()?.item?.key == 3)
        
        XCTAssertTrue(heap.extractMaximum()?.item?.key == 3)
        XCTAssertTrue(heap.maximum()?.item?.key == 1)
        
        XCTAssertTrue(heap.extractMaximum()?.item?.key == 1)
        XCTAssertTrue(heap.maximum() == nil)
        XCTAssertTrue(heap.item == nil)
        XCTAssertTrue(heap.leftChild == nil)
        XCTAssertTrue(heap.rightChild == nil)
        
        heap.insert(item: p(1))
        XCTAssertTrue(heap.maximum()?.item?.key == 1)
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
