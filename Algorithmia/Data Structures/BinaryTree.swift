//
//  BinaryTree.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 17/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


protocol BinaryTree : Equatable {
    
    associatedtype Item : KeyValuePair
    
    
    var leftChild: Self? {get}
    
    var rightChild: Self? {get}
    
    var item: Item {get}
    
    var count: Int {get}
    
    
    func search(key: Item.K) -> Self?
    
    func minimum() -> Self?
    
    func maximum() -> Self?
}


extension BinaryTree {
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return (lhs.item == rhs.item) && (lhs.leftChild == rhs.leftChild) && (lhs.rightChild == rhs.rightChild)
    }
    
    // MARK: - Search
    
    /// Searches a node in the tree.
    ///
    /// - Parameter key: The key to look for in the tree.
    /// - Returns: A tree where the root is a node with the sought key or nil if the key was not found.
    /// - Complexity: O(ln n)
    func search(key: Item.K) -> Self? {
        
        if self.item.key == key {
            // The shought element is the root of the current tree
            return self
        }
        
        if key < self.item.key {
            return self.leftChild?.search(key: key)
        } else {
            return self.rightChild?.search(key: key)
        }
    }
    
    /// Minimum element
    ///
    /// - Returns: The left-most leave of the tree, which has the minimum value as its node's key
    /// - Complexity: O(log N), with N being the number of nodes in the tree.
    func minimum() -> Self? {
        var min : Self? = self
        while (min?.leftChild != nil) {
            min = min?.leftChild
        }
        
        return min
    }
    
    /// Maximum element
    ///
    /// - Returns: The right most leave of the tree, which has the maximum value as its node's key
    /// - Complexity: O(log N), with N being the number of nodes in the tree.
    func maximum() -> Self? {
        
        var max : Self? = self
        while (max?.rightChild != nil) {
            max = max?.rightChild
        }
        
        return max
    }
}



protocol TraversableBinaryTree : BinaryTree, Sequence {
    
    var iterator : AnyIterator<Item>? {get set}
}


extension TraversableBinaryTree {
    
    public func makeIterator() -> AnyIterator<Item> {
        return self.iterator!
    }
}
