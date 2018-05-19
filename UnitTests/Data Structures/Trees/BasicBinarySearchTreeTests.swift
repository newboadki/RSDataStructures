//
//  BasicBinarySearchTreeTests.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 09/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import XCTest


class BasicBinarySearchTreeTests: XCTestCase {
    
    var root : BasicBinarySearchTree<IntegerPair>?
    
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
    
    func test_search() {
        XCTAssert((self.root?.search(key: 13) != nil))
        XCTAssert((self.root?.search(key: 5) != nil))
        XCTAssert((self.root?.search(key: 2) != nil))
        XCTAssert((self.root?.search(key: 70) != nil))
        XCTAssert((self.root?.search(key: 65) != nil))
        XCTAssert((self.root?.search(key: 50) != nil))
        XCTAssert((self.root?.search(key: 66) != nil))
        XCTAssert((self.root?.search(key: 79) != nil))
        XCTAssert((self.root?.search(key: 100) != nil))
        
        XCTAssert((self.root?.search(key: 55) == nil))
        XCTAssert((self.root?.search(key: 1) == nil))
        XCTAssert((self.root?.search(key: 101) == nil))
    }

    func test_min_where_root_is_not_it() {
        XCTAssert(self.root?.minimum()?.item?.key == 2)
    }

    func test_min_where_root_is_min() {
        self.root = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 25, value: 0)))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 45, value: 0)))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 66, value: 0)))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 124, value: 0)))

        XCTAssert(self.root?.minimum()?.item?.key == 13)
    }
    
    func testBinarySearchTreeInvariantDuringEditions() {
        self.root = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 25, value: 0)))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 45, value: 0)))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 66, value: 0)))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 124, value: 0)))
        
        XCTAssertTrue(self.root!.isBinarySearchTree())
        let _ = self.root?.delete(elementWithKey: 66)
        XCTAssertTrue(self.root!.isBinarySearchTree())
        let _ = self.root?.delete(elementWithKey: 45)
        XCTAssertTrue(self.root!.isBinarySearchTree())
        let _ = self.root?.delete(elementWithKey: 25)
        XCTAssertTrue(self.root!.isBinarySearchTree())
        let _ = self.root?.delete(elementWithKey: 124)
        XCTAssertTrue(self.root!.isBinarySearchTree())
        let _ = self.root?.delete(elementWithKey: 13)
        XCTAssertFalse(self.root!.isBinarySearchTree())
    }
    
    func testBinarySearchTreeInvariantForCustomTree() {
        let n3 = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:25, value:0))
        let n1 = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: n3, value: IntegerPair(key:10, value:0))
        let n2 = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:30, value:0))
        
        self.root = BasicBinarySearchTree(parent: nil, leftChild: n1, rightChild: n2, value: IntegerPair(key:20, value:0))
        XCTAssertFalse(self.root!.isBinarySearchTree())
    }
    
    func test_max_where_root_is_not_it() {
        XCTAssert(self.root?.maximum()?.item?.key == 100)
    }

    func test_max_where_root_is_max() {
        self.root = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:40, value:0))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 12, value: 0)))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 11, value: 0)))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 10, value: 0)))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 5, value: 0)))

        XCTAssert(self.root?.maximum()?.item?.key == 40)
    }
    
    func test_insert_iterative() {
        self.root = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        
        self.root?.insertIterative(element: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 5, value: 0)))
        self.root?.insertIterative(element: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 3, value: 0)))
        self.root?.insertIterative(element: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 66, value: 0)))
        self.root?.insertIterative(element: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 4, value: 0)))
        
        XCTAssert(self.root?.minimum()?.item?.key == 3)
        XCTAssert(self.root?.maximum()?.item?.key == 66)
        XCTAssert((self.root?.search(key: 5) != nil))
        XCTAssert((self.root?.search(key: 3) != nil))
        XCTAssert((self.root?.search(key: 4) != nil))
        XCTAssert((self.root?.search(key: 66) != nil))
        
        XCTAssert((self.root?.search(key: 67) == nil))
        XCTAssert((self.root?.search(key: 1) == nil))
    }

    func test_insert() { // Recursive
        self.root = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 5, value: 0)))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 3, value: 0)))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 66, value: 0)))
        self.root?.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 4, value: 0)))
        
        XCTAssert(self.root?.minimum()?.item?.key == 3)
        XCTAssert(self.root?.maximum()?.item?.key == 66)
        XCTAssert((self.root?.search(key: 5) != nil))
        XCTAssert((self.root?.search(key: 3) != nil))
        XCTAssert((self.root?.search(key: 4) != nil))
        XCTAssert((self.root?.search(key: 66) != nil))
        
        XCTAssert((self.root?.search(key: 67) == nil))
        XCTAssert((self.root?.search(key: 1) == nil))
    }

    func test_delete() {
        
        var s11 : BasicBinarySearchTree<IntegerPair>? = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 11, value: 0))
        var s12 : BasicBinarySearchTree<IntegerPair>?  = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 12, value: 0))
        var s90 : BasicBinarySearchTree<IntegerPair>?  = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 90, value: 0))
        var s75 : BasicBinarySearchTree<IntegerPair>?  = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 75, value: 0))
        var s100 : BasicBinarySearchTree<IntegerPair>?  = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 100, value: 0))
        var s99 : BasicBinarySearchTree<IntegerPair>?  = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 99, value: 0))
        var s101 : BasicBinarySearchTree<IntegerPair>?  = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 101, value: 0))
        
        self.root = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:50, value:0))
        var s50 : BasicBinarySearchTree<IntegerPair>? = self.root
        
        self.root?.insert(newElement: s12!)
        self.root?.insert(newElement: s11!)
        self.root?.insert(newElement: s90!)
        self.root?.insert(newElement: s75!)
        self.root?.insert(newElement: s100!)
        self.root?.insert(newElement: s99!)
        self.root?.insert(newElement: s101!)
        
        // Delete node with one child
        XCTAssert(self.root?.delete(elementWithKey: 11) == true)
        XCTAssertNil(self.root?.search(key: 11))
        
        s11 = self.root?.search(key: 11)
        s12 = self.root?.search(key: 12)
        s90 = self.root?.search(key: 90)
        s75 = self.root?.search(key: 75)
        s100 = self.root?.search(key: 100)
        s99 = self.root?.search(key: 99)
        s101 = self.root?.search(key: 101)
        s50 = self.root?.search(key: 50)
        
        assertNodeisCorrect(node: s50, parent: nil, leftChild: s12, rightChild: s90)
        assertNodeisCorrect(node: s12, parent: s50, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s90, parent: s50, leftChild: s75, rightChild: s100)
        assertNodeisCorrect(node: s75, parent: s90, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s100, parent: s90, leftChild: s99, rightChild: s101)
        assertNodeisCorrect(node: s99, parent: s100, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s101, parent: s100, leftChild: nil, rightChild: nil)
        
        
        // Delete node with two children
        XCTAssert(self.root?.delete(elementWithKey: 90) == true)
        XCTAssertNil(self.root?.search(key: 90))

        
        s12 = self.root?.search(key: 12)
        s75 = self.root?.search(key: 75)
        s100 = self.root?.search(key: 100)
        s99 = self.root?.search(key: 99)
        s101 = self.root?.search(key: 101)
        s50 = self.root?.search(key: 50)

        
        assertNodeisCorrect(node: s50, parent: nil, leftChild: s12, rightChild: s99)
        assertNodeisCorrect(node: s12, parent: s50, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s99, parent: s50, leftChild: s75, rightChild: s100)
        assertNodeisCorrect(node: s75, parent: s99, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s100, parent: s99, leftChild: nil, rightChild: s101)
        assertNodeisCorrect(node: s101, parent: s100, leftChild: nil, rightChild: nil)

        
        // Delete the root
        XCTAssert(self.root?.delete(elementWithKey: 50) == true)
        XCTAssertNil(self.root?.search(key: 50))
        
        s12 = self.root?.search(key: 12)
        s75 = self.root?.search(key: 75)
        s100 = self.root?.search(key: 100)
        s99 = self.root?.search(key: 99)
        s101 = self.root?.search(key: 101)

        assertNodeisCorrect(node: s75, parent: nil, leftChild: s12, rightChild: s99)
        assertNodeisCorrect(node: s12, parent: s75, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s99, parent: s75, leftChild: nil, rightChild: s100)
        assertNodeisCorrect(node: s100, parent: s99, leftChild: nil, rightChild: s101)
        assertNodeisCorrect(node: s101, parent: s100, leftChild: nil, rightChild: nil)
        
        // Delete 75
        XCTAssert(s75?.delete(elementWithKey: 75) == true)
        XCTAssertNil(s75?.search(key: 75))
        
        s12 = s75?.search(key: 12)
        s100 = s75?.search(key: 100)
        s99 = s75?.search(key: 99)
        s101 = s75?.search(key: 101)
        XCTAssertNotNil(s12)
        XCTAssert(s100 != nil)
        XCTAssertNotNil(s99)
        XCTAssertNotNil(s101)
        
        assertNodeisCorrect(node: s12, parent: s99, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s99, parent: nil, leftChild: s12, rightChild: s100)
        assertNodeisCorrect(node: s100, parent: s99, leftChild: nil, rightChild: s101)
        assertNodeisCorrect(node: s101, parent: s100, leftChild: nil, rightChild: nil)

        // Delete 99
        XCTAssert(s99?.delete(elementWithKey: 99) == true)
        XCTAssertNil(s99?.search(key: 99))
        
        s12 = s99?.search(key: 12)
        s100 = s99?.search(key: 100)
        s101 = s99?.search(key: 101)
        
        assertNodeisCorrect(node: s12, parent: s100, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s100, parent: nil, leftChild: s12, rightChild: s101)
        assertNodeisCorrect(node: s101, parent: s100, leftChild: nil, rightChild: nil)

        // Delete 100
        XCTAssert(self.root?.delete(elementWithKey: 100) == true)
        XCTAssertNil(self.root?.search(key: 100))
        
        s12 = self.root?.search(key: 12)
        s101 = self.root?.search(key: 101)
        
        assertNodeisCorrect(node: s12, parent: s101, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s101, parent: nil, leftChild: s12, rightChild: nil)

        // Delete 101
        XCTAssert(self.root?.delete(elementWithKey: 101) == true)
        XCTAssertNil(self.root?.search(key: 101))
        
        s12 = self.root?.search(key: 12)
        
        assertNodeisCorrect(node: s12, parent: nil, leftChild: nil, rightChild: nil)

        // Delete 12
        XCTAssert(self.root?.delete(elementWithKey: 12) == true)
        XCTAssertNil(self.root?.search(key: 12))
        
        
        var s30 : BasicBinarySearchTree<IntegerPair>? = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 30, value: 0))
        self.root?.insert(newElement: s30!)
        XCTAssert(self.root?.item?.key == 30)
        XCTAssert(self.root?.item?.value == 0)
        XCTAssertNil(self.root?.leftChild)
        XCTAssertNil(self.root?.rightChild)
        
        s30 = self.root?.search(key: 30)
        XCTAssertNil(s30?.leftChild)
        XCTAssertNil(s30?.rightChild)
        var s29  : BasicBinarySearchTree<IntegerPair>? = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 29, value: 0))
        var s31  : BasicBinarySearchTree<IntegerPair>? = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 31, value: 0))
        self.root?.insert(newElement: s29!)
        self.root?.insert(newElement: s31!)

        s29 = self.root?.search(key: 29)
        s31 = self.root?.search(key: 31)
        assertNodeisCorrect(node: s29, parent: s30, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s31, parent: s30, leftChild: nil, rightChild: nil)
    }

    func test_delete_in_failing_step() {
        
        let s278 : BasicBinarySearchTree<IntegerPair>?  = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 278, value: 0))
        let s98 : BasicBinarySearchTree<IntegerPair>? = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 98, value: 0))
        let s800 : BasicBinarySearchTree<IntegerPair>?  = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 800, value: 0))
        
        self.root = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:780, value:0))
        self.root?.insert(newElement: s98!)
        self.root?.insert(newElement: s278!)
        self.root?.insert(newElement: s800!)
        
        _ = self.root?.delete(elementWithKey: 98)
        XCTAssert(self.root?.search(key: 98) == nil)
        assertNodeisCorrect(node: self.root, parent: nil, leftChild: s278, rightChild: s800)
        assertNodeisCorrect(node: s278, parent: self.root, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s800, parent: self.root, leftChild: nil, rightChild: nil)
    }
    
    func testDeletionUntilEmptyTree() {
        
        let s278 : BasicBinarySearchTree<IntegerPair>?  = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 278, value: 0))
        let s98 : BasicBinarySearchTree<IntegerPair>? = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 98, value: 0))
        let s800 : BasicBinarySearchTree<IntegerPair>?  = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 800, value: 0))
        
        self.root = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:780, value:0))
        self.root?.insert(newElement: s98!)
        self.root?.insert(newElement: s278!)
        self.root?.insert(newElement: s800!)
        
        _ = self.root?.delete(elementWithKey: 98)
        _ = self.root?.delete(elementWithKey: 780)
        _ = self.root?.delete(elementWithKey: 278)
        _ = self.root?.delete(elementWithKey: 800)
        
        XCTAssert(self.root?.item == nil)
        XCTAssert(self.root?.leftChild == nil)
        XCTAssert(self.root?.rightChild == nil)
        
        self.root?.insert(item: p(6))
        self.root?.insert(item: p(2))

        XCTAssert(self.root?.item?.key == 6)
        XCTAssert(self.root?.leftChild?.item?.key == 2)
        XCTAssert(self.root?.leftChild?.leftChild == nil)
        XCTAssert(self.root?.leftChild?.rightChild == nil)
        XCTAssert(self.root?.rightChild == nil)
    }
    
    func assertNodeisCorrect(node: BasicBinarySearchTree<IntegerPair>?,
                             parent:BasicBinarySearchTree<IntegerPair>?,
                             leftChild:BasicBinarySearchTree<IntegerPair>?,
                             rightChild:BasicBinarySearchTree<IntegerPair>?) {
        
        
        if let n =  node {
            if parent == nil {
                XCTAssertNil(n.parent)
            } else {
                XCTAssertTrue(n.parent === parent)
            }
            
            if n.leftChild == nil {
                XCTAssertNil(leftChild)
            } else {
                XCTAssertTrue(n.leftChild! === leftChild!)
            }
            
            if n.rightChild == nil {
                XCTAssertNil(rightChild)
            } else {
                XCTAssertTrue(n.rightChild! === rightChild!)
            }
            
        } else {
            XCTFail()
            return
            
        }
        
    }

}

class BasicBinarySearchTreeBinaryTreeExtensions: XCTestCase {
    
    func testPathsFromRootToLeaves() {
        let tree = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        tree.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 10, value: 0)))
        tree.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 45, value: 0)))
        tree.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 66, value: 0)))
        tree.insert(newElement: BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 124, value: 0)))
        
        let paths: [[Int]] = tree.pathsFromRootToLeaves(tree: tree)
        
        XCTAssertTrue(paths[0] == [13,10])
        XCTAssertTrue(paths[1] == [13,45,66,124])
        XCTAssertTrue(paths.count == 2)
    }

    func testPathsFromRootToLeavesSingleNode() {
        let tree = BasicBinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        
        let paths: [[Int]] = tree.pathsFromRootToLeaves(tree: tree)
        
        XCTAssertTrue(paths[0] == [13])
        XCTAssertTrue(paths.count == 1)
        
    }
}

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
    
    func testTraverseInPostOrderRightToLeftIterator() {
        let expectation = [100,79,66,50,65,70,2,5,13]
        
        root?.iterator = postOrderRightToLeftTraversalIterator(tree: root!)
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

