//
//  String+Extensions.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 18/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

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
    
    mutating func insert(at index: Int, value: Character) {
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        self.insert(value, at: stringIndex)
    }

}
