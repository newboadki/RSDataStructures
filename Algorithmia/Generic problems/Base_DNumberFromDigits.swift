//
//  Base_DNumberFromDigits.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 13/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


func number(from digits:[Int], base: Int) -> Int {
    
    var sum: Int = 0
    
    for digit in digits {
        sum = (base * sum) + digit
    }
    
    return sum
}
