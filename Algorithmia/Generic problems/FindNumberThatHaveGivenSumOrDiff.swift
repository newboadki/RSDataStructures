//
//  FindNumberThatHaveGivenSumOrDiff.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 12/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

struct Pair : Hashable {
    
    var a: Int
    var b: Int
    
    var hashValue: Int {
        return a.hashValue ^ b.hashValue
    }
    
    public static func ==(lhs: Pair, rhs: Pair) -> Bool {
        return (lhs.hashValue == rhs.hashValue)
    }

}

/// Numbers that sum up to K. Input is Distinct array.
///
/// - Parameters:
///   - sum: The target sum.
///   - arrayOfDistinctNumbers: List of distinct numbers. There can be negative numbers.
/// - Returns: An array of pairs of numbers that sum up to a given number.
/// - Complexity: O(n)
func numbersThatSum(to sum: Int, from arrayOfDistinctNumbers: [Int]) -> Array<(Int, Int)> {
    
    // Container of results
    var pairsThatSumUpToTarget = Array<(Int, Int)>()
    var numbersInPairs = Dictionary<Int, Int>()
    
    // A Hash or dictionary could also be used, but we would not use the values.
    // This takes O(n)
    let set = Set(arrayOfDistinctNumbers)
    
    for number in arrayOfDistinctNumbers {
        
        let complement = (sum - number) // This covers two numbers actually, depending on whether the number is positive or negative.
        if set.contains(complement) {
            
            // With a set implementation where Pair(a,b) == Pair(b,a) we could avoid using this Dictionary and adding these lines.
            let c = numbersInPairs[number]
            let n = numbersInPairs[complement]
            
            if (c==nil) && (n==nil)  {
                pairsThatSumUpToTarget.append((number, complement))
                numbersInPairs[number] = complement
                numbersInPairs[complement] = number
            }
        }
    }
    
    return pairsThatSumUpToTarget
}
