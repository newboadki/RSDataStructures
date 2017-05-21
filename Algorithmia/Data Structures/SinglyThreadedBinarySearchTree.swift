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

    var minNode: SinglyThreadedBinarySearchTree<Element>?
    
    
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
        self.minNode = self
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
                self.updateMinimum(newCandidate: newNode)
                self.count += 1
                self.propagateCount(startingFrom: self.parent)
            }
        } else {
            if let rc = self.rightChild, self.rightChildLinksToSuccessor==false {
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
                self.updateMinimum(newCandidate: newNode)
                self.count += 1
                self.propagateCount(startingFrom: self.parent)
                
            }
        }
    }

    public func delete(elementWithKey key: Element.K) -> Bool {
        
        if let nodeToBeDeleted = self.search(key: key) {
         
            if ((nodeToBeDeleted.rightChildLinksToSuccessor == false) &&
                (nodeToBeDeleted.leftChild != nil) &&
                (nodeToBeDeleted.rightChild != nil)) {
                // TWO CHILDREN
                let minimumFromRightBranch: SinglyThreadedBinarySearchTree<Element>! = nodeToBeDeleted.rightChild?.minimum()
                
                // In this case we are not deleting the physical node but replacingthe values in
                // the node to be deleted by the values in the minimum from the right branch.be
                nodeToBeDeleted.item.key = minimumFromRightBranch.item.key
                nodeToBeDeleted.item.value = minimumFromRightBranch.item.value
                
                // Delete the minimum from the right branch
                _ = minimumFromRightBranch.delete(elementWithKey:minimumFromRightBranch.item.key)
                
            } else if (nodeToBeDeleted.leftChild != nil) {
                // ONE LEFT CHILD
                replace(element: nodeToBeDeleted, with: nodeToBeDeleted.leftChild)
                
            } else if ((nodeToBeDeleted.rightChildLinksToSuccessor == false) && (nodeToBeDeleted.rightChild != nil)) {
                // ONE RIGHT CHILD
                replace(element: nodeToBeDeleted, with: nodeToBeDeleted.rightChild)
                
            } else {
                // NO CHILDREN, CHECK WHAT THE RIGHT REF. IS BEING USED FOR.
                replace(element: nodeToBeDeleted, with: nil)
            }
            return true
            
        } else {
            return false
        }
    }
    
    private func replace(element existingElement: SinglyThreadedBinarySearchTree<Element>, with newElement: SinglyThreadedBinarySearchTree<Element>?) {
        
        if let parent = existingElement.parent {
            
            if existingElement === parent.leftChild {
                parent.leftChild = newElement

            } else if existingElement === parent.rightChild {
                if existingElement.rightChildLinksToSuccessor == false {
                    parent.rightChild = newElement
                }                
            }
            
            if let ne = newElement {
                ne.parent = parent
            }
            
            if existingElement.rightChildLinksToSuccessor == true  {
                
                if let ne = newElement {
                    let maximumNodeOfSubtree = ne.maximum()
                    ne.rightChildLinksToSuccessor = true
                    ne.rightChild = existingElement.rightChild
                    maximumNodeOfSubtree?.rightChild = existingElement.rightChild // Assuming here that the tree is weel-constructed and that the maximum of any subtree has

                } else if existingElement.parent?.rightChild === existingElement {
                    existingElement.parent?.rightChildLinksToSuccessor = true
                    existingElement.parent?.rightChild = existingElement.rightChild
                }
            }

            // If we are deleting the minimum, find a new one and propagate it upwards
            if existingElement.minNode === existingElement {
                if let ne = newElement {
                    // the new element replacing the min is the new minimum
                    ne.minNode = ne
                    propagateMinimum(startingFrom: ne)
                } else {
                    parent.minNode = parent
                    propagateMinimum(startingFrom: parent)
                }
            }
            
            existingElement.decrementCountByOne(startingFrom: existingElement.parent)
            existingElement.leftChild = nil
            existingElement.rightChild = nil
            existingElement.parent = nil
            existingElement.minNode = nil
            
        } else {
            // REPLACING THE ROOT
            if let ne = newElement {
                existingElement.item.key = ne.item.key
                existingElement.item.value = ne.item.value
                existingElement.leftChild = ne.leftChild
                existingElement.rightChild = ne.rightChild
                
                ne.leftChild?.parent = existingElement
                ne.rightChild?.parent = existingElement
                ne.count = (existingElement.count - 1)
                
            } else {
                // We are destroying the root
                existingElement.item.resetToDefaultValues()
                existingElement.leftChild = nil
                existingElement.rightChild = nil
                existingElement.minNode = nil
                existingElement.count = 0
            }
        }
    }
    
    
    private func updateMinimum(newCandidate: SinglyThreadedBinarySearchTree<Element>) {
        if newCandidate.item < (self.minNode?.item)! {
            self.minNode = newCandidate
            propagateMinimum(startingFrom: self.minNode!)
        }
    }
    
    private func propagateMinimum(startingFrom node: SinglyThreadedBinarySearchTree<Element>) {
        
        var current: SinglyThreadedBinarySearchTree<Element>? = node
        
        // Current is left child
        while current?.parent?.leftChild === current {
            current?.parent?.minNode = current?.minNode
            current = current?.parent
        }
    }
    
    private func propagateCount(startingFrom node: SinglyThreadedBinarySearchTree<Element>?) {
        
        var current: SinglyThreadedBinarySearchTree<Element>? = node
        
        // Current is left child
        while current != nil {
            current?.count += 1
            current = current?.parent
        }
    }

    private func decrementCountByOne(startingFrom node: SinglyThreadedBinarySearchTree<Element>?) {
        
        var current: SinglyThreadedBinarySearchTree<Element>? = node
        
        // Current is left child
        while current != nil {
            current?.count -= 1
            current = current?.parent
        }
    }

    
    fileprivate func next(after node: SinglyThreadedBinarySearchTree<Element>) -> SinglyThreadedBinarySearchTree<Element>? {
        
        var current: SinglyThreadedBinarySearchTree<Element>? = node
        
        if current!.rightChildLinksToSuccessor {
            current = current!.rightChild
        } else {
            current = current!.rightChild?.minimum()
        }

        return current
    }
    
    
    /// Maximum element
    ///
    /// - Returns: The right most leave of the tree, which has the maximum value as its node's key
    /// - Complexity: O(log N), with N being the number of nodes in the tree.
    func maximum() -> SinglyThreadedBinarySearchTree<Element>? {
        
        var max = self
        while (max.rightChild != nil && max.rightChildLinksToSuccessor == false) {
            max = max.rightChild!
        }
        
        return max
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
    
    
    /// Complexity: O(1)
    public var startIndex: Index {
        get {
            return SinglyThreadedBinaryTreeIndex<Element>(node: self.minNode, tag: 0)
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



