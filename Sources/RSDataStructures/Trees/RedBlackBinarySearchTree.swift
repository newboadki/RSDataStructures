//
//  RedBlackBinarySearchTree.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 03/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


public final class RedBlackBinarySearchTree<T: KeyValuePair> : BinarySearchTree, TraversableBinaryTree {

    public enum RedBlackTreeColor {
        case black
        case red
    }

    // MARK: From BinaryTree protocol
    public typealias Item = T
    
    public var leftChild : RedBlackBinarySearchTree<T>?
    
    public var rightChild : RedBlackBinarySearchTree<T>?
    
    public var item : T?
    
    /// TODO: Implement
    public var parent :RedBlackBinarySearchTree<T>?
    
    // MARK: From TrversableTree protocol
    /// Traversable binary trees accept an interator to enumerate its elements.
    /// By default this class provides an in-order iterator.
    public var iterator: AnyIterator<T>?
    
    
    // MARK: Specific to Red Black trees.
    
    /// Number of nodes in the tree
    public fileprivate(set) var count: Int = 0
    
    /// The root is always black
    /// A given node won't have another red parent of child.
    /// All paths from root to leaves have the same number of black nodes
    fileprivate(set) public var color: RedBlackTreeColor
    
    
    // MARK: -  Initializers
    
    /// Designated initializer
    ///
    /// - Parameters:
    ///   - parent: reference to the parent node
    ///   - leftChild: reference to the  left subtree
    ///   - rightChild: reference to the right subtree
    ///   - value: item contained in the tree node.
    public init(leftChild: RedBlackBinarySearchTree?,
                rightChild: RedBlackBinarySearchTree?,
                value: T,
                color: RedBlackTreeColor) {
        
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.item = value
        self.count = 1
        self.color = color
    }
    
    
    /// Convenience initialiser to create a tree from an array
    ///
    /// - Parameter elements: array literal of keyValue pairs
    public init(arrayLiteral elements: T...)
    {
        var isFirstElement = true
        self.count = 0
        self.color = .black
        
        for element in elements {
            if isFirstElement {
                self.count = 1
                self.item = element
                isFirstElement = false
            } else {
                self.count += 1
                self.insert(item: element)
            }
        }        
    }

    
    /// Add new node to the tree
    ///
    /// - Parameter item: key-value pair that will be inserted into the tree
    /// - Complexity: O(log(N))
    public func insert(item: T) {
        self.insertNode(item)
        self.color = .black
    }
    
    private func insertNode(_ item: T) {
        guard let currentItem = self.item else {
            // If self.item is nil, assign the new item to it
            self.item = item
            return
        }
        
        if item < currentItem {
            if self.leftChild == nil {
                self.leftChild = RedBlackBinarySearchTree<T>(leftChild: nil, rightChild: nil, value: item, color: .red)
            } else {
                self.leftChild!.insertNode(item)
            }
        } else if item > currentItem {
            if self.rightChild == nil {
                self.rightChild = RedBlackBinarySearchTree<T>(leftChild: nil, rightChild: nil, value: item, color: .red)
            } else {
                self.rightChild!.insertNode(item)
            }
        } else {
            self.item = item
        }
        
        if (self.rightChild?.isRed() ?? false) && !(self.leftChild?.isRed() ?? false) {
            self.rotateLeft()
        }
        
        if (self.leftChild?.isRed() ?? false) && (self.leftChild?.leftChild?.isRed() ?? false) {
            self.rotateRight()
        }

        if (self.leftChild?.isRed() ?? false) && (self.rightChild?.isRed() ?? false) {
            self.flipColors()
        }

        // TODO: UPDATE SIZES
    }
    
    
    public func delete(elementWithKey key: T.K) -> Bool {
        guard let nodeToDelete = self.search(key: key) else {
            return false
        }
        
        // Case 1: Node has no children (leaf node)
        if nodeToDelete.leftChild == nil && nodeToDelete.rightChild == nil {
            if nodeToDelete === self {
                // Deleting the root node and it's the only node
                self.item = nil
                return true
            }
            // For now, just replace with nil - this is simplified deletion
            self.replaceNode(nodeToDelete, with: nil)
            return true
        }
        
        // Case 2: Node has only one child
        if nodeToDelete.leftChild == nil {
            self.replaceNode(nodeToDelete, with: nodeToDelete.rightChild)
            return true
        } else if nodeToDelete.rightChild == nil {
            self.replaceNode(nodeToDelete, with: nodeToDelete.leftChild)
            return true
        }
        
        // Case 3: Node has two children
        // Find the inorder successor (minimum in the right subtree)
        let successor = nodeToDelete.rightChild!.minimum()!
        
        // Copy the successor's data to the node to be deleted
        nodeToDelete.item = successor.item
        
        // Now delete the successor (which has at most one child)
        if successor.rightChild == nil {
            self.replaceNode(successor, with: nil)
        } else {
            self.replaceNode(successor, with: successor.rightChild)
        }
        
        return true
    }
    
