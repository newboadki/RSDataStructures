//
//  TreeTraversal.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 15/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


protocol NodeProcessor {
    associatedtype T: Comparable
    mutating func process(element: T)
}

func traverseInOrder<Element: KeyValuePair, P: NodeProcessor>(root: BinarySearchTree<Element>, processor: inout P) where Element.K == P.T
{
    let stack = StackBasedOnLinkedList<BinarySearchTree<Element>>()
    var current: BinarySearchTree<Element>? = root
    
    repeat {
        
        // Find the minimum
        while(current != nil) {
            stack.push(item: current!)
            current = current?.leftChild
        }
        
        if(!stack.isEmpty) {
            let top = stack.pop()
            processor.process(element: top!.node.key)
            current = top?.rightChild
        }
        
    } while((!stack.isEmpty) || (current != nil))
}

func traverseInPostOrder<Element: KeyValuePair, P: NodeProcessor>(root: BinarySearchTree<Element>, processor: inout P) where Element.K == P.T
{
    let stack = StackBasedOnLinkedList<BinarySearchTree<Element>>()
    var current: BinarySearchTree<Element>? = root
    var previous: BinarySearchTree<Element>? = nil
    
    repeat {
        
        while(current != nil)
        {
            stack.push(item: current!)
            current = current?.leftChild
        }
        
        while(current == nil && !stack.isEmpty)
        {
            current = stack.peek()
            
            if((current?.rightChild == nil) || (current?.rightChild === previous))
            {
                processor.process(element: current!.node.key)
                _ = stack.pop()
                previous = current
                current = nil
            }
            else
            {
                current = current?.rightChild
            }
        }
    } while(!stack.isEmpty)
}
