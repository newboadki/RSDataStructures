//
//  KeyValuePair.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 04/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//


struct KeyValuePair<K:Comparable, V:Comparable> : Comparable {
    
    var key : K
    var value : V
    
    public static func ==(lhs: KeyValuePair, rhs: KeyValuePair) -> Bool {
        return lhs.key == rhs.key
    }
    
    public static func <(lhs: KeyValuePair, rhs: KeyValuePair) -> Bool {
        return lhs.key < rhs.key
    }
    
    public static func <=(lhs: KeyValuePair, rhs: KeyValuePair) -> Bool {
        return lhs.key <= rhs.key
    }
    
    public static func >=(lhs: KeyValuePair, rhs: KeyValuePair) -> Bool {
        return lhs.key >= rhs.key
    }
    
    public static func >(lhs: KeyValuePair, rhs: KeyValuePair) -> Bool {
        return lhs.key > rhs.key
    }
}


protocol KeyValuePairProtocol {
    
    associatedtype K : Comparable
    associatedtype V : Comparable
    
    var key : K {get set}
    var value : V {get set}
}