    private func replaceNode(_ nodeToReplace: RedBlackBinarySearchTree<T>, with replacement: RedBlackBinarySearchTree<T>?) {
        // Find the parent and update the appropriate child reference
        if nodeToReplace === self {
            // We're trying to replace the root
            if let replacement = replacement {
                self.item = replacement.item
                self.leftChild = replacement.leftChild
                self.rightChild = replacement.rightChild
                self.color = replacement.color
            }
            return
        }
        
        // Find the parent by searching through the tree
        if let parent = self.findParent(of: nodeToReplace) {
            if parent.leftChild === nodeToReplace {
                parent.leftChild = replacement
            } else {
                parent.rightChild = replacement
            }
        }
    }
    
    private func findParent(of node: RedBlackBinarySearchTree<T>) -> RedBlackBinarySearchTree<T>? {
        if self.leftChild === node || self.rightChild === node {
            return self
        }
        
        if let leftParent = self.leftChild?.findParent(of: node) {
            return leftParent
        }
        
        if let rightParent = self.rightChild?.findParent(of: node) {
            return rightParent
        }
        
        return nil
    }

    
    /// Helper method to determine if a node is red
    ///
    /// - Returns: True if the node is red. False otherwise.
    public func isRed() -> Bool {
        return (self.color == .red)
    }
    
    /// Validates all Red-Black tree properties
    ///
    /// - Returns: True if the tree satisfies all Red-Black properties
    public func isValidRedBlackTree() -> Bool {
        return isValidRedBlackTreeHelper().isValid
    }
    
    /// Helper method that validates Red-Black properties and returns black height
    private func isValidRedBlackTreeHelper() -> (isValid: Bool, blackHeight: Int) {
        // Property 1: Every node is either red or black (implicitly satisfied by enum)
        
        // Empty tree or leaf (nil nodes are considered black)
        if self.item == nil {
            return (isValid: true, blackHeight: 1) // nil nodes count as black with height 1
        }
        
        // Property 2: The root is black (check only at the root level)
        // We'll validate this at the public method level
        
        // Property 3: All leaves (nil nodes) are black (implicitly satisfied)
		let leftResult = self.leftChild?.isValidRedBlackTreeHelper() ?? (isValid: true, blackHeight: 1)
		let rightResult = self.rightChild?.isValidRedBlackTreeHelper() ?? (isValid: true, blackHeight: 1)

        // If either subtree is invalid, the whole tree is invalid
        if !leftResult.isValid || !rightResult.isValid {
            return (isValid: false, blackHeight: 0)
        }
        
        // Property 4: If a node is red, then both its children are black
        if self.color == .red {
            if (self.leftChild?.color == .red) || (self.rightChild?.color == .red) {
                return (isValid: false, blackHeight: 0)
            }
        }
        
        // Property 5: All paths from any node to its descendant leaves contain the same number of black nodes
        if leftResult.blackHeight != rightResult.blackHeight {
            return (isValid: false, blackHeight: 0)
        }
        
        // Calculate black height for this node
        let blackHeight = leftResult.blackHeight + (self.color == .black ? 1 : 0)
        
        return (isValid: true, blackHeight: blackHeight)
    }
    
    /// Gets the black height of the tree
    ///
    /// - Returns: The number of black nodes from root to any leaf
    public func blackHeight() -> Int {
        if self.item == nil {
            return 1 // Empty tree has black height 1
        }
        return isValidRedBlackTreeHelper().blackHeight
    }
    
    /// Counts the total number of nodes in the tree
    ///
    /// - Returns: Total number of nodes
    public func nodeCount() -> Int {
        if self.item == nil {
            return 0
        }
        
        let leftCount = self.leftChild?.nodeCount() ?? 0
        let rightCount = self.rightChild?.nodeCount() ?? 0
        
        return 1 + leftCount + rightCount
    }
    
    /// Validates Red-Black tree including root-specific property
    ///
    /// - Returns: True if tree satisfies all Red-Black properties including root being black
    public func isCompletelyValidRedBlackTree() -> Bool {
        // Check if empty tree
        if self.item == nil {
            return true
        }
        
        // Property 2: Root must be black
        if self.color != .black {
            return false
        }
        
        // Check all other properties
        return isValidRedBlackTree()
    }

    
    
    // MARK: - TRANSFORMATIONS TO KEEP RED-BLACK PROPERTIES -
    
    private func rotateLeft() {
        let right = self.rightChild
        
        // Swap items
        let tempItem = self.item
        self.item = right?.item
        right?.item = tempItem
        
        self.rightChild = right?.rightChild
        right?.rightChild = self.leftChild
        self.leftChild = right
    }
    
    private func rotateRight() {
        let left = self.leftChild
        let leftLeft = left?.leftChild
        
        // Swap the items
        let tempItem = self.item
        self.item = left?.item
        left?.item = tempItem
        
        self.leftChild = leftLeft
        left?.leftChild = left?.rightChild
        left?.rightChild = self.rightChild
        
        self.rightChild = left
    }

    private func flipColors() {
        self.leftChild?.color = .black
        self.rightChild?.color = .black
        self.color = .red
    }

}

// MARK: - EXPRESSIBLE-BY-ARRAY-LITERAL -

extension RedBlackBinarySearchTree : ExpressibleByArrayLiteral
{
    public typealias Element = T
}

