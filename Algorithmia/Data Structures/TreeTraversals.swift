//
//  TreeTraversal.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 15/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


func inOrderTraversalIterator<Element: KeyValuePair, T: TraversableBinaryTree>(tree: T) -> AnyIterator<Element> where Element == T.Item {
    
    let stack = StackBasedOnLinkedList<T>()
    var current: T? = tree
    
    return AnyIterator {
        repeat {
            // Find the minimum
            while(current != nil) {
                stack.push(item: current!)
                current = current?.leftChild
            }
            
            if(!stack.isEmpty) {
                let top = stack.pop()
                current = top?.rightChild
                return top?.item
            }
            
        } while((!stack.isEmpty) || (current != nil))
        
        return nil
        
    }
}

func postOrderTraversalIterator<Element: KeyValuePair, T: TraversableBinaryTree>(tree: T) -> AnyIterator<Element> where Element == T.Item {
    
    let stack = StackBasedOnLinkedList<T>()
    var previous: T? = nil
    var current: T? = tree
    
    return AnyIterator {
        
        repeat {
            
            while(current != nil) {
                stack.push(item: current!)
                current = current?.leftChild
            }
            
            while(current == nil) && (!stack.isEmpty) {
                
                // Update the current
                current = stack.peek()
                
                // If already visited
                if(current?.rightChild == nil) || (current?.rightChild == previous) {
                    
                    previous = current
                    current = nil
                    return stack.pop()?.item
                    
                } else {
                    current = current?.rightChild
                }
            }
            
        } while(!stack.isEmpty)
        
        return nil
    }
}
