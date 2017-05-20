//
//  BinaryTree.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 09/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import Foundation


/// Generic implementation of a binary search tree. 
/// It is a recursive implementation.
/// Just a test, if wanted to force K and V to be equal. where Element.K == Element.V
final class BinarySearchTree<Element : KeyValuePair> : TraversableBinaryTree {
    
    typealias Item = Element
    
    var parent : BinarySearchTree<Element>?
    
    var leftChild : BinarySearchTree<Element>?
    
    var rightChild : BinarySearchTree<Element>?
    
    var item : Element
    
    var iterator: AnyIterator<Element>?
    
    var count: Int
    

    
    // MARK: -  Initializers
    
    
    /// Designated initializer
    ///
    /// - Parameters:
    ///   - parent: reference to the parent node
    ///   - leftChild: reference to the  left subtree
    ///   - rightChild: reference to the right subtree
    ///   - value: item contained in the tree node.
    init(parent: BinarySearchTree?, leftChild: BinarySearchTree?, rightChild: BinarySearchTree?, value:Element) {
        self.parent = parent
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.item = value
        self.count = 0
    }
    
    

    // MARK: - Insertion

    /// Adds a new subtree to the tree, maintaining the order property of a binary search tree
    ///
    /// - Parameter element: Element to be inserted into the tree.
    /// - Complexity: O(log N), N being the number of nodes in the tree
    func insert(newElement : BinarySearchTree) {
 
        if self.item.containsDefaultValues() == true {
            self.replace(element: self, with: newElement)
            return
        }
        
        if newElement.item < self.item {
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
        
        guard self.item != element.item else {
            // If the element to insert is equal to the current tree's root we don't insert
            return
        }
        
        var cameFromLeft : Bool = false
        var parentNode = self
        var currentNode : BinarySearchTree? = self
        
        while (currentNode != nil) {
            parentNode = currentNode!
            if (element.item < (currentNode?.item)! ) {
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
    
    
    /// Delete the node containing the passed key
    ///
    /// - Parameter key: Identifier of the node to be deleted.
    /// - Returns: Whether the element was deleted or not.
    func delete(elementWithKey key : Element.K) -> Bool {
        
        if let elementToDelete = self.search(key: key) {

            if ((elementToDelete.leftChild != nil) && (elementToDelete.rightChild != nil)) {
                // Two children
                let minimumFromRightBranch : BinarySearchTree! = elementToDelete.rightChild?.minimum()
                elementToDelete.item.key = minimumFromRightBranch.item.key
                elementToDelete.item.value = minimumFromRightBranch.item.value
                _ = minimumFromRightBranch.delete(elementWithKey: minimumFromRightBranch.item.key)
                
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
    
    private func replace(element existingElement: BinarySearchTree<Element>, with newElement: BinarySearchTree<Element>?) {
        
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
                existingElement.item.key = new.item.key
                existingElement.item.value = new.item.value
                existingElement.leftChild = new.leftChild
                existingElement.rightChild = new.rightChild
                
                new.leftChild?.parent = existingElement
                new.rightChild?.parent = existingElement
            } else {
                existingElement.item.resetToDefaultValues()
                existingElement.leftChild = nil
                existingElement.rightChild = nil
            }
        }
    }
}
