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
    
    associatedtype K : Comparable, Hashable
    associatedtype V : Comparable, Hashable
    
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
public extension KeyValuePair {
    
    // MARK: - Equatable protocol
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return (lhs.key == rhs.key) && (lhs.value == rhs.value)
    }
    
    
    
    // MARK: - Comparable protocol
    
    static func <(lhs: Self, rhs: Self) -> Bool {
        return lhs.key < rhs.key
    }
    
    static func <=(lhs: Self, rhs: Self) -> Bool {
        return lhs.key <= rhs.key
    }
    
    static func >=(lhs: Self, rhs: Self) -> Bool {
        return lhs.key >= rhs.key
    }
    
    static func >(lhs: Self, rhs: Self) -> Bool {
        return lhs.key > rhs.key
    }
}
