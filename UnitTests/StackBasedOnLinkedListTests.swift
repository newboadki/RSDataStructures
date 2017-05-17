//
//  StackBasedOnLinkedListTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 07/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class StackBasedOnLinkedListTests: XCTestCase {

    func testStack() {
        let stack = StackBasedOnLinkedList<Float>()

        XCTAssertNil(stack.peek())
        XCTAssertNil(stack.pop())

        stack.push(item: 63.98)
        stack.push(item: 1.543)
        stack.push(item: 100.0)
        
        
        XCTAssertTrue(stack.peek() == 100.0)
        XCTAssertTrue(stack.pop() == 100.0)
        
        XCTAssertTrue(stack.peek() == 1.54299998) // Swift is rounding
        XCTAssertTrue(stack.pop() == 1.54299998)
        
        XCTAssertTrue(stack.peek() == 63.9799995)
        XCTAssertTrue(stack.pop() == 63.9799995)
        
        XCTAssertNil(stack.peek())
        XCTAssertNil(stack.pop())
    }
}
