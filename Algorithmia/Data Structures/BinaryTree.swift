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
    
    var item: Item! {get}
    
    var count: Int {get}
    
    
    func search(key: Item.K) -> Self?
    
    func minimum() -> Self?
    
    func maximum() -> Self?
    
    func pathsFromRootToLeaves<C: Comparable, T: BinaryTree>(tree: T?) -> [[C]] where T.Item.K == C    
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
    
    
    /// Builds all paths from the root to the leaves of the tree.
    ///
    /// - Parameter tree: The tree to be traversed.
    /// - Returns: An array of arrays, ech of which contains the keys of the nodes that make up the path.
    /// - Complexity: O(N * log_2(N)). As a very basic explanation, each path has log_2(N) nodes (at worst, in a perfect binary tree). There are N leaves. The cost of printing all paths is #(paths) * cost(printing_a_path) => N * log_2(N).
    func pathsFromRootToLeaves<C: Comparable, T: BinaryTree>(tree: T?) -> [[C]] {
        
        /// Enumerates the keys in a path to create the array that represents that path
        ///
        /// - Parameters:
        ///   - stack: an array to track the progress of the recursive calls. Helps to backtrack once a path has been completed.
        ///   - count: the size of a given path in the recursion stack.
        /// - Returns: A given path according to the stack and the count given
        func pathFrom(stack: inout [C], count: Int) -> [C] {
            var path = [C]()
            for i in 0..<count {
                path.append(stack[i])
            }
            
            return path
        }
        
        /// Recursive routine that builds all paths from root to the leaves
        ///
        /// - Parameters:
        ///   - tree: The tree to be traversed
        ///   - paths: the list of paths found to far
        ///   - stack: an array to track the progress of the recursive calls. Helps to backtrack once a path has been completed.
        ///   - count: the size of a given path in the recursion stack.
        func traversePaths(tree: T?, paths: inout [[C]], stack: inout [C], count: Int) {
            
            guard tree != nil else {
                return
            }
            
            guard tree?.item != nil else {
                return
            }
            
            let key: C = tree?.item.key as! C
            stack.insert(key, at: count)
            let nextCount = count + 1

            if tree?.leftChild==nil && tree?.rightChild==nil {
                let path = pathFrom(stack: &stack, count: nextCount)
                paths.append(path)
            } else {
                traversePaths(tree: tree?.leftChild, paths: &paths, stack: &stack, count: nextCount)
                traversePaths(tree: tree?.rightChild, paths: &paths, stack: &stack, count: nextCount)
            }
        }
    
        
        var paths = [[C]]()
        var stackCallArray = [C]()
        traversePaths(tree: tree, paths: &paths, stack: &stackCallArray, count: 0)
        return paths
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
