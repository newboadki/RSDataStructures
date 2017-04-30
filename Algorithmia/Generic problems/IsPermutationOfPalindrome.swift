//
//  IsPermutationOfPalindrome.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 26/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

/// A permutation of a palindrome has at most 1 character with an odd count. 
/// If the length is even => 0 characters have odd count
/// If the length is odd => 1 character has odd count
func isPermutationOfPalindrome(str: String) -> Bool {
    
    // 
    var h = [Character : Int]()
    
    // Counts the number of times
    var oddCount: Int = 0
    
    for c in str.characters {
        
        
        if let charCount = h[c] {
            let newFreq = charCount + 1
            h[c] = newFreq
            if((newFreq % 2) == 1) {
                oddCount = oddCount + 1
            } else {
                oddCount = oddCount - 1
            }
        } else {
            h[c] = 1
            oddCount = oddCount + 1
        }
    }
    
    return oddCount <= 1
}





func isPermutationOfPalindrome2(str: String) -> Bool {

    // A bit in a position i starting from the right means that the character with scalar value 'i' has ocurred an event amount of times
    var evenFrequenciesVector: Int = 0
    
    for i in 0..<str.characters.count {
        let value = str.unicodeScalarValue(at: i) - "a".unicodeScalarValue(at: 0) // Simplification to reduce the size the int, so that we dont need more than 1 int
        let mask = (1 << value)
        if ((evenFrequenciesVector & mask) == 0 ) {
            // Even count
            evenFrequenciesVector |= mask // Set it to one
        } else {
            // odd count
            evenFrequenciesVector &= ~mask // Set it to 1 **Remember**
        }
    }
    
    return ((evenFrequenciesVector == 0) || (evenFrequenciesVector & (evenFrequenciesVector - 1))==0 )
}
