//
//  MatrixRotation.swift
//  Algorithmia
//
//  Created by Borja Arias Drake on 30/04/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

/*
 - I am assuming the matrix is square.
 
 The key observation is that rotating the matrix 90 degrees to the right implicitly defines a relation ship between indexes.
 M(i,j) should move to -> M(n-j-1, i)
 - We can do this brute force and generating another matrix by simply iterating through the original matrix and moving each element to a new position in the new matrix. O(N^2)
 - There's something however that we can do to improve the time, however it will still be O(N^2), and save space by doing it in place.
    The idea behind this, is the fact that once you move one element, it will propagate for another 3 elements. If A goes to B and B goes to C, C to D and finally, D goes to A. That means that we don't need to iterate through the whole matrix. We'll cover half the rows and for each row we'll move N-2*i elements. This is the solution implemented below.
 - There's a recursive solution to this, if we note that on every iteration we are relocating the outer frame of numbers. Therefore, in the next iteration, what we are left is the same problem but on a matrix of size M(N-1 x N-1).
 
 */
func rotateMatrix90DegreesToTheLeft<T>(matrix: inout Array<Array<T>>) throws {

    let n = matrix.count
    
    guard (n > 0) && (matrix[0].count == n) else {
        throw NSError(domain: "Matrix must be square", code: 1, userInfo: nil)
    }
    
    for i in 0..<(n/2) { // implicit floor
        
        for j in i..<(n-i-1) {

            //
            let a = (n - j - 1)
            let b = i
            let OBL = matrix[a][b] // OriginalBottomLeft
            matrix[a][b] = matrix[i][j]
            
            //
            let c = (n - b - 1)
            let d = a
            let OBR = matrix[c][d] // OriginalBottomRight
            matrix[c][d] = OBL
            
            //
            let e = (n - d - 1)
            let f = c
            let OTR = matrix[e][f] // OriginalTopRight
            matrix[e][f] = OBR
            
            //
            matrix[i][j] = OTR
        }
    }
}

func print<T>(matrix: Array<Array<T>>) {
    for i in (0..<matrix.count) {
        for j in (0..<matrix[i].count) {
            print(matrix[i][j])
        }
        print(" ")
    }
}
