//
//  BasicBinarySearchTreeTraversalTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 14/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class BasicBinarySearchTreeTraversalTests: XCTestCase {
    
    var root:BasicBinarySearchTree<IntegerPair>?
    
    override func setUp() {
        let A1_value = IntegerPair(key:2, value:300)
        let A1 = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: A1_value)
        
        let A_value = IntegerPair(key:5, value:300)
        let A = BasicBinarySearchTree(parent: nil, leftChild: A1, rightChild: nil, value: A_value)
        
        let B_1_1_value = IntegerPair(key:50, value:300)
        let B1_1 = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: B_1_1_value)
        
        let B_1_2_value = IntegerPair(key:66, value:300)
        let B1_2 = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: B_1_2_value)
        
        let B_2_2_value = IntegerPair(key:100, value:300)
        let B2_2 = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: B_2_2_value)
        
        let B_1_value = IntegerPair(key:65, value:300)
        let B1 = BasicBinarySearchTree(parent: nil, leftChild: B1_1, rightChild: B1_2, value: B_1_value)
        
        let B_2_value = IntegerPair(key:79, value:300)
        let B2 = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: B2_2, value: B_2_value)
        
        let B_value = IntegerPair(key:70, value:300)
        let B = BasicBinarySearchTree(parent: nil, leftChild: B1, rightChild: B2, value: B_value)
        
        let R_value = IntegerPair(key:13, value:300)
        self.root = BasicBinarySearchTree(parent: nil, leftChild: A, rightChild: B, value: R_value)
    }
    

    func testTraverseInOrderIterator() {
        let expectation = [2,5,13,50,65,66,70,79,100]
        
        root?.iterator = inOrderTraversalIterator(tree: root!)
        let it = root?.makeIterator()
        var count = 0
        
        while let node = it?.next() {
            XCTAssertTrue(node.key == expectation[count])
            count += 1
        }
        
        XCTAssertNil(it?.next())
        XCTAssertNil(it?.next())
    }
    
    
    func testTraverseInPostOrderIterator() {
        let expectation = [2,5,50,66,65,100,79,70,13]
        
        root?.iterator = postOrderTraversalIterator(tree: root!)
        let it = root?.makeIterator()
        var count = 0
        
        while let node = it?.next() {
            XCTAssertTrue(node.key == expectation[count])
            count += 1
        }
        
        XCTAssertNil(it?.next())
        XCTAssertNil(it?.next())
    }
}
