//
//  ArrayBasedHeap.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 04/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//



struct ArrayBasedHeap <HeapElement : KeyValuePair> : PriorityQueue {
    
    /// Item is defined in the PriorityQueue protocol.
    typealias Item = HeapElement
    
    
    // MARK - Properties ------------------
    
    /// Internal structure to represent the heap.
    private var array : [HeapElement]
    
    /// Maximum allowed capacity of the heap
    public let kDefaultMaximumCapacity : UInt = 10000
    
    /// Maximum number of elements in the heap
    public var capacity : UInt {
        get {
            return UInt(self.array.capacity)
        }
    }
    
    /// The number of elements in the heap
    public var count : UInt {
        get {
            return UInt(self.array.count)
        }
    }
    
    
    
    // MARK: PriorityQueue protocol ------------------
    
    private (set) var type : PriorityQueueType
    
    public init(type: PriorityQueueType) {
        //self.init(type: type, maximumSize: DEFAULT_MAXIMUM_SIZE)
        self.init(type: type, maximumSize: 1000)
    }
    
    mutating public func add(item : HeapElement) throws {
        
//        guard self.count < self.capacity else {
//            throw PriorityQueueError.capacityExceeded
//        }
        
        self.array.append(item)        
        self.bubbleUp(startingAtIndex: self.count-1)
        self.printElements()
    }
    
    public func getTop() -> HeapElement? {
        
        guard self.count > 0 else {
            return nil
        }
        
        return self.array.first
    }
    
    mutating public func extractTop() -> HeapElement? {
        
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
        self.makeHeap(from: elements)
    }

    public init(type: PriorityQueueType, maximumSize: UInt) {
        self.type = type
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
        
        let parentElement = self.array[Int(parentIndex)]
        let childElement = self.array[Int(index)]
        
        switch self.type {
            case .min:
                if childElement.key < parentElement.key { // Swap
                    self.array[Int(parentIndex)] = childElement
                    self.array[Int(index)] = parentElement
                }
                break
            case .max:
                if childElement.key > parentElement.key { // Swap
                    self.array[Int(parentIndex)] = childElement
                    self.array[Int(index)] = parentElement
                }
                break
        }
        
        self.bubbleUp(startingAtIndex: parentIndex)
    }

    mutating private func bubbleDown(startingAtIndex index: UInt) {
        
        let leftChildIndex = self.indexOfLeftChild(forParentAtIndex: index)
        var min_index = Int(index)
        
        for indexIncrement in 0...1 {
            let childIndex = (Int(leftChildIndex) + indexIncrement)
            
            // Check that the child index is not out of bounds
            if (childIndex < Int(self.count)) {
                
                switch self.type {
                case .min:
                    if (self.array[childIndex].key < self.array[min_index].key) {
                        min_index = childIndex
                    }
                    break
                case .max:
                    if (self.array[childIndex].key > self.array[min_index].key) {
                        min_index = childIndex
                    }
                    break
                }
            }
        }
        
        if (min_index != Int(index)) {
            // Swap
            let parentElement = self.array[Int(index)]
            let minChildElement = self.array[min_index]
            self.array[Int(index)] = minChildElement
            self.array[Int(min_index)] = parentElement
            
            bubbleDown(startingAtIndex: UInt(min_index))
        }
    }

    
    private mutating func makeHeap(from elements: [HeapElement] ) {
        for element in elements {
            do {
                try self.add(item: element)
            } catch {
                print("Couldn't add item to the heap.")                
            }
        }
    }
    
    func printElements() {
        for element in self.array {
            element.printPair()
        }
    }
    
}
