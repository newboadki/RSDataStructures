//
//  BinarySearchTreeTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 09/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import XCTest

class BinarySearchTreeTests: XCTestCase {
    
    var root : BinarySearchTree<IntegerPair>?
    
    override func setUp() {
        /*
         R
         |- lA
         |- A1
         |- rB
         |- lB1
         |lB1.1
         |rB1.2
         |- rB2
         |- rB2.2
         */
        
        
        
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
    
    func test_search() {
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:13, value:300)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:5, value:300)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:2, value:300)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:70, value:300)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:65, value:300)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:50, value:300)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:66, value:300)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:79, value:300)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:100, value:300)) != nil))
        
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:55, value:300)) == nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:1, value:300)) == nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:101, value:300)) == nil))
    }

    func test_min_where_root_is_not_it() {
        XCTAssert(self.root?.minimum()?.node.key == 2)
    }

    func test_min_where_root_is_min() {
        self.root = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 25, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 45, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 66, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 124, value: 0)))

        XCTAssert(self.root?.minimum()?.node.key == 13)
    }

    func test_max_where_root_is_not_it() {
        XCTAssert(self.root?.maximum()?.node.key == 100)
    }

    func test_max_where_root_is_max() {
        self.root = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:40, value:0))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 12, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 11, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 10, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 5, value: 0)))

        XCTAssert(self.root?.maximum()?.node.key == 40)
    }
    
    func test_insert_iterative() {
        self.root = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        
        self.root?.insertIterative(element: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 5, value: 0)))
        self.root?.insertIterative(element: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 3, value: 0)))
        self.root?.insertIterative(element: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 66, value: 0)))
        self.root?.insertIterative(element: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 4, value: 0)))
        
        XCTAssert(self.root?.minimum()?.node.key == 3)
        XCTAssert(self.root?.maximum()?.node.key == 66)
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:5, value:0)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:3, value:0)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:4, value:0)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:66, value:0)) != nil))
        
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:67, value:0)) == nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:1, value:0)) == nil))
    }

    func test_insert() { // Recursive
        self.root = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 5, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 3, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 66, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 4, value: 0)))
        
        XCTAssert(self.root?.minimum()?.node.key == 3)
        XCTAssert(self.root?.maximum()?.node.key == 66)
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:5, value:0)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:3, value:0)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:4, value:0)) != nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:66, value:0)) != nil))
        
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:67, value:0)) == nil))
        XCTAssert((self.root?.search(soughtElement: IntegerPair(key:1, value:0)) == nil))
    }

    func test_delete() {
        
        
        let s11 = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 11, value: 0))
        let s12 = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 12, value: 0))
        let s90 = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 90, value: 0))
        let s75 = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 75, value: 0))
        let s100 = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 100, value: 0))
        let s99 = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 99, value: 0))
        let s101 = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 101, value: 0))
        
        self.root = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:50, value:0))
        let s50 = self.root
        
        self.root?.insert(newElement: s12)
        self.root?.insert(newElement: s11)
        self.root?.insert(newElement: s90)
        self.root?.insert(newElement: s75)
        self.root?.insert(newElement: s100)
        self.root?.insert(newElement: s99)
        self.root?.insert(newElement: s101)
        
        // Delete node with one child
        XCTAssert(self.root?.delete(element: s11) == true)
        XCTAssertNil(self.root?.search(soughtElement: IntegerPair(key:11, value:0)))
        
        assertNodeisCorrect(node: s50!, parent: nil, leftChild: s12, rightChild: s90)
        assertNodeisCorrect(node: s12, parent: s50, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s90, parent: s50, leftChild: s75, rightChild: s100)
        assertNodeisCorrect(node: s75, parent: s90, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s100, parent: s90, leftChild: s99, rightChild: s101)
        assertNodeisCorrect(node: s99, parent: s100, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s101, parent: s100, leftChild: nil, rightChild: nil)
        
        
        // Delete node with two children
        XCTAssert(self.root?.delete(element: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 90, value: 0))) == true)
        self.root?.printTree()
        
        XCTAssertNil(self.root?.search(soughtElement: IntegerPair(key:90, value:0)))
        assertNodeisCorrect(node: s50!, parent: nil, leftChild: s12, rightChild: s99)
        assertNodeisCorrect(node: s12, parent: s50, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s99, parent: s50, leftChild: s75, rightChild: s100)
        assertNodeisCorrect(node: s75, parent: s99, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s100, parent: s99, leftChild: nil, rightChild: s101)
        assertNodeisCorrect(node: s101, parent: s100, leftChild: nil, rightChild: nil)

        
        // Delete the root
        XCTAssert(self.root?.delete(element: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 50, value: 0))) == true)
        
        XCTAssertNil(self.root?.search(soughtElement: IntegerPair(key:50, value:0)))
        assertNodeisCorrect(node: s75, parent: nil, leftChild: s12, rightChild: s99)
        assertNodeisCorrect(node: s12, parent: s75, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s99, parent: s75, leftChild: nil, rightChild: s100)
        assertNodeisCorrect(node: s100, parent: s99, leftChild: nil, rightChild: s101)
        assertNodeisCorrect(node: s101, parent: s100, leftChild: nil, rightChild: nil)
    }

    func assertNodeisCorrect(node: BinarySearchTree<IntegerPair>,
                             parent:BinarySearchTree<IntegerPair>?,
                             leftChild:BinarySearchTree<IntegerPair>?,
                             rightChild:BinarySearchTree<IntegerPair>?) {
        XCTAssertNotNil(node)
        if parent == nil {
            XCTAssertNil(node.parent)
        } else {
            XCTAssert(node.parent!.node.key == parent!.node.key)
        }

        if node.leftChild == nil {
            XCTAssertNil(node.leftChild)
        } else {
            XCTAssert(node.leftChild!.node.key == leftChild!.node.key)
        }

        if node.rightChild == nil {
            XCTAssertNil(node.rightChild)
        } else {
            XCTAssert(node.rightChild!.node.key == rightChild!.node.key)
        }
    }
}
