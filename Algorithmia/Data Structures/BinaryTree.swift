//
//  BinaryTree.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 17/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


/// Binary trees are connected acyclic graphs with each node have 0 to 2 nodes.
protocol BinaryTree : Equatable {
    
    associatedtype Item : KeyValuePair
    
    
    /// Reference to the left subtree
    var leftChild: Self? {get}
    
    /// Reference to the right subtree
    var rightChild: Self? {get}
    
    /// A container of information.
    /// TODO: Allow this to be optional
    var item: Item! {get}
    
    /// The number of nodes in the tree
    var count: Int {get}
    

    /// Adds a new node to the tree.
    ///
    /// - Parameter item: new item to be added to the tree.
    /// - Complexity: Normally a O(Log(N)) is expected. Deviations must be documented.
    func insert(item: Item)
    
    
    /// Removes a node from the tree, that has a matching key.
    ///
    /// - Parameter elementWithKey: the key the element to be deleted must have.
    /// - Returns: True if an element was deleted.
    /// - Complexity: Normally a O(Log(N)) is expected. Deviations must be documented.
    func delete(elementWithKey: Item.K) -> Bool
    
    
    /// Finds a node in the tree with the given key
    ///
    /// - Parameter key: Key to search for.
    /// - Returns: A node with the given key or nil if not found.
    func search(key: Self.Item.K) -> Self?
    
    
    /// Minimum
    ///
    /// - Returns: The node with the smallest key
    func minimum() -> Self?

    
    /// Maximum
    ///
    /// - Returns: The node with the bigest key
    func maximum() -> Self?

    
    /// Builds all paths from the root to the leaves of the tree.
    ///
    /// - Parameter tree: The tree to be traversed.
    /// - Returns: An array of arrays, ech of which contains the keys of the nodes that make up the path.
    /// - Complexity: Expected O(N * log_2(N)). As a very basic explanation, each path has log_2(N) nodes (at worst, in a perfect binary tree). There are N leaves. The cost of printing all paths is #(paths) * cost(printing_a_path) => N * log_2(N).
    func pathsFromRootToLeaves<C: Comparable, T: BinaryTree>(tree: T?) -> [[C]] where T.Item.K == C
    
    
    /// The legth of the longest root to leaf path
    ///
    /// - Returns: The legth of the longest root to leaf path
    /// - Complexity: Worst case O(N).
    func maximumHeight() -> Int
    
    
    /// This is the deepest node at the far most right in the tree.
    /// The position of this node makes it useful in many algorithmic 
    /// like for example to keep the balance property of certain trees.
    ///
    /// - Returns: The bottommost rightmost node in the tree.
    func bottommostRightMostNode() -> Self?
    
    
    
    /// Binary trees have at most 2 children, but they can actually have any
    /// number from 0 to 2 children, both inclusive.
    ///
    /// - Returns: The number of children nodes.
    func numberOfChildren() -> Int
}


extension BinaryTree {
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return (lhs.item == rhs.item) && (lhs.leftChild == rhs.leftChild) && (lhs.rightChild == rhs.rightChild)
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
    
    
    /// The legth of the longest root to leaf path
    ///
    /// - Returns: The legth of the longest root to leaf path
    /// - Complexity: O(N * Log_2(N)). This worsens the expectations defined in the protocol, because it relies on pathsFromRootToLeaves which does extra effort to compose an array of paths.
    /// - Discussion: The height of the root is considered to be 1.
    func maximumHeight() -> Int {
        let paths = self.pathsFromRootToLeaves(tree: self)
        var max = 0
        
        for p in paths {
            if p.count > max {
                max = p.count
            }
        }
        return max
    }
    
    
    /// Binary trees have at most 2 children, but they can actually have any
    /// number from 0 to 2 children, both inclusive.
    ///
    /// - Returns: The number of children nodes.
    func numberOfChildren() -> Int {
        if self.leftChild != nil && self.rightChild != nil {
            return 2
        } else if (self.leftChild != nil) || (self.rightChild != nil) {
            return 1
        } else {
            return 0
        }
    }
}




/// Search Binary Trees are Binary trees that enforce the following invariant:
/// Given a node with key K:
///  - The left subtree contains keys that are lower than K.
///  - The right subtree contains keys that are greater than K.
///
/// It is due to this property that the BinarySearchTree protocol offers default implementations 
/// for search, minimum, maximum and other common tasks.
protocol BinarySearchTree : BinaryTree {
    
}

extension BinarySearchTree {
    
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


/// A CompleteBinaryTree is a binary tree that introduces the following invariant:
///  - All levels have all possible nodes
///  - Only the last level can have missing nodes, but the are filled from left to right.
protocol CompleteBinaryTree : BinaryTree {
    
}

extension CompleteBinaryTree {

    /// The legth of the longest root to leaf path
    ///
    /// - Returns: The legth of the longest root to leaf path
    /// - Complexity: The invariant allows a worst case of O(Log(N)) because either all paths will have the same length or the longest paths will be found on the left descendants of the root.
    /// - Discussion: The height of the root is considered to be 1.
    func maximumHeight() -> Int {
        var height: Int = 1
        var current: Self? = self
        
        while(current?.leftChild != nil) {
            current = current?.leftChild
            height += 1
        }
        
        return height
    }
}

extension CompleteBinaryTree where Self : TraversableBinaryTree {
    
    /// - Returns: The node the first node that still has space to allocate a child according to the invariant that a
    ///   Balanced Binary Tree defines all levels full, except the last one, which is filled from left to right.
    func nextIncompleteNode() -> Self {
        
        let iterator: AnyIterator<(node: Self, height: Int)> = breadthFirstSearchTraversalIterator(tree: self)
        let maximumHeight = self.maximumHeight()
        
        while let tuple = iterator.next() {
            let h = tuple.height
            if (h == maximumHeight || h == (maximumHeight-1)) && (tuple.node.numberOfChildren()<2) {
                return tuple.node
            }
        }
        
        return self
    }
}

/// Here, we define Traversal binary trees as those binary trees that accept any traversal strategy (iterator) based on
/// the fact that a binary tree has left and right children. If your implementation requires more knowledge to be traversed
/// then, not every strategy will work, therefore it's not traversable according to this definition. But of course, that 
/// implementation can be a sequence and provide its own iterator.
///
/// Conformers of this class must guarantee that left and right children are not being reused when nil to encode information.
/// For example, some implementations of binary trees replace nil right children to point to the successor. Those kinds of
/// implementations are not considered Traversable becuause basic traversal algorithms would fail on that structure.
protocol TraversableBinaryTree : BinaryTree, Sequence {
    
    var iterator : AnyIterator<Item>? {get set}
}


extension TraversableBinaryTree {
    
    public func makeIterator() -> AnyIterator<Item> {
        if let existingIterator = self.iterator {
            return existingIterator
        } else {
            return self.defaultIterator()
        }
        
    }
    
    fileprivate func defaultIterator() -> AnyIterator<Item> {
        return inOrderTraversalIterator(tree: self)
    }

    
    /// This is the deepest node at the far most right in the tree.
    /// The position of this node makes it useful in many algorithmic
    /// like for example to keep the balance property of certain trees.
    ///
    /// - Returns: The bottommost rightmost node in the tree.
    /// - Complexity: O(N)
    public func bottommostRightMostNode() -> Self? {
        
        let iterator: AnyIterator<(node: Self, height: Int)> = postOrderRightToLeftTraversalIterator(tree: self)
        let maximumHeight = self.maximumHeight()
        
        while let tuple = iterator.next() {
            if tuple.height == maximumHeight {                
                return tuple.node
            }
        }
        
        return nil        
    }
}
