//
//  AreCharactersUnique.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 23/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

func areCharactersUnique(string: String) -> Bool {

    // We assume that the string uses ASCII encoding (vocabulary has 128 characters)
    guard string.characters.count <= 128  else {
        return false
    }
    
    var bitVector: Int = 0
    
    for i in 0..<string.characters.count {
        
        let value = string.unicodeScalarValue(at: i) - "a".unicodeScalarValue(at: 0)
        let mask = (1 << value)
        
        if ((bitVector & mask) > 0) {
            return false // the value's character was already visited
        }
        
        // Set the bit in bitVector corresponding to value to 1 (visited)
        bitVector |= mask
    }
    
    return true
    
}
