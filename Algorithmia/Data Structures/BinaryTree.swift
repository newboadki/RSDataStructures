//
//  BinaryTree.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 09/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import Foundation

enum NodeType {
    case hasTwoChildren
    case hasLeftChild
    case hasRightChild
    case hasNoChildren
}

enum ChildType {
    case parentLeft
    case parentRight
    case root
}

enum BinarySearchTraversalTraversalType {
    case preOrder
    case inOrder
    case postOrder
}


/// Generic implementation of a binary search tree. 
/// It is a recursive implementation.
class BinarySearchTree<Element : KeyValuePair> /*Just a test, if wanted to force K and V to be equal. where Element.K == Element.V*/ {
    
    var parent : BinarySearchTree?
    
    var leftChild : BinarySearchTree?
    
    var rightChild : BinarySearchTree?
    
    /// The content of the node
    var node : Element
    
    var type: BinarySearchTraversalTraversalType = .inOrder
    
    
    // MARK: -  Initializers
    
    init(parent: BinarySearchTree?, leftChild: BinarySearchTree?, rightChild: BinarySearchTree?, value:Element) {
        self.parent = parent
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.node = value
    }
    
    

    // MARK: - Search
    
    /// Searches a node in the tree.
    ///
    /// - Parameter key: The key to look for in the tree.
    /// - Returns: A tree where the root is a node with the sought key or nil if the key was not found.
    /// - Complexity: O(ln n)
    func search(key: Element.K) -> BinarySearchTree? {
        
        if self.node.key == key {
            // The shought element is the root of the current tree
            return self
        }
        
        if key < self.node.key {
            return self.leftChild?.search(key: key)
        } else {
            return self.rightChild?.search(key: key)
        }
    }
    
    /// Minimum element
    ///
    /// - Returns: The left-most leave of the tree, which has the minimum value as its node's key
    func minimum() -> BinarySearchTree? {
        var min : BinarySearchTree? = self
        while (min?.leftChild != nil) {
            min = min?.leftChild
        }
        
        return min
    }

    /// Maximum element
    ///
    /// - Returns: The right most leave of the tree, which has the maximum value as its node's key
    func maximum() -> BinarySearchTree? {
        
        var max : BinarySearchTree? = self
        while (max?.rightChild != nil) {
            max = max?.rightChild
        }
        
        return max
    }
    
    
    
    // MARK: - Insertion

    /// Adds a new subtree to the tree, maintaining the order property of a binary search tree
    ///
    /// - Parameter element: Element to be inserted into the tree.
    func insert(newElement : BinarySearchTree) {
 
        if self.node.containsDefaultValues() == true {
            self.replace(element: self, with: newElement)
            return
        }
        
        if newElement.node < self.node {
            if let leftC = self.leftChild {
                leftC.insert(newElement: newElement)
            } else {
                self.leftChild = newElement
                newElement.parent = self
            }
        } else {
            if let rightC = self.rightChild {
                rightC.insert(newElement: newElement)
            } else {
                self.rightChild = newElement
                newElement.parent = self
            }
        }
    }
    
    /// Adds a new subtree to the tree, maintaining the order property of a binary search tree
    ///
    /// - Parameter element: Element to be inserted into the tree.
    func insertIterative(element : BinarySearchTree) {
        
        guard self.node != element.node else {
            // If the element to insert is equal to the current tree's root we don't insert
            return
        }
        
        var cameFromLeft : Bool = false
        var parentNode = self
        var currentNode : BinarySearchTree? = self
        
        while (currentNode != nil) {
            parentNode = currentNode!
            if (element.node < (currentNode?.node)! ) {
                currentNode = currentNode!.leftChild
                cameFromLeft = true
            } else {
                currentNode = currentNode!.rightChild
                cameFromLeft = false
            }
        }
        
        // Current node is nil. Insert the new tree into the parent
        switch cameFromLeft {
        case true:
            parentNode.leftChild = element
            break
        case false:
            parentNode.rightChild = element
            break
        }
    }
    
    
    // MARK: - Deletion
    
    // I think we should be passing just the key we want to delete: deleteElement(withKey: Int)
    func delete(elementWithKey key : Element.K) -> Bool {
        
        if let elementToDelete = self.search(key: key) {

            if ((elementToDelete.leftChild != nil) && (elementToDelete.rightChild != nil)) {
                // Two children
                let minimumFromRightBranch : BinarySearchTree! = elementToDelete.rightChild?.minimum()
                elementToDelete.node.key = minimumFromRightBranch.node.key
                elementToDelete.node.value = minimumFromRightBranch.node.value
                _ = minimumFromRightBranch.delete(elementWithKey: minimumFromRightBranch.node.key)
                
            }
            else if (elementToDelete.leftChild != nil) {
                // One left child
                self.replace(element: elementToDelete, with: elementToDelete.leftChild)
            }
            else if (elementToDelete.rightChild != nil) {
                // One right child
                self.replace(element: elementToDelete, with: elementToDelete.rightChild)
            }
            else {
                // No children
                self.replace(element: elementToDelete, with: nil)
            }
            
            return true
        }
        else {
            return false
        }
    }
    
    func replace(element existingElement: BinarySearchTree<Element>, with newElement: BinarySearchTree<Element>?) {
        
        if let parentNode = existingElement.parent {
            
            if existingElement === parentNode.leftChild {
                parentNode.leftChild = newElement
            } else {
                parentNode.rightChild = newElement
            }

            if let new = newElement {
                new.parent = parentNode
            }

            existingElement.parent = nil
            existingElement.leftChild = nil
            existingElement.rightChild = nil
        } else {
            // You are replacing the root, just override node values
            if let new = newElement {
                existingElement.node.key = new.node.key
                existingElement.node.value = new.node.value
                existingElement.leftChild = new.leftChild
                existingElement.rightChild = new.rightChild
                
                new.leftChild?.parent = existingElement
                new.rightChild?.parent = existingElement
            } else {
                existingElement.node.resetToDefaultValues()
                existingElement.leftChild = nil
                existingElement.rightChild = nil
            }
        }
    }
}



extension BinarySearchTree : Sequence {
    
    func makeIterator() -> BinaryTreeIterator<Element> {
        return BinaryTreeIterator<Element>(tree: self, type:self.type)
    }
    
}
