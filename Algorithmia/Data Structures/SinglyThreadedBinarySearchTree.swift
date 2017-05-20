//
//  SinglyThreadedBinaryTree.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 18/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation



/// This tree is a BinaryTree & Collection but not a TraversableBinaryTree, 
/// becuase its internal implementation does not allow
/// all arbitraty traversal algorithms. Some would not work. 
/// Therefore it is this class that defines the different supported traversal algorithms.
public final class SinglyThreadedBinarySearchTree<Element : KeyValuePair> : BinaryTree {
    
    typealias Item = Element
    
    var parent : SinglyThreadedBinarySearchTree<Element>?
    
    var leftChild : SinglyThreadedBinarySearchTree<Element>?
    
    var rightChild : SinglyThreadedBinarySearchTree<Element>?
    
    var rightChildLinksToSuccessor: Bool
    
    var item : Element
    
    var iterator: AnyIterator<Element>?
    
    public var count: Int

    
    // MARK: -  Initializers
    
    /// Designated initializer
    ///
    /// - Parameters:
    ///   - parent: reference to the parent node
    ///   - leftChild: reference to the  left subtree
    ///   - rightChild: reference to the right subtree
    ///   - value: item contained in the tree node.
    public init(parent: SinglyThreadedBinarySearchTree?,
         leftChild: SinglyThreadedBinarySearchTree?,
         rightChild: SinglyThreadedBinarySearchTree?, value:Element) {
        
        self.parent = parent
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.item = value
        self.rightChildLinksToSuccessor = false
        self.count = 1
    }
    
    public func insert(item: Element) {
        
        guard  (self.item != item) else {
            return
        }
        
        if item < self.item {
            if let lc = self.leftChild {
                lc.insert(item: item)
            } else {
                let newNode = SinglyThreadedBinarySearchTree<Element>(parent: self, leftChild: nil, rightChild: nil, value: item)
                self.leftChild = newNode
                newNode.rightChildLinksToSuccessor = true
                newNode.rightChild = self
                
                self.count += 1
                
            }
        } else {
            if let rc = self.rightChild {
                rc.insert(item: item)
            } else {
                let newNode = SinglyThreadedBinarySearchTree<Element>(parent: self, leftChild: nil, rightChild: nil, value: item)
                
                if (self.rightChildLinksToSuccessor) {
                    newNode.rightChild = self.rightChild
                    newNode.rightChildLinksToSuccessor = true
                    self.rightChildLinksToSuccessor = false
                } else {
                    newNode.rightChildLinksToSuccessor = false                    
                }
                self.rightChild = newNode
                self.count += 1
            }
        }
    }

    public func next(after node: SinglyThreadedBinarySearchTree<Element>) -> SinglyThreadedBinarySearchTree<Element>? {
        
        var current: SinglyThreadedBinarySearchTree<Element>? = node
        
        if current!.rightChildLinksToSuccessor {
            current = current!.rightChild
        } else {
            current = current!.rightChild?.minimum()
        }

        return current
    }
}




public struct SinglyThreadedBinaryTreeIndex<Element:KeyValuePair> : Comparable
{
    fileprivate let node: SinglyThreadedBinarySearchTree<Element>?
    fileprivate let tag: Int
    
    public static func==<T: KeyValuePair>(lhs: SinglyThreadedBinaryTreeIndex<T>, rhs: SinglyThreadedBinaryTreeIndex<T>) -> Bool {
        return (lhs.tag == rhs.tag)
    }
    
    public static func< <T: KeyValuePair>(lhs: SinglyThreadedBinaryTreeIndex<T>, rhs: SinglyThreadedBinaryTreeIndex<T>) -> Bool {
        return (lhs.tag < rhs.tag)
    }
}


extension SinglyThreadedBinarySearchTree : Collection {
    
    public typealias Index = SinglyThreadedBinaryTreeIndex<Element>
    
    
    /// Complexity: O(Log N). This is a deviation from the collection requirement; O(1). It can be improved if after every time there's a new minimum or maximum we store and correctly propagate that value across all the nodes in the tree.
    public var startIndex: Index {
        get {
            return SinglyThreadedBinaryTreeIndex<Element>(node: self.minimum(), tag: 0)
        }
    }

    
    /// Complexity: O(1)
    public var endIndex: Index {
        get {
            return SinglyThreadedBinaryTreeIndex<Element>(node: nil, tag: self.count)
        }
    }
    
    public subscript(position: Index) -> Element {
        get {
            return position.node!.item
        }
    }
    
    public func index(after idx: Index) -> Index {
        return SinglyThreadedBinaryTreeIndex<Element>(node: self.next(after: idx.node!), tag: idx.tag+1)
    }
}



