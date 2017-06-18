//
//  BinaryHeap.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 06/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

private class NodeDirectAccecssIndirectStorage<T:KeyValuePair> {
    var directAccessToNodes: Dictionary<T.K, BasicBinaryHeap<T>> = [:]
}

final public class BasicBinaryHeap<T: KeyValuePair> : CompleteBinaryTree, TraversableBinaryTree, PriorityQueue {
    
    typealias Item = T
    
    /// Reference to the left subtree
    weak var parent: BasicBinaryHeap?
    
    /// Reference to the left subtree
    var leftChild: BasicBinaryHeap?
    
    /// Reference to the right subtree
    var rightChild: BasicBinaryHeap?
    
    /// A container of information.
    var item: Item?
    
    /// The number of nodes in the tree
    var count: Int = 0
    
    var type: PriorityQueueType = .min

    var iterator: AnyIterator<T>?
    
    private var directAccessToNodes: NodeDirectAccecssIndirectStorage<T>
    
    /// Designated initializer
    ///
    /// - Parameters:
    ///   - parent: reference to the parent node
    ///   - leftChild: reference to the  left subtree
    ///   - rightChild: reference to the right subtree
    ///   - value: item contained in the tree node.
    public init(value: T,
                parent: BasicBinaryHeap?,
                leftChild: BasicBinaryHeap?,
                rightChild: BasicBinaryHeap?,
                type: PriorityQueueType) {
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.item = value
        self.count = 1
        self.type = type
        self.directAccessToNodes = NodeDirectAccecssIndirectStorage<T>()
        self.directAccessToNodes.directAccessToNodes[value.key] = self
    }
    
    private init(value: T,
                parent: BasicBinaryHeap?,
                leftChild: BasicBinaryHeap?,
                rightChild: BasicBinaryHeap?,
                type: PriorityQueueType,
                nodeIndirectStorage: NodeDirectAccecssIndirectStorage<T>) {
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.item = value
        self.count = 1
        self.type = type
        self.directAccessToNodes = nodeIndirectStorage
        self.directAccessToNodes.directAccessToNodes[value.key] = self
    }
    
    
    /// Minimum
    ///
    /// - Returns: The node with the smallest key
    /// - Complexity: O(1)
    public func top() -> BasicBinaryHeap? {
        if self.isEmpty() {
            // If empty tree
            return nil
        } else {
            // Otherwise return the root
            return self
        }        
    }
    
    func minimum() -> BasicBinaryHeap<T>? {
        return self.top()
    }
    
    func maximum() -> BasicBinaryHeap<T>? {
        return self.top()
    }
    
    /// Removes and returns the top element of the heap.
    /// Depending on the type of the heap, this will be the
    /// min or max element in the heap.
    ///
    /// - Returns: The top of the heap.
    /// - Complexity: O(log(N)) which is the height of the tree.
    public func extractTop() -> BasicBinaryHeap? {
        
        guard !self.isEmpty() else {
            // If the tree is empty
            return nil
        }
        
        // Create a copy of the top of the heap.
        // TODO: This might be an unnecessary copy for value types, since passing it as a parameter will copy it.
        let top = BasicBinaryHeap<T>(value: self.item!.copy(), parent: nil, leftChild: nil, rightChild: nil, type:self.type, nodeIndirectStorage: self.directAccessToNodes)
        
        // Find the replacement, which is the bottommost rightmost node
        let replacement = self.bottommostRightmostNode()
        
        // Replace values.
        self.item = replacement?.item
        
        // Delete the replacement
        if replacement == replacement?.parent?.leftChild {
            replacement?.parent?.leftChild = nil
        } else if replacement == replacement?.parent?.rightChild {
            replacement?.parent?.rightChild = nil
        } else {
            // Root node
            self.item = nil
        }
        
        // Restore heap properties
        let lastNodeToBeSwapped = self.bubbleDown()
        
        // There won't be an item when deleting the root.
        // The root node stays, but the item is nilled out.
        if let item = lastNodeToBeSwapped.item {
            self.directAccessToNodes.directAccessToNodes[item.key] = lastNodeToBeSwapped
        }
        
        // Delete it from the direct access map
        self.directAccessToNodes.directAccessToNodes.removeValue(forKey: top.item!.key)
        
        return top
    }

    
    /// Finds a node in the tree with the given key
    ///
    /// - Parameter key: Key to search for.
    /// - Returns: A node with the given key or nil if not found.
    /// - TODO: Not implemented
    public func search(key: T.K) -> BasicBinaryHeap? {
        return nil
    }
    
    /// Removes a node from the tree, that has a matching key.
    ///
    /// - Parameter elementWithKey: the key the element to be deleted must have.
    /// - Returns: True if an element was deleted.
    /// - TODO: Not implemented
    public func delete(elementWithKey: T.K) -> Bool {
        return false
    }
    
