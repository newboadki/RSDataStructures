//
//  BinarySearchTreeTraversalTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 14/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class BinarySearchTreeTraversalTests: XCTestCase {
    
    var root: BinarySearchTree<IntegerPair>?
    
    override func setUp() {
        let A1_value = IntegerPair(key:2, value:300)
        let A1 = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: A1_value)
        
        let A_value = IntegerPair(key:5, value:300)
        let A = BinarySearchTree(parent: nil, leftChild: A1, rightChild: nil, value: A_value)
        
        let B_1_1_value = IntegerPair(key:50, value:300)
        let B1_1 = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: B_1_1_value)
        
        let B_1_2_value = IntegerPair(key:66, value:300)
        let B1_2 = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: B_1_2_value)
        
        let B_2_2_value = IntegerPair(key:100, value:300)
        let B2_2 = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: B_2_2_value)
        
        let B_1_value = IntegerPair(key:65, value:300)
        let B1 = BinarySearchTree(parent: nil, leftChild: B1_1, rightChild: B1_2, value: B_1_value)
        
        let B_2_value = IntegerPair(key:79, value:300)
        let B2 = BinarySearchTree(parent: nil, leftChild: nil, rightChild: B2_2, value: B_2_value)
        
        let B_value = IntegerPair(key:70, value:300)
        let B = BinarySearchTree(parent: nil, leftChild: B1, rightChild: B2, value: B_value)
        
        let R_value = IntegerPair(key:13, value:300)
        self.root = BinarySearchTree(parent: nil, leftChild: A, rightChild: B, value: R_value)
    }
    

    func testTraverseInOrderMethod() {
        var p = Processor<Int>()
        let expectation = [2,5,13,50,65,66,70,79,100]
        
        traverseInOrder(root: root!, processor: &p)
        XCTAssert(p.visited == expectation)
    }

    
    func testTraverseInPostOrderMethod() {
        var p = Processor<Int>()
        let expectation = [2,5,50,66,65,100,79,70,13]
        
        traverseInPostOrder(root: root!, processor: &p)
        XCTAssert(p.visited == expectation)
    }

    
    func testTraverseInOrderIterator() {
        let expectation = [2,5,13,50,65,66,70,79,100]
        //var it = TreeInOrderIterator(tree: root!)
        var it = root?.makeIterator()
        var count = 0
        
        while let node = it?.next() {
            XCTAssertTrue(node.node.key == expectation[count])
            count += 1
        }
        
        XCTAssertNil(it?.next())
        XCTAssertNil(it?.next())
    }
    
    
    func testTraverseInPostOrderIterator() {
        let expectation = [2,5,50,66,65,100,79,70,13]
        //var it = TreePostOrderIterator(tree: root!)
        root?.type = .postOrder
        var it = root?.makeIterator()
        var count = 0
        
        while let node = it?.next() {
            XCTAssertTrue(node.node.key == expectation[count])
            count += 1
        }
        
        XCTAssertNil(it?.next())
        XCTAssertNil(it?.next())
    }
}

struct Processor<U: Comparable> : NodeProcessor {
    
    typealias T = U
    
    var visited = [U]()
    
    mutating func process(element: U) {
        self.visited.append(element)
    }
}

