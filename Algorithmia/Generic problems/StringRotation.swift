//
//  StringRotation.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 30/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


extension String {
    
    func isRotation(of s2: String) -> Bool {
        
        guard (self.count == s2.count) else {
            return false
        }
        
        for i in 0..<self.count {
            if (self.unicodeScalarValue(at: i) == s2.unicodeScalarValue(at: s2.count-1)) {
                let offset = (self.count - 1 - i)
                var k = i-1
                
                while (k >= 0) && (self.unicodeScalarValue(at: k) == s2.unicodeScalarValue(at: k+offset)) {
                    k -= 1
                }
                
                if (k == 0 || k == -1)  {
                    let stringIndex = self.index(self.startIndex, offsetBy: i+1)
                    return s2.contains(self[stringIndex...])
                } else {
                    break
                }
            }
        }
        
        return false
    }
    
}
