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


protocol PriorityQueue {
    
    associatedtype Item

    
    var type : PriorityQueueType { get }
    
    init(type: PriorityQueueType)
    
    mutating func add(item: Item) throws
    
    func getTop() -> Item?
    
    mutating func extractTop() -> Item?
}
