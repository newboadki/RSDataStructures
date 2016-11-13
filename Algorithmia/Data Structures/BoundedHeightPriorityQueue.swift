//
//  BoundedHeightPriorityQueue.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 07/11/2016.
//  Copyright © 2016 Borja Arias Drake. All rights reserved.
//

import UIKit

//struct BoundedHeightPriorityQueue<Element: KeyValuePair> : PriorityQueue {
//
//    /// Item is defined in the PriorityQueue protocol.
//    typealias Item = Element
//    
//    /// Valid Indexes go from
//    private (set) var maximumKey : UInt = 10000
//    
//    private var topIndex : UInt = 0
//    
//    var array : Array<Array<Element>?>
//    
//    
//    
//    // MARK : PriorityQueue Protocol
//    
//    var type : PriorityQueueType
//    
//    
//    init(type: PriorityQueueType) {
//        self.init(type : type, maximumKey: 1000)
//    }
//    
//    mutating func add(item: Item) throws {
//        
//        guard item.key is UInt else {
//            throw PriorityQueueError.invalidOperationForType
//        }
//        
//        let key = item.key as! UInt
//        
//        guard (key >= 0 && key<=self.maximumKey) else {
//            throw PriorityQueueError.invalidOperationForType
//        }
//        
//        if var arrayForKey = self.array[Int(key)] {
//            // append it to the existing array
//            arrayForKey.append(item)
//        } else {
//            // need to create an array of items for that key
//            self.array[Int(key)] = [item]
//        }
//    }
//    
//    func getTop() -> Item? {
//        
//    }
//    
//    mutating func extractTop() -> Item? {
//        
//    }
//
//    
//    // MARK : Public API
//    
//    init(type: PriorityQueueType, maximumKey: UInt) {
//        self.type = type
//        self.maximumKey = maximumKey
//        self.array = Array<Array<Element>?>(repeating: nil, count: Int(maximumKey + 1))
//    }
//
//}
