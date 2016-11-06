//
//  ArrayBasedHeap.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 04/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//



struct ArrayBasedHeap < HeapItem : Comparable> : PriorityQueue {
    
    typealias Item = HeapItem // Item is defined in the PriorityQueue protocol.
    
    private var array : [HeapItem?]
    
    public let kDefaultMaximumCapacity : UInt = 10000
    
    /// Maximum number of elements in the heap
    public var capacity : UInt {
        get {
            return UInt(self.array.capacity)
        }
    }
    
    /// The number of non-nil elements in the heap
    private (set) public var count : UInt = 0
    
    
    
    // MARK: PriorityQueue protocol
    
    private (set) var type : PriorityQueueType
    
    public init(type: PriorityQueueType) {
        //self.init(type: type, maximumSize: DEFAULT_MAXIMUM_SIZE)
        self.init(type: type, maximumSize: 1000)
    }
    
    mutating public func add(item : HeapItem) throws {
        
        guard self.count < self.capacity else {
            throw PriorityQueueError.capacityExceeded
        }
        
        self.array[Int(self.count)] = item
        self.count += 1
        self.bubbleUp(startingAtIndex: self.count-1)
    }
    
//    public func getMin() throws -> HeapItem {
//        
//        guard self.type == PriorityQueueType.min else {
//            throw PriorityQueueError.invalidOperationForType
//        }
//        
//        let min = self.array.first
//        
//        return min
//        
//    }
//
//    public func getMax() throws -> HeapItem {
//    
//    }
//    
//    mutating public func deleteMin() throws -> HeapItem {
//    
//    }
//    
//    mutating public func deleteMax() throws -> HeapItem {
//    
//    }
    
    
    
    // MARK: Initializers

    public init(type: PriorityQueueType, elements: [HeapItem]) {
        self.type = type
        self.array = [HeapItem?](repeating: nil, count: Int(elements.count))
        self.makeHeap(from: elements)
    }

    public init(type: PriorityQueueType, maximumSize: UInt) {
        self.type = type
        self.array = [HeapItem?](repeating: nil, count: Int(maximumSize))
    }

    
    
    // MARK: Helpers
    
    private func indexOfParentNode(forChildAtIndex indexOfChildNode: UInt) -> UInt? {
        // Integer division already providing the floor
        
        guard indexOfChildNode > 0 else {
            return nil
        }
        
        return indexOfChildNode / 2
    }
    
    mutating private func bubbleUp(startingAtIndex index: UInt) {
        
        guard let parentIndex = self.indexOfParentNode(forChildAtIndex: index) else {
            print("EXITING")
            return
        }
        
        let parentElement = self.array[Int(parentIndex)]!
        let childElement = self.array[Int(index)]!
        
        switch self.type {
        case .min:
            if childElement > parentElement { // Swap
                self.array[Int(parentIndex)] = childElement
                self.array[Int(index)] = parentElement
            }
            break
        case .max:
            if childElement < parentElement { // Swap
                self.array[Int(parentIndex)] = childElement
                self.array[Int(index)] = parentElement
            }
            break
        }
        
        self.bubbleUp(startingAtIndex: parentIndex)
    }
    
    private mutating func makeHeap(from elements: [HeapItem] ) {
        for element in elements {
            do {
                try self.add(item: element)
            } catch {
                print("Couldn't add item to the heap.")                
            }
        }
    }
}
