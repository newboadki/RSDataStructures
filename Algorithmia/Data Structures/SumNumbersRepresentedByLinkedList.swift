//
//  SumNumbersRepresentedByLinkedList.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 04/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

struct PartialSum {
    var node : SinglyLinkedListNode<Int>?
    var carriage : Int
    
}

// Assuming they both have the same number of digits (zeros on the shortest's right have been added).
func sumLeftToRight(l1: SinglyLinkedList<Int>, l2: SinglyLinkedList<Int>) -> SinglyLinkedList<Int>
{
    var carriage = false
    var n1 = l1.head
    var n2 = l2.head
    var sumList = SinglyLinkedList<Int>()
    
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
        
        sumList.append(node: SinglyLinkedListNode(value: sum))
        
        n1 = n1?.next
        n2 = n2?.next
    }
    
    return sumList
}


func sumRightToLeft(l1: SinglyLinkedList<Int>, l2: SinglyLinkedList<Int>) -> SinglyLinkedList<Int> {
    
    // TODO. Pad with zeros
    
    let result = sumHelper(n1: l1.head, n2: l2.head)
    
    if result.carriage == 1 {
        let newNode = SinglyLinkedListNode(value: 1)
        newNode.next = result.node
        return SinglyLinkedList<Int>(head: newNode)
    } else {
        return SinglyLinkedList<Int>(head: result.node!)
    }
}

func sumHelper(n1: SinglyLinkedListNode<Int>?, n2: SinglyLinkedListNode<Int>?) -> PartialSum {
    
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
    
    let newNode = SinglyLinkedListNode(value: sum)
    newNode.next = result.node
    result.node = newNode
    
    return result
}
