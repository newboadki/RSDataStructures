//
//  RabinKarpAlgorithm.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 14/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

func findOccurrences(of pattern: String, in text: String, base: Int, primeNumber q: Int) -> [Int] {
    
    var occurrences = [Int]()
    let n = text.count
    let m = pattern.count
    
    guard (m <= n) else {
        return [Int]()
    }
    
    // PREPROCESSING
    // - calculate p
    // - calculate t_0 = T[s+0, s+1, s+2, ..., s+m]
    let h = base.toThe(nthPower: (m - 1), modulus: q)
    var t_0: Int = 0
    var p: Int = 0
    for i in 0...(m - 1) {
        t_0 = ((base * t_0) + text.unicodeScalarValue(at: i)).mod(q)
        p = ((base * p) + pattern.unicodeScalarValue(at: i)).mod(q)
    }
    
    // Is t_0 a match?
    if t_0 == p && check(pattern: pattern, text: text, start: 0) {
        occurrences.append(0)
    }
    
    // SEARCH
    var t_i: Int = t_0
    if (n-m == 0) {return occurrences}
    
    for i in 1...(n - m) {
        // (*)
        t_i = (t_i - (text.unicodeScalarValue(at: i-1) * h).mod(q)).mod(q)
        t_i = (t_i * base + text.unicodeScalarValue(at: (i + m - 1))).mod(q)
        
        if t_i == p && check(pattern: pattern, text: text, start: i) {
            occurrences.append(i)
        }
    }
    
    return occurrences
}

func check(pattern: String, text: String, start: Int) -> Bool {
    let m = pattern.count
    var result = true
    
    for i in 0...(m - 1) {
        if text.unicodeScalarValue(at: (start + i)) != pattern.unicodeScalarValue(at: i) {
            result = false
            break
        }
    }
    return result
}


