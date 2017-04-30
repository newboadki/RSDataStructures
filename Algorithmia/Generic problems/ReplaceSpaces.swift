//
//  ReplaceSpaces.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 25/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

func replaceSpaces(in string: inout String, trueLength: Int) -> String {
    
    var spaceCount: Int = 0
    
    for i in 0..<trueLength {
        if(string.character(at: i) == " ") {
            spaceCount += 1
        }
    }
    
    let offset = 2 * spaceCount
    var index = trueLength + offset
    
    
    for i in (0..<trueLength).reversed() {
        
        if (string.character(at: i) == " ") {
                        
            string.insert(at: index-1, value: "0")
            string.insert(at: index-2, value: "2")
            string.insert(at: index-3, value: "%")
        
            index = index - 3
        } else {
            string.insert(at: index-1, value: string.character(at: i))
            index = index - 1
        }
    }
    print(string)
    return string
}
