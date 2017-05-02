//
//  IsLinkedListPalindrome.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 02/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

func isPalindrome<T>(list: SingleLinkedList<T>) -> Bool
{
    guard list.head != nil else {
        return false
    }
    

    let result = isPalindromeRecursive(node: list.head, length: list.count)
    return result.isPalindrome
}



func isPalindromeRecursive<T>(node: SingleLinkedListNode<T>?, length: UInt) -> (node: SingleLinkedListNode<T>?, isPalindrome: Bool)
{
    // BASE CASE
    if (length == 0) {
        // Even number of elements
        return (node: node, isPalindrome: true)
        
    } else if (length == 1) {
        // Odd number of elements
        return (node: node?.next, isPalindrome: true)
    }
    
    // RECURSIVE STEP
    var result = isPalindromeRecursive(node: node?.next, length: length - 2)
    
    if (node?.value != result.node?.value) {
        result.isPalindrome = false
    }
    
    result.node = result.node?.next
    
    return result
}
