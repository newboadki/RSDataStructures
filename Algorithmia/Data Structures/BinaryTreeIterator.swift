//
//  BinaryTreeIterator.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 16/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


struct BinaryTreeIterator<Item:KeyValuePair> : IteratorProtocol {
    
    typealias Element = BinarySearchTree<Item>
    
    let tree: BinarySearchTree<Item>
    var postOrderIterator: TreePostOrderIterator<Item>
    var inOrderIterator: TreeInOrderIterator<Item>
    var type: BinarySearchTraversalTraversalType
    
    init(tree: BinarySearchTree<Item>, type: BinarySearchTraversalTraversalType) {
        self.tree = tree
        self.inOrderIterator = TreeInOrderIterator<Item>(tree: tree)
        self.postOrderIterator = TreePostOrderIterator<Item>(tree: tree)
        self.type = type
    }
    
    mutating func next() -> Element? {
        switch self.type {
            case .inOrder:
                return move(iterator: &self.inOrderIterator)
            case .postOrder:
                return move(iterator: &self.postOrderIterator)
            default:
                return nil
        }
    }
    
    
    func move<I: IteratorProtocol>(iterator:inout I) -> I.Element? {
        return iterator.next()
    }
}
