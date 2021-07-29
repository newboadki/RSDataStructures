//
//  File.swift
//  
//
//  Created by Borja Arias Drake on 26.07.2021..
//

import XCTest
import RSDataStructures

class EnumBasedListTests: XCTestCase {
    
    func testList() throws {
        let l: EnumBasedListCollection<Int> = [3,2,1]
        XCTAssert(l.count == 3)
    }
}

