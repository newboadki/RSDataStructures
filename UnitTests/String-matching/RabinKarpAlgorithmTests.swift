//
//  RabinKarpAlgorithmTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 14/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class RabinKarpAlgorithmTests: XCTestCase {
    
    func testExample() {

        let result = findOccurrences(of: "bcd", in: "abcdxccdbcdfghi", base: 256, primeNumber: 997)
        XCTAssert(result  == [1, 8], "Found \(result)")
    }
}
