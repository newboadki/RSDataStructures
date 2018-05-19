//
//  Int+Extensions.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 18/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

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

// (*)
/*
 - You can calculate this by propagating the module as much as necessary (rules of modular arithmetic), if assured that negative results can't occur
 t_i = (base.mod(q) * (t_i.mod(q) - (text.unicodeScalarValue(at: i-1).mod(q) * h.mod(q)).mod(q)).mod(q) + text.unicodeScalarValue(at: (i + m - 1)).mod(q)).mod(q)
 
 - Another version with reduced amount of module operations R.Segewick. plus q is done to guarantee the substraction is positive. But if incorporating that into the calculation of the module then not needed here.
 t_i = (t_i + q - (text.unicodeScalarValue(at: i-1) * h) % q)) % q
 t_i = (t_i * base + text.unicodeScalarValue(at: (i + m - 1))) % q
 
 
 */
