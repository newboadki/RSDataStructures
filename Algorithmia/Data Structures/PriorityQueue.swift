//
//  PriorityQueue.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 04/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//



public enum PriorityQueueType {
    case min
    case max
}

public enum PriorityQueueError : Error {
    case invalidOperationForType
    case capacityExceeded
}



/// They mainly add semantics to a queue. Elements are returned in order according to some rule.
protocol PriorityQueue : Queue {
    
    associatedtype Item

    
    var type : PriorityQueueType { get }
    
    init(type: PriorityQueueType)
}
