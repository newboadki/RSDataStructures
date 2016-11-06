//
//  KeyValuePair.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 04/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//


/// Conformers of this protocol represent a pair of comparable values
/// This can be useful in many data structure and algorithms where items
/// stored contain a value, but are ordered or retrieved according to a key.
protocol KeyValuePair {
    
    associatedtype K : Comparable
    associatedtype V : Comparable
    
    var key : K {get set}
    var value : V {get set}
    
    func printPair()
}

/// Concrete impletation of a KeyValuePair where  both the key and the value
/// are Integers.
struct IntegerPair : KeyValuePair {
    var key : Int
    var value : Int
    
    func printPair() {
        print("KEY: \(self.key)")
    }
}
