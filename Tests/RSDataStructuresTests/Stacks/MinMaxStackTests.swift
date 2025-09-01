//
//  MinMaxStackTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 07/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest
import RSDataStructures

class MinMaxStackTests: XCTestCase {
    

    func testMin() {
        let ms = MinMaxStack<Int>(type: .min)
        ms.push(item: 5)
        ms.push(item: 2)
        ms.push(item: 7)
        ms.push(item: 3)
        ms.push(item: 1)
        
        XCTAssertTrue(ms.minMaxPeek() == 1)
        
        let _ = ms.pop()
        XCTAssertTrue(ms.minMaxPeek() == 2)
        
        let _ = ms.pop()
        XCTAssertTrue(ms.minMaxPeek() == 2)

        let _ = ms.pop()
        XCTAssertTrue(ms.minMaxPeek() == 2)

        let _ = ms.pop()
        XCTAssertTrue(ms.minMaxPeek() == 5)

        let _ = ms.pop()
        XCTAssertNil(ms.minMaxPeek())

    }

    func testMx() {
        let ms = MinMaxStack<Int>(type: .max)
        ms.push(item: 5)
        ms.push(item: 2)
        ms.push(item: 7)
        ms.push(item: 3)
        ms.push(item: 1)
        
        XCTAssertTrue(ms.minMaxPeek() == 7)
        
        let _ = ms.pop()
        XCTAssertTrue(ms.minMaxPeek() == 7)
        
        let _ = ms.pop()
        XCTAssertTrue(ms.minMaxPeek() == 7)

        let _ = ms.pop()
        XCTAssertTrue(ms.minMaxPeek() == 5)
        
        let _ = ms.pop()
        XCTAssertTrue(ms.minMaxPeek() == 5)
        
        let _ = ms.pop()
        XCTAssertNil(ms.minMaxPeek())
        
    }

}
