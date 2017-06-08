//
//  SinglyThreadedBinarySearchTree.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 18/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest


class SinglyThreadedBinarySearchTreeTests: XCTestCase {

    func testDeletionOfLeftLeaf() {
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3)]
        _ = tree.delete(elementWithKey: 0)
        let keyExpectation = [1,2,3,5]
        let valueExpectation = [0,0,0,0]

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }
    
    func testDeletionOfRightLeaf() {
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3),p(6)]
        _ = tree.delete(elementWithKey: 6)
        let keyExpectation = [0,1,2,3,5]
        let valueExpectation = [0,0,0,0,0]

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }
    
    func testDeletionOfParentWithLeftChild() {
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3),p(6)]
        _ = tree.delete(elementWithKey: 1)
        let keyExpectation = [0,2,3,5,6]
        let valueExpectation = [0,0,0,0,0]

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }

    func testDeletionOfParentWithRightChild() {
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3),p(6),p(4)]
        _ = tree.delete(elementWithKey: 3)
        let keyExpectation = [0,1,2,4,5,6]
        let valueExpectation = [0,0,0,0,0,0]
        
        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }

    func testDeletionOfParentWithTwoChildren() {
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3),p(6),p(4)]
        _ = tree.delete(elementWithKey: 5)
        let keyExpectation = [0,1,2,3,4,6]
        let valueExpectation = [0,0,0,0,0,0]

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }

    func testDeletionOfRoot() {
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3),p(6),p(4)]
        _ = tree.delete(elementWithKey: 2)
        let keyExpectation = [0,1,3,4,5,6]
        let valueExpectation = [0,0,0,0,0,0]

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }
    
    func testMultipleDeletions() {
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3),p(6),p(4)]
        _ = tree.delete(elementWithKey: 5)
        _ = tree.delete(elementWithKey: 1)
        _ = tree.delete(elementWithKey: 4)
        
        let keyExpectation = [0,2,3,6]
        let valueExpectation = [0,0,0,0]

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }
    
    func testDeletionUntilEmptyTree() {
        
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3),p(6),p(4)]
        
        _ = tree.delete(elementWithKey: 2)
        _ = tree.delete(elementWithKey: 6)
        _ = tree.delete(elementWithKey: 0)
        _ = tree.delete(elementWithKey: 4)
        _ = tree.delete(elementWithKey: 3)
        _ = tree.delete(elementWithKey: 5)
        _ = tree.delete(elementWithKey: 1)
        
        XCTAssert(tree.item == nil)
        XCTAssert(tree.leftChild == nil)
        XCTAssert(tree.rightChild == nil)
        
        tree.insert(item: p(56))
        XCTAssert(tree.item?.key == 56)
        XCTAssert(tree.leftChild == nil)
        XCTAssert(tree.rightChild == nil)
    }
}


class SinglyThreadedBinarySearchTreeTraversalTests: XCTestCase {

    func testIndexableCollection() {
        
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3)]
        
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
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3)]
        
        let keyExpectation = [0,1,2,3,5]
        let valueExpectation = [0,0,0,0,0]
        
        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }
    
    func testTraverseInOrderIterator() {
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3),p(6),p(4)]
        tree.iterator = inOrderTraversalIterator(tree: tree)
        
        let keyExpectation = [0,1,2,3,4,5,6]
        let valueExpectation = [0,0,0,0,0,0,0]
        
        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }
    
    
    func testTraverseInPostOrderIterator() {
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3),p(6),p(4)]
        tree.iterator = postOrderTraversalIterator(tree: tree)
        
        let keyExpectation = [0,1,4,3,6,5,2]
        let valueExpectation = [0,0,0,0,0,0,0]
        
        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }
}

class SinglyThreadedBinarySearchTreeBinaryTreeExtensions: XCTestCase {
    
    func testPathsFromRootToLeaves() {
        let tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(2),p(1),p(0),p(5),p(3),p(6)]
        let paths: [[Int]] = tree.pathsFromRootToLeaves(tree: tree)
        
        XCTAssertTrue(paths[0] == [2,1,0])
        XCTAssertTrue(paths[1] == [2,5,3])
        XCTAssertTrue(paths[2] == [2,5,6])
        XCTAssertTrue(paths.count == 3)
    }
    
    func testBottommostRightmost() {
        var tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(20),p(15),p(25),p(14),p(16),p(24),p(26)]
        XCTAssertTrue(tree.bottommostRightMostNode()?.item?.key == 26)
        
        tree = [p(20),p(15),p(25),p(14),p(16),p(24)]
        XCTAssertTrue(tree.bottommostRightMostNode()?.item?.key == 24)
        
        tree = [p(20),p(15),p(25),p(14),p(16)]
        XCTAssertTrue(tree.bottommostRightMostNode()?.item?.key == 16)

        tree = [p(20),p(15),p(25),p(14)]
        XCTAssertTrue(tree.bottommostRightMostNode()?.item?.key == 14)
        
        tree = [p(20),p(15),p(25)]
        XCTAssertTrue(tree.bottommostRightMostNode()?.item?.key == 25)
        
        tree = [p(20),p(15)]
        XCTAssertTrue(tree.bottommostRightMostNode()?.item?.key == 15)
        
        tree = [p(20)]
        XCTAssertTrue(tree.bottommostRightMostNode()?.item?.key == 20)
    }
    
    
    func testNextFreeNode() {
        var tree: SinglyThreadedBinarySearchTree<IntegerPair> = [p(20),p(15),p(25),p(14),p(16),p(23),p(26)]
        var next = tree.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 14)
        
        tree = [p(20),p(15),p(25),p(14),p(16),p(23)]
        next = tree.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 25)
        
        tree = [p(20),p(15),p(25),p(14),p(16)]
        next = tree.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 25)
        
        tree = [p(20),p(15),p(25),p(14)]
        next = tree.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 15)
        
        tree = [p(20),p(15),p(25)]
        next = tree.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 15)
        
        tree = [p(20),p(15)]
        next = tree.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 20)
        
        tree = [p(20)]
        next = tree.nextIncompleteNode()
        XCTAssertTrue(next.item?.key == 20)
    }
}



func keysFromIteration(tree: SinglyThreadedBinarySearchTree<IntegerPair>) -> (keys: Array<Int>, values: Array<Int>) {
    var keys = Array<Int>()
    var values = Array<Int>()
    
    for item in tree {
        keys.append(item.key)
        values.append(item.value)
    }
    return (keys: keys, values: values)
}

func p(_ key:Int) -> IntegerPair {
    return IntegerPair(key: key, value: 0)
}