    /// Adds a new node to the tree.
    ///
    /// - Parameter item: new item to be added to the tree.
    /// - Complexity: O(Log(N)).
    public func insert(item: T) {
        
        guard !self.isEmpty() else {
            self.item = item.copy()
            return
        }
        
        // Create a new node
        let newNode = BasicBinaryHeap<T>(value: item, parent:nil, leftChild: nil, rightChild: nil, type: self.type, nodeIndirectStorage: self.directAccessToNodes)
        
        // Insert the new node into the first free place that respects the completeness of the tree.
        // All levels complete, except the last one that can have free places, but it's complete from left to right
        let nodeWithSpace = self.nextIncompleteNode()
        
        if nodeWithSpace.leftChild == nil {
            nodeWithSpace.leftChild = newNode
        } else if nodeWithSpace.rightChild == nil {
            nodeWithSpace.rightChild = newNode
        }
        
        newNode.parent = nodeWithSpace
        
        // Bubble up to restore properties of a heap
        let insertedNode = newNode.bubbleUp()
        self.directAccessToNodes.directAccessToNodes[insertedNode.item!.key] = insertedNode
    }
    
    public func update(key:T.K, to newKey: T.K) {
        if let node = self.directAccessToNodes.directAccessToNodes[key] {
            node.item!.key = newKey
            let newRef = node.bubbleUp()
            self.directAccessToNodes.directAccessToNodes.removeValue(forKey: key)
            self.directAccessToNodes.directAccessToNodes[newKey] = newRef
        }
    }
    
    private func bubbleUp() -> BasicBinaryHeap<T> {
    
        var current: BasicBinaryHeap<T>? = self
        
        while /* Not at the root */(current?.parent != nil) &&
            /* Doesn't conserve heap property */(!self.heapPropertiesAreKept(parent: current!.parent, child: current!, type: self.type)) {
                
                // If we got in, we know there's a parent.
                swapItems(parent: current!.parent!, child: current!)
                self.directAccessToNodes.directAccessToNodes[current!.item!.key] = current!
                current = current!.parent
        }
        
        return current!
    }

    private func bubbleDown() -> BasicBinaryHeap<T> {

        var current: BasicBinaryHeap<T>? = self
        
        while let c = current,
              let childToSwap = c.relevantChildrenToSwap(),
            /* Not a leaf */(c.numberOfChildren() > 0) &&
            /* Doesn't conserves heap property */(!self.heapPropertiesAreKept(parent: c, child: childToSwap, type: self.type)) {
                
                // If we got in, we know there's a parent.
                swapItems(parent: c, child: childToSwap)
                self.directAccessToNodes.directAccessToNodes[c.item!.key] = c
                current = childToSwap
        }
        
        return current!
    }
    
    private func heapPropertiesAreKept(parent: BasicBinaryHeap<T>?, child: BasicBinaryHeap<T>, type: PriorityQueueType) -> Bool {
        
        if let p = parent {
            switch type {
            case .min:
                return p.item! < child.item!
            case .max:
                return p.item! > child.item!
            }
        } else {
            return true
        }
    }
    
    private func swapItems(parent: BasicBinaryHeap<T>, child: BasicBinaryHeap<T>) {
        let temp = parent.item
        parent.item = child.item
        child.item = temp
    }
    
    /// TODO: Tidy up. Reduce duplication. Use Swifts max, min functions.
    private func relevantChildrenToSwap() -> BasicBinaryHeap<T>? {

        guard self.numberOfChildren() > 0 else {
            return nil
        }
        
        if self.numberOfChildren() == 1 {
            if let leftChild = self.leftChild {
                switch type {
                    case .min:
                        return (self.item! > leftChild.item!) ? leftChild : nil
                    case .max:
                        return self.item! < leftChild.item! ? leftChild : nil
                }

            } else {
                switch type {
                case .min:
                    return (self.item! > self.rightChild!.item!) ? rightChild : nil
                case .max:
                    return self.item! < self.rightChild!.item! ? rightChild : nil
                }
                
            }
        } else {
            switch type {
                case .min:
                    let minChild = BasicBinaryHeap.minBetween(n1: self.leftChild!, n2: self.rightChild!)
                    return (self.item! > minChild.item!) ? minChild : nil
                case .max:
                    let maxChild = BasicBinaryHeap.maxBetween(n1: self.leftChild!, n2: self.rightChild!)
                    return self.item! < maxChild.item! ? maxChild : nil
            }
        }
    }
    
    private static func minBetween(n1: BasicBinaryHeap<T>, n2: BasicBinaryHeap<T>) -> BasicBinaryHeap<T> {
        
        if n1.item! < n2.item! {
            return n1
        } else {
            return n2
        }
        
    }

    private static func maxBetween(n1: BasicBinaryHeap<T>, n2: BasicBinaryHeap<T>) -> BasicBinaryHeap<T> {
        
        if n1.item! > n2.item! {
            return n1
        } else {
            return n2
        }
    }

    
    // MARK: PRIORITY QUEUE
    
    /// Dequeues the oldest element in the queue.
    ///
    /// - Returns: The oldest element in the queue, which gets removed from it.
    func dequeue() -> T? {
        return self.extractTop()?.item
    }
    
    /// Returns the oldest element in the queue.
    ///
    /// - Returns: The oldest element in the queue. It does not dequeue it.
    func getFirst() -> T? {
        return self.top()?.item
    }
    
    /// Adds an element to the queue
    ///
    /// - Parameter item: Item to be added
    /// - Throws: There are cases where the operation might fail. For example if there is not enough space.
    func enqueue(item: T) throws {
        self.insert(item: item)
    }
    
    init(type: PriorityQueueType) {
        self.type = type
        self.directAccessToNodes = NodeDirectAccecssIndirectStorage<T>()
    }
}


