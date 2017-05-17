//
//  TreeIteratorProtocol.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 16/05/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


protocol TreeIteratorProtocol {

    associatedtype T: KeyValuePair
    mutating func next() -> BinarySearchTree<T>?
}
