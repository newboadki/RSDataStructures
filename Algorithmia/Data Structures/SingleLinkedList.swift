//
//  SingleLinkedList.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 30/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


class SingleLinkedListNode<T: Hashable> {
    
    var value: T
    var next: SingleLinkedListNode<T>?
    
    init(value: T) {
        self.value = value
    }
}

struct SingleLinkedList <T: Hashable>
{
    var head: SingleLinkedListNode<T>?
    var tail: SingleLinkedListNode<T>?
    private(set) var count: UInt = 0
    
    init(head: SingleLinkedListNode<T>)
    {
        self.head = head
        self.tail = findTail(in: head)
        self.count = 1
    }

    init()
    {
        self.head = nil
        self.tail = nil
        self.count = 0
    }

    
    mutating func append(node: SingleLinkedListNode<T>)
    {
        if let tailNode = self.tail
        {
            tailNode.next = node
            self.tail = findTail(in: node)
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
    
    
    mutating func deleteNode(withValue v: T) {
        
        guard self.head != nil else {
            return
        }
        
        var previous: SingleLinkedListNode<T>? = nil
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
    mutating func deleteDuplicates()
    {
        var visited = Set<T>()
        var current = self.head
        var previous: SingleLinkedListNode<T>? = nil
        
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
    mutating func deleteDuplicatesInPlace()
    {
        var current = self.head
        
        
        while (current != nil)
        {
            var previous: SingleLinkedListNode<T>? = current
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
    private func find(kthToLast: UInt, startingAt node: SingleLinkedListNode<T>?, count: UInt) -> SingleLinkedListNode<T>? {
        
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
    
    func find(kthToLast: UInt) -> SingleLinkedListNode<T>? {
        return self.find(kthToLast: kthToLast, startingAt: self.head, count: self.count)
    }

}

func findTail<T>(in node: SingleLinkedListNode<T>) -> SingleLinkedListNode<T>
{
    // Assign the tail
    // Note that the passed node can already be linking to other nodes,
    // so the tail needs to be calculated.
    var current: SingleLinkedListNode<T>? = node.next
    while (current?.next != nil) {
        current = current?.next
    }
    
    if current != nil {
        return current!
    } else {
        return node
    }
}


// Assuming they both have the same number of digits (zeros on the shortest's right have been added).
func sumLeftToRight(l1: SingleLinkedList<Int>, l2: SingleLinkedList<Int>) -> SingleLinkedList<Int>
{
    var carriage = false
    var n1 = l1.head
    var n2 = l2.head
    var sumList = SingleLinkedList<Int>()
    
    while(n1 != nil) {
        var sum = (n1?.value)! + (n2?.value)!
        if (carriage == true) {
            sum += 1
        }
        
        if (sum >= 10) {
            carriage = true
            sum = sum - 10
        } else {
            carriage = false
        }
        
        sumList.append(node: SingleLinkedListNode(value: sum))
        
        n1 = n1?.next
        n2 = n2?.next
    }
    
    return sumList
}


struct PartialSum {
    var node : SingleLinkedListNode<Int>?
    var carriage : Int
    
}

func sumRightToLeft(l1: SingleLinkedList<Int>, l2: SingleLinkedList<Int>) -> SingleLinkedList<Int> {
    
    // TODO. Pad with zeros
    
    let result = sumHelper(n1: l1.head, n2: l2.head)
    
    if result.carriage == 1 {
        let newNode = SingleLinkedListNode(value: 1)
        newNode.next = result.node
        return SingleLinkedList<Int>(head: newNode)
    } else {
        return SingleLinkedList<Int>(head: result.node!)
    }
}

func sumHelper(n1: SingleLinkedListNode<Int>?, n2: SingleLinkedListNode<Int>?) -> PartialSum {
    
    // BASE CASE
    if (n1==nil && n2==nil) {
        return PartialSum(node: nil, carriage: 0)
    }

    
    var result = sumHelper(n1: n1?.next, n2: n2?.next)
    var sum = n1!.value + n2!.value + result.carriage
    
    if (sum >= 10) {
        result.carriage = 1
        sum = sum - 10
    } else {
        result.carriage = 0
    }
    
    let newNode = SingleLinkedListNode(value: sum)
    newNode.next = result.node
    result.node = newNode
    
    return result
}
