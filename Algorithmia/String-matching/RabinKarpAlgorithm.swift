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
    let n = text.characters.count
    let m = pattern.characters.count
    
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
    let m = pattern.characters.count
    var result = true
    
    for i in 0...(m - 1) {
        if text.unicodeScalarValue(at: (start + i)) != pattern.unicodeScalarValue(at: i) {
            result = false
            break
        }
    }
    return result
}

extension Int {
    
    func toThe(nthPower: Int, modulus q: Int) -> Int {
        var power = 1
        for _ in 1...nthPower {
            power = (power * self).mod(q)
        }
        
        return power
    }
    
    func mod(_ b: Int) -> Int {
        return (self % b + b) % b // Guarantees the module is always positive.
        //return (self % b)
    }
}

extension String.UnicodeScalarView {
    
    func unicodeScalar(at index: Int) -> UnicodeScalar {
        let viewIndex = self.index(self.startIndex, offsetBy: index)
        return self[viewIndex]
    }

    func unicodeScalarValue(at index: Int) -> Int {
        return Int(exactly: self.unicodeScalar(at: index).value)!
    }

}

extension String {

    func unicodeScalar(at index: Int) -> UnicodeScalar {
        return self.unicodeScalars.unicodeScalar(at:index)
    }

    func unicodeScalarValue(at index: Int) -> Int {
        return self.unicodeScalars.unicodeScalarValue(at:index)
    }

    func character(at index: Int) -> Character {
        let stringIndex = self.characters.index(self.startIndex, offsetBy: index)
        return self.characters[stringIndex]
    }
}

// (*)
/*
 - You can calculate this by propagating the module as much as necessary (rules of modular arithmetic), if assured that negative results can't occur
 t_i = (base.mod(q) * (t_i.mod(q) - (text.unicodeScalarValue(at: i-1).mod(q) * h.mod(q)).mod(q)).mod(q) + text.unicodeScalarValue(at: (i + m - 1)).mod(q)).mod(q)
 
 - Another version with reduced amount of module operations R.Segewick. plus q is done to guarantee the substraction is positive. But if incorporating that into the calculation of the module then not needed here.
  t_i = (t_i + q - (text.unicodeScalarValue(at: i-1) * h) % q)) % q
  t_i = (t_i * base + text.unicodeScalarValue(at: (i + m - 1))) % q

 
 */
