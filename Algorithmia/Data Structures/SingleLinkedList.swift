//
//  SinglyLinkedList.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 30/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


class SinglyLinkedListNode<T: Hashable> {
    
    var value: T
    var next: SinglyLinkedListNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

struct SinglyLinkedList <T: Hashable>
{
    // MARK: - PROPERTIES -
    
    /// First node
    var head: SinglyLinkedListNode<T>?
    
    
    /// Last node
    var tail: SinglyLinkedListNode<T>?
    
    
    /// Number of nodes in the list
    private(set) var count: UInt = 0
    
    
    
    // MARK: - INITIALIZERS -
    
    /// Creates a list with the given node
    ///
    /// - Parameter head: First node
    public init(head: SinglyLinkedListNode<T>)
    {
        self.head = head
        self.tail = findTail(in: head)
        self.count = 1
    }

    
    /// Creates an empty list
    public init()
    {
        self.head = nil
        self.tail = nil
        self.count = 0
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
                self.tail = findTail(in: node)
            } else {
                self.tail = nil
            }
        }
        else
        {
            // This also means that there's no head.
            // Otherwise the state would be inconsistent.
            // This will be checked when adding and deleting nodes.
            self.head = node
            self.tail = node
        }
        
        self.count += 1
    }
    
    
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
            count -= 1
        }
    }
    
    
    /// Takes O(N)
    /// Uses Additional space to keep track of already seen elements
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
                count -= 1
            }
            else
            {
                visited.insert((current?.value)!)
                previous = current
            }
            current = current?.next
        }
    }
    
    /// Deletes duplicates without using additional structures like a set to keep the visited nodes
    /// It takes time O(N^2)
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
                    self.count -= 1
                }
                previous = next
                next = next?.next
            }
            current = current?.next
        }
    }
    
    
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
    
    
    /// Finds the kth-to-last element in the list
    ///
    /// - Parameter kthToLast: Reversed ordinal number of the node to fetch.
    /// - Returns: <#return value description#>
    public func find(kthToLast: UInt) -> SinglyLinkedListNode<T>?
    {
        return self.find(kthToLast: kthToLast, startingAt: self.head, count: self.count)
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

func findTail<T>(in node: SinglyLinkedListNode<T>) -> SinglyLinkedListNode<T>
{
    // Assign the tail
    // Note that the passed node can already be linking to other nodes,
    // so the tail needs to be calculated.
    var current: SinglyLinkedListNode<T>? = node.next
    while (current?.next != nil) {
        current = current?.next
    }
    
    if current != nil {
        return current!
    } else {
        return node
    }
}






