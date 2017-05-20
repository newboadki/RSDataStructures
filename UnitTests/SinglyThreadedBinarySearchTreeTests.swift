//
//  SinglyThreadedBinarySearchTree.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 18/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest


class SinglyThreadedBinarySearchTreeTests: XCTestCase {

    func testIndexableCollection() {
        let tree = SinglyThreadedBinarySearchTree<IntegerPair>(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 2, value: 3))
        tree.insert(item: IntegerPair(key: 1, value: 3))
        tree.insert(item: IntegerPair(key: 0, value: 3))
        tree.insert(item: IntegerPair(key: 5, value: 3))
        tree.insert(item: IntegerPair(key: 3, value: 3))
        

        let zero = tree.startIndex
        let one = tree.index(zero, offsetBy: 1)
        let two = tree.index(one, offsetBy: 1)
        let three = tree.index(two, offsetBy: 1)
        let four = tree.index(three, offsetBy: 1)
        
        var n = tree[zero]
        XCTAssert(n.key == 0)
        
        n = tree[one]
        XCTAssert(n.key == 1)

        n = tree[two]
        XCTAssert(n.key == 2)

        n = tree[three]
        XCTAssert(n.key == 3)

        n = tree[four]
        XCTAssert(n.key == 5)
    }
    
    func testIteration() {
        let tree = SinglyThreadedBinarySearchTree<IntegerPair>(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 2, value: 3))
        tree.insert(item: IntegerPair(key: 1, value: 3))
        tree.insert(item: IntegerPair(key: 0, value: 3))
        tree.insert(item: IntegerPair(key: 5, value: 3))
        tree.insert(item: IntegerPair(key: 3, value: 3))
        

        let keyExpectation = [0,1,2,3,5]
        let valueExpectation = [3,3,3,3,3]
        var count = 0
        
        for item in tree {
            XCTAssertTrue(item.key == keyExpectation[count])
            XCTAssertTrue(item.value == valueExpectation[count])
            count = count + 1
        }
    }

}

