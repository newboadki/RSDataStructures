//
//  BoyerMooreAlgorithmTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 18/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class BoyerMooreAlgorithmTests: XCTestCase {
    
    func testPatternFoundAtBeginning() {
        let result = BoyerMooreAlgorithm.findOccurrences(of: "bcd", in: "bcdxccdbccfghi", vocabularyRadix: 256)
        XCTAssert(result  == [0], "Found \(result)")
    }

    func testPatternAlmostFoundAtBeginning() {
        let result = BoyerMooreAlgorithm.findOccurrences(of: "bcd", in: "ccdxccdbcdfghi", vocabularyRadix: 256)
        XCTAssert(result  == [7], "Found \(result)")
    }

    func testPatternAlmostNotFound() {
        let result = BoyerMooreAlgorithm.findOccurrences(of: "bcd", in: "ccd", vocabularyRadix: 256)
        XCTAssert(result  == [], "Found \(result)")
    }

    func testPatternAlmostNotFound2() {
        let result = BoyerMooreAlgorithm.findOccurrences(of: "bcd", in: "ccdpkadfnc", vocabularyRadix: 256)
        XCTAssert(result  == [], "Found \(result)")
    }

    func testPatternAlmostNotFound3() {
        let result = BoyerMooreAlgorithm.findOccurrences(of: "bcdddpieeeeiueijdkdh", in: "ccdpkadfnc", vocabularyRadix: 256)
        XCTAssert(result  == [], "Found \(result)")
    }

    func testPatternAlmostNotFound4() {
        let result = BoyerMooreAlgorithm.findOccurrences(of: "bcdddpieeeeiueijdkdh", in: "AcdddpieeeeiueijdkdhAcdddpieeeeiueijdkdhAcdddpieeeeiueijdkdhAcdddpieeeeiueijdkdh", vocabularyRadix: 256)
        XCTAssert(result  == [], "Found \(result)")
    }

    
    func testPatternFoundAtEnd() {
        let result = BoyerMooreAlgorithm.findOccurrences(of: "bcd", in: "bcfghibcd", vocabularyRadix: 256)
        XCTAssert(result  == [6], "Found \(result)")
    }
    
    func testPatternIsTheText() {
        let result = BoyerMooreAlgorithm.findOccurrences(of: "bcd", in: "bcdbcd", vocabularyRadix: 256)
        XCTAssert(result  == [0,3], "Found \(result)")
    }
    
    func testPatternFoundAtSeveralPlaces() {
        let result = BoyerMooreAlgorithm.findOccurrences(of: "ddda", in: "abdddacdxccdbcdddafghi", vocabularyRadix: 256)
        XCTAssert(result  == [2, 14], "Found \(result)")
    }
    
    func testPatternInLongerText() {
        let result = BoyerMooreAlgorithm.findOccurrences(of: "bidsankadoutiwyq", in: "abcdxccdoiadshfakndkcnlkdmsafhaiuwekopoqwekmnbbvavcdsiahqoweioqimkjdszhgvabidsankadoutiwyqieofpmklsdzciouqiueuwyrquwehfijbcdfghi", vocabularyRadix: 256)
        XCTAssert(result  == [74], "Found \(result)")
    }
}
