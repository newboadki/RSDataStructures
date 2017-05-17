//
//  TreePostOrderIterator.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 16/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


struct TreePostOrderIterator<Item:KeyValuePair> : IteratorProtocol {

    typealias Element = BinarySearchTree<Item>
    
    let stack: StackBasedOnLinkedList<BinarySearchTree<Item>>
    var previous: BinarySearchTree<Item>?
    var current: BinarySearchTree<Item>?
    
    
    init(tree: BinarySearchTree<Item>) {
        
        self.stack = StackBasedOnLinkedList<BinarySearchTree<Item>>()
        self.previous = nil
        self.current = tree
    }
    
    
    mutating func next() -> BinarySearchTree<Item>? {
        
        repeat {
            
            while(self.current != nil) {
                stack.push(item: self.current!)
                self.current = self.current?.leftChild
            }
            
            while(current == nil) && (!self.stack.isEmpty) {
                
                // Update the current
                current = self.stack.peek()
                
                // If already visited
                if(self.current?.rightChild == nil) || (self.current?.rightChild === previous) {
                    
                    self.previous = self.current
                    self.current = nil
                    return self.stack.pop()
                    
                } else {
                    self.current = self.current?.rightChild
                }
            }
            
        } while(!stack.isEmpty)
        
        return nil
    }
}
