//
//  SinglyLinkedList.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 30/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


// MARK: - NODE -
public class SinglyLinkedListNode<T> {
    
    var value: T
    var next: SinglyLinkedListNode<T>?
    
    init(value: T) {
        self.value = value
    }
}


// MARK: - LINKED LIST -

/// Data structure to hold a collection of nodes.
/// Each nodes contains a reference to the next node.
/// The last node does not reference any other node.
public struct SinglyLinkedList<T>
{
    // MARK: - PROPERTIES
    
    /// First node
    fileprivate(set) var head: SinglyLinkedListNode<T>?
    
    /// Last node
    fileprivate(set) var tail: SinglyLinkedListNode<T>?
    
    
    // MARK: - INITIALIZERS
    
    /// Creates a list with the given node
    ///
    /// - Parameter head: First node
    public init(head: SinglyLinkedListNode<T>)
    {
        self.head = head
        let (tail, _) = findTail(in: head)
        self.tail = tail
    }

    /// Creates an empty list
    public init()
    {
        self.head = nil
        self.tail = nil
    }

    
    /// Appends a new node to the list.
    /// - Discussion: If the node to be inserted contains a loop, the node is appended but tail is set to nil.
    /// - Parameter node: node to be appended. (It can be a list, even contain loops).
    public mutating func append(node: SinglyLinkedListNode<T>)
    {
        if let tailNode = self.tail
        {
            tailNode.next = node
            if !self.containsLoop() {
                let (tail, _) = findTail(in: node)
                self.tail = tail
            } else {
                self.tail = nil
            }
        }
        else
        {
            // This also means that there's no head.
            // Otherwise the state would be inconsistent.
            // This will be checked when adding and deleting nodes.
            let (tail, _) = findTail(in: node)
            self.head = node
            self.tail = tail
        }
    }
    
    
    /// This is commented out becuase this solution for finding duplicates uses a set, which would
    /// contrain type T to be hashable, preventing easy types of Linked lists like List<Int> or List<Float>
    /// Takes O(N)
    /// Uses Additional space to keep track of already seen elements
    /*
    public mutating func deleteDuplicates()
    {
        var visited = Set<T>()
        var current = self.head
        var previous: SinglyLinkedListNode<T>? = nil
        
        while (current != nil)
        {
            if (visited.contains((current?.value)!))
            {
                
                if (self.head === current) {
                    self.head = current?.next
                }
                
                if (self.tail === current) {
                    self.tail = previous
                }
                
                // delete current node
                previous?.next = current?.next
                // we don't update the previous
                self.endIndex = SinglyLinkedListIndex<T>(node: nil, tag: (self.endIndex.tag - 1))
            }
            else
            {
                visited.insert((current?.value)!)
                previous = current
            }
            current = current?.next
        }
    }
     */
    
    
    /// Returns the node located at the k-th to last position
    ///
    /// - Parameter kthToLast: 1 <= k <= N
    private func find(kthToLast: UInt, startingAt node: SinglyLinkedListNode<T>?, count: UInt) -> SinglyLinkedListNode<T>?
    {
        guard kthToLast <= count else {
            return nil
        }
        
        guard (node != nil) else {
            return nil
        }
        
        let i = (count - kthToLast)
        
        if (i == 0) {
            return node
        }
        
        return find(kthToLast: kthToLast, startingAt: node?.next, count: (count - 1))
    }
    
    
    /// Returns the kth-to-last element in the list
    ///
    /// - Parameter kthToLast: Reversed ordinal number of the node to fetch.
    public func find(kthToLast: UInt) -> SinglyLinkedListNode<T>?
    {
        return self.find(kthToLast: kthToLast, startingAt: self.head, count: UInt(self.count))
    }


    /// A singly linked list contains a loop if one node references back to a previous node.
    ///
    /// - Returns: Whether the linked list contains a loop
    public func containsLoop() -> Bool
    {
        /// Advances a node at a time
        var current = self.head
        
        /// Advances twice as fast
        var runner = self.head
        
        while (runner != nil) && (runner?.next != nil) {
        
            current = current?.next
            runner = runner?.next?.next
            
            if runner === current {
                return true
            }
        }
        
        return false
    }
}

extension SinglyLinkedList where T: Comparable
{
    /// Deletes node containing a given value
    ///
    /// - Parameter v: value of the node to be deleted.
    mutating func deleteNode(withValue v: T) {
        
        guard self.head != nil else {
            return
        }
        
        var previous: SinglyLinkedListNode<T>? = nil
        var current = self.head
        
        while (current != nil) && (current?.value != v) {
            previous = current
            current = current?.next
        }
        
        if let foundNode = current {
            
            if (self.head === foundNode) {
                self.head = foundNode.next
            }
            
            if (self.tail === foundNode) {
                self.tail = previous
            }
            
            previous?.next = foundNode.next
            foundNode.next = nil
        }
    }
    
    
    /// Deletes duplicates without using additional structures like a set to keep track the visited nodes.
    /// - Complexity: O(N^2)
    public mutating func deleteDuplicatesInPlace()
    {
        var current = self.head
        
        while (current != nil)
        {
            var previous: SinglyLinkedListNode<T>? = current
            var next = current?.next
            
            while (next != nil)
            {
                if (current?.value == next?.value) {
                    
                    if (self.head === next) {
                        self.head = next?.next
                    }
                    
                    if (self.tail === next) {
                        self.tail = previous
                    }
                    
                    // Delete next
                    previous?.next = next?.next
                }
                previous = next
                next = next?.next
            }
            current = current?.next
        }
    }
}


