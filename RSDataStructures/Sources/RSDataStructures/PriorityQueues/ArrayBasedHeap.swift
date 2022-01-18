//
//  ArrayBasedHeap.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 04/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import Foundation

public struct ArrayBasedHeap <HeapElement : KeyValuePair> : PriorityQueue {
    
    /// Item is defined in the PriorityQueue protocol.
    public typealias Item = HeapElement
    
    
    // MARK - Properties ------------------
    
    /// Internal structure to represent the heap
    private var array : [HeapElement]
    
    /// Maximum allowed capacity of the heap
    public let defaultMaximumCapacity : UInt = 10000
    
    /// Maximum number of elements the heap can contain
    public private(set) var capacity : UInt
    
    /// The actual number of elements in the heap at any given time
    public var count : UInt {
        get {
            return UInt(self.array.count)
        }
    }
    
    
    
    // MARK: PriorityQueue protocol ------------------
    
    public var type : PriorityQueueType
    
    public init(type: PriorityQueueType) {
        self.init(type: type, capacity: 10000)
    }
    
    mutating public func enqueue(item : HeapElement) throws {
        
        guard self.count < self.capacity else {
            throw PriorityQueueError.capacityExceeded
        }
        
        self.array.append(item)        
        self.bubbleUp(startingAtIndex: self.count-1)
    }
    
    public func getFirst() -> HeapElement? {
        
        guard self.count > 0 else {
            return nil
        }
        
        return self.array.first
    }
    
    public mutating func dequeue() -> HeapElement? {
        
        guard self.count > 0 else {
            return nil
        }
        
        // Get the top of the heap
        let topElement = self.array.first
        
        // Replace top with last element
        let lastElement = self.array.last
        self.array.removeLast()
        if self.count > 0 {
            self.array[0]  = lastElement!
        }
        
        // Preserve the heap order
        self.bubbleDown(startingAtIndex: 0)
        
        return topElement
    }
    
    
    
    // MARK: Initializers ------------------

    public init(type: PriorityQueueType, elements: [HeapElement]) {
        self.type = type
        self.array = [HeapElement]()
        self.capacity = self.defaultMaximumCapacity
        self.makeHeap(from: elements)
    }

    public init(type: PriorityQueueType, capacity: UInt) {
        self.type = type
        self.capacity = capacity
        self.array = [HeapElement]()
    }

    
    
    // MARK: Helpers ------------------
    
    private func indexOfParentNode(forChildAtIndex indexOfChildNode: UInt) -> UInt? {
        
        guard indexOfChildNode > 0 else {
            return nil
        }
        
        return (indexOfChildNode - 1) / 2 /* Implictit floor operation by Integer division */
    }

    private func indexOfLeftChild(forParentAtIndex indexOfParentNode: UInt) -> UInt {
        return (2 * indexOfParentNode) + 1
    }
    
    mutating private func bubbleUp(startingAtIndex index: UInt) {
        
        guard let parentIndex = self.indexOfParentNode(forChildAtIndex: index) else {
            return
        }
        
        if !keepsHeapCondition(parentIndex: Int(parentIndex), childIndex: Int(index)) {
            swap(index1: Int(parentIndex), index2: Int(index))
            self.bubbleUp(startingAtIndex: parentIndex)
        }
    }

    mutating private func bubbleDown(startingAtIndex index: UInt) {
        
        let parentIndex = index
        let leftChildIndex = self.indexOfLeftChild(forParentAtIndex: index)
        let rightChildIndex = (leftChildIndex + 1)
        var childrenIndexes = [Int]()
        
        if isIndexValid(Int(leftChildIndex)) { childrenIndexes.append(Int(leftChildIndex)) }
        if isIndexValid(Int(rightChildIndex)) { childrenIndexes.append(Int(rightChildIndex)) }
        
        let minMaxIndex = indexOfItemKeepingHeapCondition(type: type, parentIndex: Int(parentIndex), childrenIndexes: childrenIndexes)
        let isHeapConditionKept = (minMaxIndex == parentIndex)
        
        guard !isHeapConditionKept else {
            return
        }
        
        swap(index1: Int(parentIndex), index2: minMaxIndex)
        bubbleDown(startingAtIndex: UInt(minMaxIndex))
    }
    
    private mutating func makeHeap(from elements: [HeapElement] ) {
        for element in elements {
            do {
                try self.enqueue(item: element)
            } catch {
                print("Couldn't add item to the heap.")                
            }
        }
    }
        
    private func comparator<T: Comparable>(forType theType: PriorityQueueType) -> (T, T) -> Bool {
        switch theType {
            case .min:
                return { (a, b) in a < b }
            case .max:
                return { (a, b) in a > b }
        }
    }
    
    private func keepsHeapCondition(parentIndex: Int, childIndex: Int) -> Bool {
        let comparator: (HeapElement, HeapElement) -> Bool = comparator(forType: type)
        return comparator(array[parentIndex], array[childIndex])
    }
    
    private func indexOfItemKeepingHeapCondition(type: PriorityQueueType, parentIndex: Int, childrenIndexes: [Int]) -> Int {
        var minMaxIndex: Int = parentIndex
        for childIndex in childrenIndexes {
            if !keepsHeapCondition(parentIndex: minMaxIndex, childIndex: childIndex) {
                minMaxIndex = childIndex
            }
        }
        
        return minMaxIndex
    }

    private func isIndexValid(_ index: Int) -> Bool {
        return (index >= 0) && (index < array.count)
    }

    private mutating func swap(index1: Int, index2: Int) {
        guard isIndexValid(index1) && isIndexValid(index2) else {
            return
        }
        let temp = array[index1]
        array[index1] = array[index2]
        array[index2] = temp
    }
}
