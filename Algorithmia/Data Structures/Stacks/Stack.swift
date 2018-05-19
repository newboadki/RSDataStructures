//
//  Stack.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 07/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

public protocol Stack /*, Sequence */{
    
    associatedtype Item
    
    
    var isEmpty: Bool {get}
    
    func push(item: Item)
    
    func pop() -> Item?
    
    func peek() -> Item?
    
    func count() -> Int
}

public enum StackPeekType {
    case min, max
}

public extension Stack {
    
    var isEmpty: Bool {
        get {
            return (self.count() <= 0)
        }        
    }
}

public protocol MinMaxPeekStack : Stack {
 
    var type: StackPeekType {get}
    
    init(type: StackPeekType)
    
    func minMaxPeek() -> Item?
}