public struct SinglyLinkedListForwardIterator<T> : IteratorProtocol {

    public typealias Element = SinglyLinkedListNode<T>
    
    private(set) var head: SinglyLinkedListNode<T>?
    
    mutating public func next() -> SinglyLinkedListNode<T>?
    {
        let result = self.head
        self.head = self.head?.next
        return result
    }
}




// MARK: - SEQUENCE -

extension SinglyLinkedList : Sequence
{
    public func makeIterator() -> SinglyLinkedListForwardIterator<T>
    {
        return SinglyLinkedListForwardIterator(head: self.head)
    }
}


// MARK: - COLLECTION -

extension SinglyLinkedList : Collection {
    
    public typealias Index = SinglyLinkedListIndex<T>
    
    public var startIndex: Index {
        get {
            return SinglyLinkedListIndex<T>(node: self.head, tag: 0)
        }
    }
    
    public var endIndex: Index {
        get {
            if let h = self.head {
                let (_, numberOfElements) = findTail(in: h)
                return SinglyLinkedListIndex<T>(node: h, tag: numberOfElements)
            } else {
                return SinglyLinkedListIndex<T>(node: nil, tag: self.startIndex.tag)
            }
        }
    }
    
    public subscript(position: Index) -> SinglyLinkedListNode<T>
    {
        return position.node!
    }
    
    public func index(after idx: Index) -> Index {
        return SinglyLinkedListIndex<T>(node: idx.node?.next, tag: idx.tag+1)
    }
}


// MARK: - QUEUE -

extension SinglyLinkedList : Queue
{
    typealias Item = T
    
    /// Returns the oldest element in the queue.
    ///
    /// - Returns: The oldest element in the queue. It does not dequeue it.
    func getFirst() -> T? {
        return self.head?.value
    }

    /// Adds an element to the queue
    ///
    /// - Parameter item: Item to be added
    /// - Throws: There are cases where the operation might fail. For example if there is not enough space.
    mutating func enqueue(item: T) throws {
        let node = SinglyLinkedListNode<T>(value: item)
        self.append(node: node)
    }
    
    /// Dequeues the oldest element in the queue.
    ///
    /// - Returns: The oldest element in the queue, which gets removed from it.
    mutating func dequeue() -> T?
    {
        let current = self.head
        self.head = current?.next
        if self.head == nil {
            self.tail = nil
        }
        
        return current?.value
    }
}

// MARK: - EXPRESSIBLE-BY-ARRAY-LITERAL -

extension SinglyLinkedList : ExpressibleByArrayLiteral
{
    public typealias Element = T

    public init(arrayLiteral elements: Element...)
    {
        var headSet = false
        var current : SinglyLinkedListNode<T>?
        var numberOfElements = 0
        
        for element in elements {
            
            numberOfElements += 1
            
            if headSet == false {
                self.head = SinglyLinkedListNode<T>(value: element)
                current = self.head
                headSet = true
            } else {
                let newNode = SinglyLinkedListNode<T>(value: element)
                current?.next = newNode
                current = newNode
            }
        }
        self.tail = current
    }
}



// MARK: - FORWARD-INDEX -

public struct SinglyLinkedListIndex<T> : Comparable
{
    fileprivate let node: SinglyLinkedListNode<T>?
    fileprivate let tag: Int
    
    public static func==<T>(lhs: SinglyLinkedListIndex<T>, rhs: SinglyLinkedListIndex<T>) -> Bool {
        return (lhs.tag == rhs.tag)
    }
    
    public static func< <T>(lhs: SinglyLinkedListIndex<T>, rhs: SinglyLinkedListIndex<T>) -> Bool {
        return (lhs.tag < rhs.tag)
    }
}


func findTail<T>(in node: SinglyLinkedListNode<T>) -> (tail: SinglyLinkedListNode<T>, count: Int)
{
    // Assign the tail
    // Note that the passed node can already be linking to other nodes,
    // so the tail needs to be calculated.
    var current: SinglyLinkedListNode<T>? = node
    var count = 1
    
    while (current?.next != nil) {
        current = current?.next
        count += 1
    }
    
    if current != nil {
        return (tail: current!, count: count)
    } else {
        return (tail: node, count: 1)
    }
}
