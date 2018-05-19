//
//  BoyerMooreAlgorithm.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 16/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


/// The full Boyer-Moore algorithm takes into account precomputed mismatches of the pattern with itself (in a manner similar to the KMP algorithm) and provides a linear-time worst-case guarantee.
struct BoyerMooreAlgorithm {
    
    static func findOccurrences(of pattern: String, in text: String, vocabularyRadix: Int) -> [Int] {
        
        // 1. Calculate skip table
        var right = BoyerMooreAlgorithm.skipTable(of: pattern, in: text, vocabularyRadix: vocabularyRadix)
        let n = text.count
        let m = pattern.count
        
        // 2. Check for easy negatives
        guard (n >= m) else {
            return [Int]()
        }
        
        // 3. Search
        var occurrences = [Int]()
        var i: Int = 0
        while (i <= (n - m)) {
            
            var j = (m - 1)
            while ((j > -1) && (pattern.unicodeScalarValue(at: j) == text.unicodeScalarValue(at: i+j))) {
                j = j - 1
            }
            
            if (j == -1) {
                // Found
                occurrences.append(i)
                i += m
            } else {
                i += max (1, j - right[text.unicodeScalarValue(at: i+j)])
            }
        }
        
        return occurrences
    }
    
    
    /// Bad Character Heuristic
    ///
    /// - Parameters:
    ///   - pattern: The string to search for
    ///   - text: The text to search the pattern in
    ///   - vocabularyRadix: Base, or vocabulary length
    /// - Returns: <#return value description#>
    static func skipTable(of pattern: String, in text: String, vocabularyRadix: Int) -> [Int] {
        var skipTable = Array<Int>(repeating: -1, count: vocabularyRadix)
        let m = pattern.count
        
        for i in 0..<m {
            let index = pattern.unicodeScalarValue(at: i)
            skipTable[index] = i
        }
        
        return skipTable
    }
    
    
    
    
    // Another version, a bit more convoluted by Sedgewick
    static func findOccurrencesSedgewick(of pattern: String, in text: String, vocabularyRadix: Int) -> [Int] {
        
        // 1. Calculate skip table
        var right = BoyerMooreAlgorithm.skipTable(of: pattern, in: text, vocabularyRadix: vocabularyRadix)
        let n = text.count
        let m = pattern.count
        
        // 2. Check for easy negatives
        guard (n >= m) else {
            return [Int]()
        }
        
        // 3. Search
        var occurrences = [Int]()
        var i: Int = 0
        while (i <= (n - m)) {
            var skip = 0
            for j in (0..<m).reversed() {
                if (pattern.unicodeScalarValue(at: j) != text.unicodeScalarValue(at: i+j)) {
                    skip = max(1, j - right[text.unicodeScalarValue(at: i+j)])
                    break
                }
            }
            
            if (skip == 0) {
                // Found
                occurrences.append(i)
                i += m
            } else {
                i += skip
            }
        }
        
        return occurrences
    }
    

}
