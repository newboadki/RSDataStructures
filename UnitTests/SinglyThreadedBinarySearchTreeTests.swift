//
//  SinglyThreadedBinarySearchTree.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 18/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest


class SinglyThreadedBinarySearchTreeTests: XCTestCase {

    var root: SinglyThreadedBinarySearchTree<IntegerPair>?
    
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

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
}

    func testDeletionOfLeftLeaf() {
        let tree = SinglyThreadedBinarySearchTree<IntegerPair>(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 2, value: 3))
        tree.insert(item: IntegerPair(key: 1, value: 3))
        tree.insert(item: IntegerPair(key: 0, value: 3))
        tree.insert(item: IntegerPair(key: 5, value: 3))
        tree.insert(item: IntegerPair(key: 3, value: 3))
        
        _ = tree.delete(elementWithKey: 0)
        let keyExpectation = [1,2,3,5]
        let valueExpectation = [3,3,3,3]

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
}
    
    func testDeletionOfRightLeaf() {
        let tree = SinglyThreadedBinarySearchTree<IntegerPair>(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 2, value: 3))
        tree.insert(item: IntegerPair(key: 1, value: 3))
        tree.insert(item: IntegerPair(key: 0, value: 3))
        tree.insert(item: IntegerPair(key: 5, value: 3))
        tree.insert(item: IntegerPair(key: 3, value: 3))
        tree.insert(item: IntegerPair(key: 6, value: 3))
        
        _ = tree.delete(elementWithKey: 6)
        let keyExpectation = [0,1,2,3,5]
        let valueExpectation = [3,3,3,3,3]

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
}

    
    func testDeletionOfParentWithLeftChild() {
        let tree = SinglyThreadedBinarySearchTree<IntegerPair>(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 2, value: 3))
        tree.insert(item: IntegerPair(key: 1, value: 3))
        tree.insert(item: IntegerPair(key: 0, value: 3))
        tree.insert(item: IntegerPair(key: 5, value: 3))
        tree.insert(item: IntegerPair(key: 3, value: 3))
        tree.insert(item: IntegerPair(key: 6, value: 3))
        
        _ = tree.delete(elementWithKey: 1)
        let keyExpectation = [0,2,3,5,6]
        let valueExpectation = [3,3,3,3,3]

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }

    func testDeletionOfParentWithRightChild() {
        let tree = SinglyThreadedBinarySearchTree<IntegerPair>(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 2, value: 3))
        tree.insert(item: IntegerPair(key: 1, value: 3))
        tree.insert(item: IntegerPair(key: 0, value: 3))
        tree.insert(item: IntegerPair(key: 5, value: 3))
        tree.insert(item: IntegerPair(key: 3, value: 3))
        tree.insert(item: IntegerPair(key: 6, value: 3))
        tree.insert(item: IntegerPair(key: 4, value: 3))
        
        _ = tree.delete(elementWithKey: 3)
        let keyExpectation = [0,1,2,4,5,6]
        let valueExpectation = [3,3,3,3,3,3]
        
        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }

    func testDeletionOfParentWithTwoChildren() {
        let tree = SinglyThreadedBinarySearchTree<IntegerPair>(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 2, value: 3))
        tree.insert(item: IntegerPair(key: 1, value: 3))
        tree.insert(item: IntegerPair(key: 0, value: 3))
        tree.insert(item: IntegerPair(key: 5, value: 3))
        tree.insert(item: IntegerPair(key: 3, value: 3))
        tree.insert(item: IntegerPair(key: 6, value: 3))
        tree.insert(item: IntegerPair(key: 4, value: 3))
        
        _ = tree.delete(elementWithKey: 5)
        let keyExpectation = [0,1,2,3,4,6]
        let valueExpectation = [3,3,3,3,3,3]

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }

    func testDeletionOfRoot() {
        let tree = SinglyThreadedBinarySearchTree<IntegerPair>(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 2, value: 3))
        tree.insert(item: IntegerPair(key: 1, value: 3))
        tree.insert(item: IntegerPair(key: 0, value: 3))
        tree.insert(item: IntegerPair(key: 5, value: 3))
        tree.insert(item: IntegerPair(key: 3, value: 3))
        tree.insert(item: IntegerPair(key: 6, value: 3))
        tree.insert(item: IntegerPair(key: 4, value: 3))
        
        _ = tree.delete(elementWithKey: 2)
        let keyExpectation = [0,1,3,4,5,6]
        let valueExpectation = [3,3,3,3,3,3]

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
    }
    
    func testMultipleDeletions() {
        let tree = SinglyThreadedBinarySearchTree<IntegerPair>(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 2, value: 3))
        tree.insert(item: IntegerPair(key: 1, value: 3))
        tree.insert(item: IntegerPair(key: 0, value: 3))
        tree.insert(item: IntegerPair(key: 5, value: 3))
        tree.insert(item: IntegerPair(key: 3, value: 3))
        tree.insert(item: IntegerPair(key: 6, value: 3))
        tree.insert(item: IntegerPair(key: 4, value: 3))
        
        _ = tree.delete(elementWithKey: 5)
        _ = tree.delete(elementWithKey: 1)
        _ = tree.delete(elementWithKey: 4)
        
        let keyExpectation = [0,2,3,6]
        let valueExpectation = [3,3,3,3]

        let (keys, values) = keysFromIteration(tree:tree)
        XCTAssertTrue(keys == keyExpectation)
        XCTAssertTrue(values == valueExpectation)
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

}

