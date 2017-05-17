//
//  TreeInOrderIterator.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 15/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


struct TreeInOrderIterator<Item:KeyValuePair> : IteratorProtocol {
    
    typealias Element = BinarySearchTree<Item>
    
    let stack: StackBasedOnLinkedList<BinarySearchTree<Item>>
    var current: BinarySearchTree<Item>?
    
    init(tree: BinarySearchTree<Item>) {
        self.stack = StackBasedOnLinkedList<BinarySearchTree<Item>>()
        self.current = tree
    }
    
    mutating func next() -> BinarySearchTree<Item>? {
        
        repeat {
            // Find the minimum
            while(current != nil) {
                self.stack.push(item: current!)
                self.current = current?.leftChild
            }
            
            if(!stack.isEmpty) {
                let top = stack.pop()
                self.current = top?.rightChild
                return top
            }
            
        } while((!stack.isEmpty) || (current != nil))
        
        return nil
    }
}
