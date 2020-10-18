//
//  File.swift
//  
//
//  Created by Borja Arias Drake on 18/10/2020.
//

import Foundation

private class _AnyQueueBase<Item>: Queue {
    
    init() {
        guard type(of: self) != _AnyQueueBase.self else {
            fatalError("_AnyQueueBase<Item> is abstract. You must subclass.")
        }
    }
    
    func enqueue(item: Item) throws {
        fatalError("Must override.")
    }

    func getFirst() -> Item? {
        fatalError("Must override.")
    }

    func dequeue() -> Item? {
        fatalError("Must override.")
    }
}

// Box class
// final subclass of our abstract base
// Inherits the protocol conformance
// Links Concrete.Item (associated type) to _AnyQueueBase.Item (generic parameter)
private final class _AnyQueueBox<Concrete: Queue>: _AnyQueueBase<Concrete.Item> {
    
    // Variable used since we're calling mutating functions
    var concrete: Concrete
    
    init(_ concrete: Concrete) {
        self.concrete = concrete
    }
    
    override func enqueue(item: Item) throws {
        try concrete.enqueue(item: item)
    }

    override func getFirst() -> Item? {
        return concrete.getFirst()
    }

    override func dequeue() -> Item? {
        return concrete.dequeue()
    }
}


// Public type erasing wrapper
// Implements the Queue protocol
// Generic around the associated type
public struct AnyQueue<Item>: Queue {
    
    private let box: _AnyQueueBase<Item>
    
    // Initializer takes our concrete implementer of Row i.e. FileCell
    public init<Concrete: Queue>(_ concrete: Concrete) where Concrete.Item == Item {
        box = _AnyQueueBox(concrete)
    }
    
    public func enqueue(item: Item) throws {
        try box.enqueue(item: item)
    }

    public func getFirst() -> Item? {
        return box.getFirst()
    }

    @discardableResult
    public func dequeue() -> Item? {
        return box.dequeue()
    }
}
