//
//  PriorityQueue.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 04/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//



enum PriorityQueueType {
    case min
    case max
}

enum PriorityQueueError : Error {
    case invalidOperationForType
    case capacityExceeded
}


protocol Queue {
    
    associatedtype Item
    
    mutating func enqueue(item: Item) throws
    
    func getFirst() -> Item?
    
    mutating func dequeue() -> Item?

}


protocol PriorityQueue : Queue {
    
    associatedtype Item

    
    var type : PriorityQueueType { get }
    
    init(type: PriorityQueueType)
}
