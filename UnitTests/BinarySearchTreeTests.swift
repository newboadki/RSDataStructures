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
        XCTAssert(self.root?.minimum()?.item.key == 2)
    }

    func test_min_where_root_is_min() {
        self.root = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 25, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 45, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 66, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 124, value: 0)))

        XCTAssert(self.root?.minimum()?.item.key == 13)
    }

    func test_max_where_root_is_not_it() {
        XCTAssert(self.root?.maximum()?.item.key == 100)
    }

    func test_max_where_root_is_max() {
        self.root = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:40, value:0))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 12, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 11, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 10, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 5, value: 0)))

        XCTAssert(self.root?.maximum()?.item.key == 40)
    }
    
    func test_insert_iterative() {
        self.root = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        
        self.root?.insertIterative(element: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 5, value: 0)))
        self.root?.insertIterative(element: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 3, value: 0)))
        self.root?.insertIterative(element: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 66, value: 0)))
        self.root?.insertIterative(element: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 4, value: 0)))
        
        XCTAssert(self.root?.minimum()?.item.key == 3)
        XCTAssert(self.root?.maximum()?.item.key == 66)
        XCTAssert((self.root?.search(key: 5) != nil))
        XCTAssert((self.root?.search(key: 3) != nil))
        XCTAssert((self.root?.search(key: 4) != nil))
        XCTAssert((self.root?.search(key: 66) != nil))
        
        XCTAssert((self.root?.search(key: 67) == nil))
        XCTAssert((self.root?.search(key: 1) == nil))
    }

    func test_insert() { // Recursive
        self.root = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 5, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 3, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 66, value: 0)))
        self.root?.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 4, value: 0)))
        
        XCTAssert(self.root?.minimum()?.item.key == 3)
        XCTAssert(self.root?.maximum()?.item.key == 66)
        XCTAssert((self.root?.search(key: 5) != nil))
        XCTAssert((self.root?.search(key: 3) != nil))
        XCTAssert((self.root?.search(key: 4) != nil))
        XCTAssert((self.root?.search(key: 66) != nil))
        
        XCTAssert((self.root?.search(key: 67) == nil))
        XCTAssert((self.root?.search(key: 1) == nil))
    }

    func test_delete() {
        
        var s11 : BinarySearchTree<IntegerPair>? = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 11, value: 0))
        var s12 : BinarySearchTree<IntegerPair>?  = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 12, value: 0))
        var s90 : BinarySearchTree<IntegerPair>?  = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 90, value: 0))
        var s75 : BinarySearchTree<IntegerPair>?  = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 75, value: 0))
        var s100 : BinarySearchTree<IntegerPair>?  = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 100, value: 0))
        var s99 : BinarySearchTree<IntegerPair>?  = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 99, value: 0))
        var s101 : BinarySearchTree<IntegerPair>?  = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 101, value: 0))
        
        self.root = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:50, value:0))
        var s50 : BinarySearchTree<IntegerPair>? = self.root
        
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
        
        
        var s30 : BinarySearchTree<IntegerPair>? = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 30, value: 0))
        self.root?.insert(newElement: s30!)
        XCTAssert(self.root?.item.key == 30)
        XCTAssert(self.root?.item.value == 0)
        XCTAssertNil(self.root?.leftChild)
        XCTAssertNil(self.root?.rightChild)
        
        s30 = self.root?.search(key: 30)
        XCTAssertNil(s30?.leftChild)
        XCTAssertNil(s30?.rightChild)
        var s29  : BinarySearchTree<IntegerPair>? = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 29, value: 0))
        var s31  : BinarySearchTree<IntegerPair>? = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 31, value: 0))
        self.root?.insert(newElement: s29!)
        self.root?.insert(newElement: s31!)

        s29 = self.root?.search(key: 29)
        s31 = self.root?.search(key: 31)
        assertNodeisCorrect(node: s29, parent: s30, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s31, parent: s30, leftChild: nil, rightChild: nil)
    }

    func test_delete_in_failing_step() {
        
        let s278 : BinarySearchTree<IntegerPair>?  = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 278, value: 0))
        let s98 : BinarySearchTree<IntegerPair>? = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 98, value: 0))
        let s800 : BinarySearchTree<IntegerPair>?  = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 800, value: 0))
        
        self.root = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:780, value:0))
        self.root?.insert(newElement: s98!)
        self.root?.insert(newElement: s278!)
        self.root?.insert(newElement: s800!)
        
        _ = self.root?.delete(elementWithKey: 98)
        XCTAssert(self.root?.search(key: 98) == nil)
        assertNodeisCorrect(node: self.root, parent: nil, leftChild: s278, rightChild: s800)
        assertNodeisCorrect(node: s278, parent: self.root, leftChild: nil, rightChild: nil)
        assertNodeisCorrect(node: s800, parent: self.root, leftChild: nil, rightChild: nil)
        

    }
    
//    func assertNodeisCorrect(node: BinarySearchTree<IntegerPair>?,
//                             parent:BinarySearchTree<IntegerPair>?,
//                             leftChild:BinarySearchTree<IntegerPair>?,
//                             rightChild:BinarySearchTree<IntegerPair>?) {
//        XCTAssertNotNil(node)
//        
//        if let n =  node {
//            if parent == nil {
//                XCTAssertNil(n.parent)
//            } else {
//                XCTAssert(n.parent!.node.key == parent!.node.key)
//            }
//            
//            if n.leftChild == nil {
//                XCTAssertNil(leftChild)
//            } else {
//                XCTAssert(n.leftChild!.node.key == leftChild!.node.key)
//            }
//            
//            if n.rightChild == nil {
//                XCTAssertNil(rightChild)
//            } else {
//                XCTAssert(n.rightChild!.node.key == rightChild!.node.key)
//            }
//
//        } else {
//            XCTFail()
//            return
//            
//        }
//        
//    }
    
    func assertNodeisCorrect(node: BinarySearchTree<IntegerPair>?,
                             parent:BinarySearchTree<IntegerPair>?,
                             leftChild:BinarySearchTree<IntegerPair>?,
                             rightChild:BinarySearchTree<IntegerPair>?) {
        
        
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

class BinarySearchTreeBinaryTreeExtensions: XCTestCase {
    
    func testPathsFromRootToLeaves() {
        let tree = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        tree.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 10, value: 0)))
        tree.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 45, value: 0)))
        tree.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 66, value: 0)))
        tree.insert(newElement: BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key: 124, value: 0)))
        
        let paths: [[Int]] = tree.pathsFromRootToLeaves(tree: tree)
        
        XCTAssertTrue(paths[0] == [13,10])
        XCTAssertTrue(paths[1] == [13,45,66,124])
        XCTAssertTrue(paths.count == 2)
    }

    func testPathsFromRootToLeavesSingleNode() {
        let tree = BinarySearchTree(parent: nil, leftChild: nil, rightChild: nil, value: IntegerPair(key:13, value:0))
        
        let paths: [[Int]] = tree.pathsFromRootToLeaves(tree: tree)
        
        XCTAssertTrue(paths[0] == [13])
        XCTAssertTrue(paths.count == 1)
        
    }

}
