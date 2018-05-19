//
//  RabinKarpAlgorithmTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 14/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class RabinKarpAlgorithmTests: XCTestCase {
    
    func testPatternFoundAtBeginning() {
        let result = findOccurrences(of: "bcd", in: "bcdxccdbccfghi", base: 256, primeNumber: 997)
        XCTAssert(result  == [0], "Found \(result)")
    }
    
    func testPatternFoundAtEnd() {
        let result = findOccurrences(of: "bcd", in: "bcfghibcd", base: 256, primeNumber: 997)
        XCTAssert(result  == [6], "Found \(result)")
    }
    
    func testPatternIsTheText() {
        let result = findOccurrences(of: "bcd", in: "bcdbcd", base: 256, primeNumber: 997)
        XCTAssert(result  == [0,3], "Found \(result)")
    }
    
    func testPatternFoundAtSeveralPlaces() {
        let result = findOccurrences(of: "ddda", in: "abdddacdxccdbcdddafghi", base: 256, primeNumber: 997)
        XCTAssert(result  == [2, 14], "Found \(result)")
    }

    func testPatternInLongerText() {
        let result = findOccurrences(of: "bidsankadoutiwyq", in: "abcdxccdoiadshfakndkcnlkdmsafhaiuwekopoqwekmnbbvavcdsiahqoweioqimkjdszhgvabidsankadoutiwyqieofpmklsdzciouqiueuwyrquwehfijbcdfghi", base: 256, primeNumber: 997)
        XCTAssert(result  == [74], "Found \(result)")
    }
    
    func testPatternAlmostNotFound() {
        let result = findOccurrences(of: "bcd", in: "ccd", base: 256, primeNumber: 997)
        XCTAssert(result  == [], "Found \(result)")
    }
    
    func testPatternAlmostNotFound2() {
        let result = findOccurrences(of: "bcd", in: "ccdpkadfnc", base: 256, primeNumber: 997)
        XCTAssert(result  == [], "Found \(result)")
    }
    
    func testPatternAlmostNotFound3() {
        let result = findOccurrences(of: "bcdddpieeeeiueijdkdh", in: "ccdpkadfnc", base: 256, primeNumber: 997)
        XCTAssert(result  == [], "Found \(result)")
    }


}
