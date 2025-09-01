//
//  File.swift
//  
//
//  Created by Borja Arias Drake on 26.07.2021..
//

import Foundation

fileprivate enum EnumBasedList<Element> {
    case end
    indirect case node(Element, next: EnumBasedList<Element>)
    
    fileprivate func prepend(_ x: Element) -> EnumBasedList<Element> {
        return .node(x, next: self)
    }
}

extension EnumBasedList: ExpressibleByArrayLiteral {

    public init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) { partialList, element in
            partialList.prepend(element)
        }
    }
}

extension EnumBasedList: Stack {
    
    typealias Item = Element
    
    mutating func push(item: Element) {
        self = self.prepend(item)
    }
    
    mutating func pop() -> Element? {
        switch self {
            case .end:
                return nil
            case let .node(current, next: rest):
                self = rest
                return current
        }
    }
    
    func peek() -> Element? {
        switch self {
            case .end:
                return nil
            case let .node(current, next: _):
                return current
        }
    }
    
    func count() -> Int {
        switch self {
            case .end:
                return 0
        case let .node(_, next: rest):
                return 1 + rest.count()
        }
    }
}

// MARK: - Sequence conformance

/// EnumBasedList is an unstable sequence
extension EnumBasedList: IteratorProtocol, Sequence {
    
    mutating func next() -> Element? {
        pop()
    }
}

// MARK: - Collection conformance

public struct EnumBasedListIndex<Element>: CustomStringConvertible, Comparable {
    
    fileprivate let node: EnumBasedList<Element>
    fileprivate let tag: Int
    
    public var description: String {
        return "EnumBasedList(\(tag))"
    }
    
    public static func == <T>(lhs: EnumBasedListIndex<T>, rhs: EnumBasedListIndex<T>) -> Bool {
        return lhs.tag == rhs.tag
    }
    
    public static func < <T>(lhs: EnumBasedListIndex<T>, rhs: EnumBasedListIndex<T>) -> Bool {
        return lhs.tag > rhs.tag // startIndex has the highest tag.
    }
}

public struct EnumBasedListCollection<Element>: Collection {
    
    public typealias Index = EnumBasedListIndex<Element>
    public let startIndex: Index
    public let endIndex: Index
    
    public subscript(position: Index) -> Element {
        switch position.node {
            case .end: fatalError("Subscripit out of range")
            case let .node(x, next: _): return x
        }
    }
    
    public func index(after idx: Index) -> Index {
        switch idx.node {
            case .end: fatalError("Subscripit out of range")
            case let .node(_, next: nextNode): return Index(node: nextNode, tag: idx.tag - 1)
        }
    }
    
    public var count: Int {
        return startIndex.tag - endIndex.tag
    }
    
    public static func == <T: Equatable>(lhs: EnumBasedListCollection<T>, rhs: EnumBasedListCollection<T>) -> Bool {
        return lhs.elementsEqual(rhs)
    }
}

extension EnumBasedListCollection: Equatable where Element:Equatable {}

extension EnumBasedListCollection: ExpressibleByArrayLiteral {

    public init(arrayLiteral elements: Element...) {
        self.startIndex = EnumBasedListIndex(node: elements.reversed().reduce(.end) { partialList, element in partialList.prepend(element)},
                                        tag: elements.count)
        self.endIndex = EnumBasedListIndex<Element>(node: .end, tag: 0)
    }
}
