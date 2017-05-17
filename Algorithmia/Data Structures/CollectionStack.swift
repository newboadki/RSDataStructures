//
//  CollectionStack.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 07/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


protocol List : RangeReplaceableCollection {
    
    typealias Item = Self.Iterator.Element
    
    func prepend(element: Item)
}

protocol StackCollection : List {
    
    mutating func push(item: Item)
    
    mutating func pop() -> Item?
    
    func peek() -> Item?

}

extension StackCollection {

    mutating func push(item: Item) {
        print("push")
        self.prepend(element: item)
    }
    
    mutating func pop() -> Item? {
        print("pop")
        return self.first
    }
    
    func peek() -> Item? {
        print("peek")
        return self.first
    }
}


extension Array : StackCollection {
    func prepend(element: Element) {
        
    }

    public var first: Element? {
        get {
            print("!!!")
            return self[0]
        }
        
        
    
    }

}



