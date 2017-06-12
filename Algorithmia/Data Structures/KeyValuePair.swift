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
    
    // Identifier used in many algorithms to search by, order by, etc
    var key : K {get set}
    
    // A data container
    var value : V {get set}
    
    
    /// Initializer
    ///
    /// - Parameters:
    ///   - key: Identifier used in many algorithms to search by, order by, etc.
    ///   - value: A data container.
    init(key: K, value: V)
    
    
    /// Creates a copy
    ///
    /// - Abstract: Conformers of this class can be either value or reference types.
    ///   Some algorithms might need to guarantee that a conformer instance gets copied.
    ///   This will perform an innecessary in the case of value types.
    ///   TODO: is there a better way?
    /// - Returns: A new instance with the old one's values copied.
    func copy() -> Self
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
    var key : Int
    var value : Int
    
    func copy() -> IntegerPair {
        return IntegerPair(key: self.key, value: self.value)
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


