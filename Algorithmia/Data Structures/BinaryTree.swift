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


class BinarySearchTree<Element : KeyValuePair> {
    
    var parent : BinarySearchTree?
    
    var leftChild : BinarySearchTree?
    
    var rightChild : BinarySearchTree?
    
    /// The content of the node
    var node : Element
    
    var printingQueue = Array<BinarySearchTree<Element>>()
    
    
    
    // MARK -  Initializers
    
    init(parent: BinarySearchTree?, leftChild: BinarySearchTree?, rightChild: BinarySearchTree?, value:Element) {
        self.parent = parent
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.node = value
//        weak var weakSelf = self
//        self.printingQueue.append(weakSelf!)
    }
    
    

    // MARK - Search
    
    /// Searches a node in the tree.
    ///
    /// - Parameter element: A keyValuePair to look for in the tree
    /// - Returns: A tree where the root is the sought value or nil if the element was not found.
    /// - Complexity: O(ln n)
    func search(soughtElement: Element) -> BinarySearchTree? {
        
        if self.node.key == soughtElement.key && self.node.value == soughtElement.value {
            // The shought element is the root of the current tree
            return self
        }
        
        if soughtElement.key < self.node.key {
            return self.leftChild?.search(soughtElement: soughtElement)
        } else {
            return self.rightChild?.search(soughtElement: soughtElement)
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
    
    
    
    // MARK - Insertion

    /// Adds a new subtree to the tree, maintaining the order property of a binary search tree
    ///
    /// - Parameter element: Element to be inserted into the tree.
    func insert(newElement : BinarySearchTree) {
 
        if newElement.node.key < self.node.key {
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
        
        guard self.node.key != element.node.key else {
            // If the element to insert is equal to the current tree's root we don't insert
            return
        }
        
        var cameFromLeft : Bool = false
        var parentNode = self
        var currentNode : BinarySearchTree? = self
        
        while (currentNode != nil) {
            parentNode = currentNode!
            if (element.node.key < (currentNode?.node.key)! ) {
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
    
    
    // MARK - Deletion
    
    func delete(element : BinarySearchTree) -> Bool {
        
        if let elementToDeleteInTree = self.search(soughtElement: element.node) {
            // Is parent's left? or right?
            
            let elementToDeleteChildType = self.childType(of: elementToDeleteInTree)
            
            // How many children does the node to delete have?
            switch elementToDeleteInTree.numberOfChildrenType() {
            case .hasNoChildren:
                self.deleteNodeWithoutChildren(elementToDelete: elementToDeleteInTree, childType: elementToDeleteChildType)
                break
            case .hasLeftChild:
                self.deleteNodeWithOneChild(elementToDelete: elementToDeleteInTree, childType: elementToDeleteChildType, hasLeftChild: true)
                break
            case .hasRightChild:
                self.deleteNodeWithOneChild(elementToDelete: elementToDeleteInTree, childType: elementToDeleteChildType, hasLeftChild: false)
                break
            case .hasTwoChildren:
                self.deleteNodeWithTwoChildren(elementToDelete: elementToDeleteInTree, childTypeOfElementToDelete: elementToDeleteChildType)
                break
            }

            return true
        }
        else {
            return false
        }
    }
    
    private func numberOfChildrenType() -> NodeType {
        
        if ((self.leftChild != nil) && (self.rightChild != nil)) {
            return NodeType.hasTwoChildren
            
        } else if (self.leftChild != nil) {
            return NodeType.hasLeftChild
            
        } else if (self.rightChild != nil) {
            return NodeType.hasRightChild
            
        } else {
            return NodeType.hasNoChildren
        }
    }
    
    private func childType(of element : BinarySearchTree) -> ChildType {
        
        if element.parent == nil {
            // Root node
            return .root
        } else if element.node.key < (element.parent?.node.key)! {
            // Left node
            return .parentLeft
        } else {
            // Right node
            return .parentRight
        }
    }
    
    private func deleteNodeWithoutChildren(elementToDelete: BinarySearchTree, childType: ChildType) {
        switch childType {
            case .root:
                // self.node = nil // make this possible by making node an optional
                break
            case .parentLeft:
                elementToDelete.parent?.leftChild = nil
                elementToDelete.parent = nil
                break
            case .parentRight:
                elementToDelete.parent?.rightChild = nil
                elementToDelete.parent = nil
                break
        }
    }
    
    private func deleteNodeWithOneChild(elementToDelete: BinarySearchTree, childType: ChildType, hasLeftChild: Bool) {
        let replacementChild = hasLeftChild ? elementToDelete.leftChild : elementToDelete.rightChild
        
        switch childType {
            case .root:
                // There's a new root
                elementToDelete.parent = nil
                break
            case .parentLeft:
                elementToDelete.parent?.leftChild = replacementChild
                replacementChild?.parent = elementToDelete.parent
                break
            case .parentRight:
                elementToDelete.parent?.rightChild = replacementChild
                replacementChild?.parent = elementToDelete.parent
                break
        }
    }
    
    private func deleteNodeWithTwoChildren(elementToDelete: BinarySearchTree, childTypeOfElementToDelete: ChildType) {
        
        // First find the minnimum element of the element-to-delete's right's subtree
        let minimumFromRightBranch : BinarySearchTree! = elementToDelete.rightChild?.minimum()
        let childTypeOfMinimumFromRightBranch = self.childType(of: minimumFromRightBranch)
        
        // Delete the minimum (1)
        self.deleteNodeWithoutChildren(elementToDelete: minimumFromRightBranch, childType: childTypeOfMinimumFromRightBranch)
        
        switch childTypeOfElementToDelete {
        case .root:
            // There's a 'new' root, copy the values from the minimum
            self.node.key = minimumFromRightBranch!.node.key
            self.node.value = minimumFromRightBranch!.node.value
            break
        case .parentLeft, .parentRight:
            self.replace(element: elementToDelete, whichHasChildType: childTypeOfElementToDelete, with: minimumFromRightBranch)
            break
        }
    }
    
    func replace(element existingElement: BinarySearchTree, whichHasChildType existingElementChildType : ChildType, with newElement: BinarySearchTree ) {
        newElement.parent = existingElement.parent
        newElement.leftChild = existingElement.leftChild
        newElement.rightChild = existingElement.rightChild
        
        switch existingElementChildType {
        case .root:
            // Don't need to do anything as the existingElement does not have a parent
            break
        case .parentLeft:
            existingElement.parent?.leftChild = newElement
            break
        case .parentRight:
            existingElement.parent?.rightChild = newElement
            break
        }
        
        
        existingElement.leftChild?.parent = newElement
        existingElement.rightChild?.parent = newElement
        existingElement.parent = nil
        existingElement.leftChild = nil
        existingElement.rightChild = nil

    }
    
    func printTree() {

        assert(self.printingQueue.count == 0)
        weak var weakSelf = self
        self.printingQueue.append(weakSelf!)

        while(self.printingQueue.count > 0) {
            
            let firstElement = self.printingQueue.removeFirst()
                
            print("Node: \(firstElement.node.key) has the following children: L:\(firstElement.leftChild?.node.key) R:\(firstElement.rightChild?.node.key)")
                
            if let lc = firstElement.leftChild {
                self.printingQueue.append(lc)
            }
            
            if let rc = firstElement.rightChild {
                self.printingQueue.append(rc)
            }
        }
    }
}
