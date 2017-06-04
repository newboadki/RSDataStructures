//
//  RedBlackBinarySearchTreeTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 03/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class RedBlackBinarySearchTreeTests: XCTestCase {
    
    func testMultipleInsertion() {
        let tree: RedBlackBinarySearchTree<IntegerPair> = [p(50),p(23),p(76),p(100),p(40),p(22),p(21),p(20)]
        let paths: [[Int]] = tree.pathsFromRootToLeaves(tree: tree)
        
        XCTAssertTrue(paths[0] == [23,21,20])
        XCTAssertTrue(paths[1] == [23,21,22])
        XCTAssertTrue(paths[2] == [23,50,40])
        XCTAssertTrue(paths[3] == [23,50,100,76])
        XCTAssertTrue(paths.count == 4)
    }
    
    func testInsertingLeftLeaf() {
        let tree: RedBlackBinarySearchTree<IntegerPair> = [p(3)]
        tree.insert(item: IntegerPair(key: 1, value: 0))

        XCTAssertTrue(tree.item.key == 3)
        XCTAssertTrue(tree.color == .black)
        XCTAssertTrue(tree.rightChild == nil)
        
        XCTAssertTrue(tree.leftChild?.item.key == 1)
        XCTAssertTrue(tree.leftChild?.color == .red)

        let paths: [[Int]] = tree.pathsFromRootToLeaves(tree: tree)
        XCTAssertTrue(paths[0] == [3,1])
        XCTAssertTrue(paths.count == 1)
    }

    func testLeftRotation() {
        let tree: RedBlackBinarySearchTree<IntegerPair> = [p(3)]
        tree.insert(item: IntegerPair(key: 4, value: 0))

        XCTAssertTrue(tree.item.key == 4)
        XCTAssertTrue(tree.color == .black)
        XCTAssertTrue(tree.rightChild == nil)
        
        XCTAssertTrue(tree.leftChild?.item.key == 3)
        XCTAssertTrue(tree.leftChild?.color == .red)
        XCTAssertTrue(tree.leftChild?.leftChild == nil)
        XCTAssertTrue(tree.leftChild?.rightChild == nil)
        
        let paths: [[Int]] = tree.pathsFromRootToLeaves(tree: tree)
        XCTAssertTrue(paths[0] == [4,3])
        XCTAssertTrue(paths.count == 1)
    }

    func testRightRotationAndFlip() {
        let tree: RedBlackBinarySearchTree<IntegerPair> = [p(5)]
        tree.insert(item: IntegerPair(key: 2, value: 0))
        tree.insert(item: IntegerPair(key: 1, value: 0))
        
        XCTAssertTrue(tree.item.key == 2)
        XCTAssertTrue(tree.color == .black)
        
        XCTAssertTrue(tree.leftChild?.item.key == 1)
        XCTAssertTrue(tree.leftChild?.color == .black)
        XCTAssertTrue(tree.leftChild?.leftChild == nil)
        XCTAssertTrue(tree.leftChild?.rightChild == nil)

        XCTAssertTrue(tree.rightChild?.item.key == 5)
        XCTAssertTrue(tree.rightChild?.color == .black)
        XCTAssertTrue(tree.rightChild?.leftChild == nil)
        XCTAssertTrue(tree.rightChild?.rightChild == nil)

        let paths: [[Int]] = tree.pathsFromRootToLeaves(tree: tree)
        XCTAssertTrue(paths[0] == [2,1])
        XCTAssertTrue(paths[1] == [2,5])
        XCTAssertTrue(paths.count == 2)
    }
}


class RedBlackBinarySearchTreeTraversalTests: XCTestCase {
    
    func testDefaultIteration() {
        let tree: RedBlackBinarySearchTree<IntegerPair> = [p(50),p(23),p(76),p(100),p(40),p(22),p(21),p(20)]
        
        let keyExpectation = [20,21,22,23,40,50,76,100]
        let valueExpectation = [0,0,0,0,0,0,0,0]
        
        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }
    
    func testTraverseInOrderIterator() {
        let tree: RedBlackBinarySearchTree<IntegerPair> = [p(50),p(23),p(76),p(100),p(40),p(22),p(21),p(20)]
        tree.iterator = inOrderTraversalIterator(tree: tree)
        
        let keyExpectation = [20,21,22,23,40,50,76,100]
        let valueExpectation = [0,0,0,0,0,0,0,0]
        
        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }
    
    
    func testTraverseInPostOrderIterator() {
        let tree: RedBlackBinarySearchTree<IntegerPair> = [p(50),p(23),p(76),p(100),p(40),p(22),p(21),p(20)]
        tree.iterator = postOrderTraversalIterator(tree: tree)
        
        let keyExpectation = [20,22,21,40,76,100,50,23]
        let valueExpectation = [0,0,0,0,0,0,0,0]
        
        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }
}


func keysFromIteration(tree: RedBlackBinarySearchTree<IntegerPair>) -> (keys: Array<Int>, values: Array<Int>) {
    var keys = Array<Int>()
    var values = Array<Int>()
    
    for item in tree {
        keys.append(item.key)
        values.append(item.value)
    }
    return (keys: keys, values: values)
}


