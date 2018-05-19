//
//  FindAllPermutations.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 11/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation



/// Find all permutations of pattern in text.
///
/// - Parameters:
///   - pattern: String to be looked for
///   - text: String where to search
/// - Returns: An array of the indexes at which a permutation of the pattern occurs
/// - Complexity: O(n)
func findAllPermutations(of pattern: String, in text: String) -> [Int] {
    
    // Size of the Text
    let n = text.count
    
    // Size of the pattern
    let m = pattern.count
    
    // Array where to store the results
    var occurrences = [Int]()
    
    /// Stores the frequencies of each character in the pattern.
    /// Stores the frequencies of each character in a window of pattern's size length.
    if let characterFrequenciesInPattern = calculateFrequenciesOfCharacters(in: pattern, startIndex: 0, endIndex: (m-1)),
       var characterFrequenciesInWindow = calculateFrequenciesOfCharacters(in: text, startIndex:0, endIndex: (m-1)) {

        if (characterFrequenciesInPattern == characterFrequenciesInWindow) {
            occurrences.append(0)
        }
        
        for i in 1...(n - m) {
            updateCharacterFrequencies(dictionary: &characterFrequenciesInWindow, string: text, startIndex: i, windowLength: m)
            if (characterFrequenciesInPattern == characterFrequenciesInWindow) {
                occurrences.append(i)
            }
        }
    }
    
    return occurrences
}



fileprivate func calculateFrequenciesOfCharacters(in string: String, startIndex: Int, endIndex: Int) -> Dictionary<Character, Int>? {
    
    guard (endIndex >= startIndex) else {
        return nil
    }
    
    guard (endIndex < string.count) else {
        return nil
    }
    
    guard (startIndex < string.count) else {
        return nil
    }
    
    var frequencies = Dictionary<Character, Int>()
    let characters = string
    let startStringIndex = characters.index(string.startIndex, offsetBy: startIndex)
    let endStringIndex = characters.index(string.startIndex, offsetBy: endIndex)
    
    for c in characters[startStringIndex...endStringIndex] {
        updateFrequency(of: c, in: &frequencies, operationType: .increment)
    }
    
    return frequencies
}


fileprivate func updateCharacterFrequencies(dictionary: inout Dictionary<Character, Int>, string: String, startIndex: Int, windowLength: Int) {
    
    let characters = string
    let previousIndex = characters.index(string.startIndex, offsetBy: (startIndex - 1))
    let previousCharacter = string[previousIndex]
    updateFrequency(of: previousCharacter, in: &dictionary, operationType: .decrement)
    
    let nextIndex = characters.index(string.startIndex, offsetBy: (startIndex + windowLength - 1))
    let nextCharacter = string[nextIndex]
    updateFrequency(of: nextCharacter, in: &dictionary, operationType: .increment)
}

fileprivate enum FrequencyOperationType {
    case increment
    case decrement
}

fileprivate func updateFrequency(of key: Character, in dictionary: inout Dictionary<Character, Int>, operationType: FrequencyOperationType) {
    
    if let frequency = dictionary[key] {
        
        switch operationType {
        case .increment:
            dictionary[key] = frequency + 1
        case .decrement:
            let value = frequency - 1
            if (value == 0) {
                dictionary[key] = nil
            } else {
                dictionary[key] = value
            }
        }
    } else {
        dictionary[key] = 1
    }
}
