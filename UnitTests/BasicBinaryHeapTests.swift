//
//  BasicBinaryHeapTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 06/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class BasicBinaryMinHeapTests: XCTestCase {
    
    func testInsertion() {
        let heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type: .min)
        heap.insert(item: p(3))
        heap.insert(item: p(4))
        heap.insert(item: p(6))
        heap.insert(item: p(8))
        heap.insert(item: p(1))
        
        XCTAssertTrue(heap.extractMinimum()?.item.key == 1)
        XCTAssertTrue(heap.minimum()?.item.key == 3)
        
        XCTAssertTrue(heap.extractMinimum()?.item.key == 3)
        XCTAssertTrue(heap.minimum()?.item.key == 4)
        
        XCTAssertTrue(heap.extractMinimum()?.item.key == 4)
        XCTAssertTrue(heap.minimum()?.item.key == 5)
        
        XCTAssertTrue(heap.extractMinimum()?.item.key == 5)
        XCTAssertTrue(heap.minimum()?.item.key == 6)
        
        XCTAssertTrue(heap.extractMinimum()?.item.key == 6)
        XCTAssertTrue(heap.minimum()?.item.key == 8)

        XCTAssertTrue(heap.extractMinimum()?.item.key == 8)
        XCTAssertTrue(heap.minimum() == nil)




    }

}

class BasicBinaryMaxHeapTests: XCTestCase {
    
    func testInsertion() {
        let heap = BasicBinaryHeap<IntegerPair>(value: p(5), parent: nil, leftChild: nil, rightChild: nil, type:.max)        
        heap.insert(item: p(3))
        heap.insert(item: p(4))
        heap.insert(item: p(6))
        heap.insert(item: p(8))
        heap.insert(item: p(1))
        
        XCTAssertTrue(heap.extractMaximum()?.item.key == 8)
        XCTAssertTrue(heap.maximum()?.item.key == 6)
        
        XCTAssertTrue(heap.extractMaximum()?.item.key == 6)
        XCTAssertTrue(heap.maximum()?.item.key == 5)
        
        XCTAssertTrue(heap.extractMaximum()?.item.key == 5)
        XCTAssertTrue(heap.maximum()?.item.key == 4)
        
        XCTAssertTrue(heap.extractMaximum()?.item.key == 4)
        XCTAssertTrue(heap.maximum()?.item.key == 3)
        
        XCTAssertTrue(heap.extractMaximum()?.item.key == 3)
        XCTAssertTrue(heap.maximum()?.item.key == 1)
        
        XCTAssertTrue(heap.extractMaximum()?.item.key == 1)
        XCTAssertTrue(heap.maximum() == nil)
        
        
        
        
    }
    
}
