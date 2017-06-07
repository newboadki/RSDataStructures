//
//  KeyValuePair.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 04/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//


/// Conformers of this protocol represent a pair of comparable values
/// This can be useful in many data structures and algorithms where items
/// stored contain a value, but are ordered or retrieved according to a key.
public protocol KeyValuePair : Comparable {
    
    associatedtype K : Comparable
    associatedtype V : Comparable
    
    var key : K {get set}
    var value : V {get set}
    
    mutating func resetToDefaultValues()
    func containsDefaultValues() -> Bool
    init(key: K, value: V)
}



/// Conformance to Equatable and Comparable protocols
extension KeyValuePair {
    
    // MARK: - Equatable protocol
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.key == rhs.key
    }
    
    
    
    // MARK: - Comparable protocol
    
    public static func <(lhs: Self, rhs: Self) -> Bool {
        return lhs.key < rhs.key
    }
    
    public static func <=(lhs: Self, rhs: Self) -> Bool {
        return lhs.key <= rhs.key
    }
    
    public static func >=(lhs: Self, rhs: Self) -> Bool {
        return lhs.key >= rhs.key
    }
    
    public static func >(lhs: Self, rhs: Self) -> Bool {
        return lhs.key > rhs.key
    }
}



/// Concrete impletation of a KeyValuePair where  both the key and the value
/// are Integers.
struct IntegerPair : KeyValuePair {
    
    // MARK - KeyValuePair protocol
    //typealias K = Int (Implicit, the compiler can figure out that if this class conforms to the protocol, then the associated types are Int and Int in this case)
    //typealias V = Int (Implicit)
    
    var key : Int
    var value : Int
    
    mutating func resetToDefaultValues() {
        self.key = -1
        self.value = -1
    }
    
    func containsDefaultValues() -> Bool {
        return self.key == -1 && self.value == -1
    }
}




// An alternative design would have been to use a genric type
struct GenericKeyValuePair<K:Comparable, V:Comparable>  {
    var key : K
    var value : V
}

// If we wanted this to force key and value to have the same type then:
struct GenericKeyValuePairWithSameType<T:Comparable>  {
    var key : T
    var value : T
}


