//
//  SmallDifference.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 28/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

func differentBy0Or1(s1: String, s2: String) -> Bool {
    
    let l1 = s1.count
    let l2 = s2.count
    
    if (abs(l1 - l2) > 1) {
        return false
    }
    
    let shorter = l1 < l2 ? s1 : s2
    let larger = l2 > l1 ? s2 : s1
    var shorterIndex = 0
    var largerIndex = 0
    var foundDiff = false
    
    while (shorterIndex < shorter.count && largerIndex < larger.count) {
        
        if (shorter.unicodeScalarValue(at: shorterIndex) != larger.unicodeScalarValue(at: largerIndex)) {
            if (foundDiff) {
                return false
            }
            
            foundDiff = true
            
            // The character was different, but they could just be shifted if one string is larger than the other one, therefore only move the shorter index if the legths are equal becuase in that case the shift is not possible.
            if (l1 == l2) {
                shorterIndex += 1
            }

        } else {
            shorterIndex += 1
        }
        
        // Always update the longer pointer
        largerIndex += 1
    }
    
    return true
}
