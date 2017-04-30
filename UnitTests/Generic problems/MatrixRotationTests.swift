//
//  MatrixRotationTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 30/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class MatrixRotation: XCTestCase {
    
    func testExample() {
        
        var m = [[1,2,3,4,5],
                 [6,7,8,9,10],
                 [11,12,13,14,15],
                 [16,17,18,19,20],
                 [21,22,23,24,25]]
        
        let r = [[5,10,15,20,25],
                 [4,9,14,19,24],
                 [3,8,13,18,23],
                 [2,7,12,17,22],
                 [1,6,11,16,21]]

        
        do {
            try rotateMatrix90DegreesToTheLeft(matrix: &m)
            XCTAssertTrue(MatrixRotation.areMatricesEqual(m, r))
        } catch {
            XCTFail()
        }
    }
    
    static func areMatricesEqual<T: Equatable>(_ m: Array<Array<T>>, _ r: Array<Array<T>>) -> Bool {
        for i in (0..<m.count) {
            for j in (0..<m[i].count) {
                if m[i][j] != r[i][j] {
                    return false
                }
            }
        }
        
        return true
    }
}
