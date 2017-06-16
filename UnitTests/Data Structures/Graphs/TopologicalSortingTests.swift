//
//  TopologiaclSortingTests.swift
//  UnitTests
//
//  Created by Borja Arias Drake on 15/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class IterativeTopologiacalSortingTests: XCTestCase {
    
    func testValidTopologicalSorting() {
        let vertices = [p(0),p(1),p(2),p(3),p(4),p(5)]
        let edges = [(p(0),p(1)),
                     (p(0),p(2)),
                     (p(1),p(3)),
                     (p(3),p(4)),
                     (p(3),p(5))]
        
        let expectation = [0,1,3,4,5,2]
        let g = AdjacencyListGraph<IntegerPair>(vertices: vertices, edges:edges, directed: true)
        let result = iterativeTopologicalSorting(graph: g, initialVertex: p(0))
        var resultKeys = [Int]()
        while let item = result?.pop() {
            resultKeys.append(item.key)
        }
        XCTAssertTrue(resultKeys == expectation)
    }
    
    func testTopologicalSortingWithCycle() {
        let vertices = [p(0),p(1),p(2),p(3),p(4),p(5)]
        let edges = [(p(0),p(1)),
                     (p(0),p(2)),
                     (p(1),p(3)),
                     (p(3),p(4)),
                     (p(3),p(5)),
                     (p(3),p(0))]
        
        let g = AdjacencyListGraph<IntegerPair>(vertices: vertices, edges:edges, directed: true)
        let result = iterativeTopologicalSorting(graph: g, initialVertex: p(0))
        XCTAssertNil(result)
    }
    
}

class RecursiveTopologiacalSortingTests: XCTestCase {
    
    func testValidTopologicalSorting() {
        let vertices = [p(0),p(1),p(2),p(3),p(4),p(5)]
        let edges = [(p(0),p(1)),
                     (p(0),p(2)),
                     (p(1),p(3)),
                     (p(3),p(4)),
                     (p(3),p(5))]
        
        let expectation = [0,2,1,3,5,4]
        let g = AdjacencyListGraph<IntegerPair>(vertices: vertices, edges:edges, directed: true)
        let stack = StackBasedOnLinkedList<IntegerPair>()
        var status = [VertexExplorationStatus](repeating: .undiscovered, count: vertices.count)
        let cycleFound = recursiveTopologicalSorting(graph: g, initialVertex: p(0), stack: stack, status: &status)
        var resultKeys = [Int]()
        while let item = stack.pop() {
            resultKeys.append(item.key)
        }
        XCTAssertFalse(cycleFound)
        XCTAssertTrue(resultKeys == expectation)
    }
    
    func testTopologicalSortingWithCycle() {
        let vertices = [p(0),p(1),p(2),p(3),p(4),p(5)]
        let edges = [(p(0),p(1)),
                     (p(0),p(2)),
                     (p(1),p(3)),
                     (p(3),p(4)),
                     (p(3),p(5)),
                     (p(3),p(0))]
        
        let g = AdjacencyListGraph<IntegerPair>(vertices: vertices, edges:edges, directed: true)
     let stack = StackBasedOnLinkedList<IntegerPair>()
        var status = [VertexExplorationStatus](repeating: .undiscovered, count: vertices.count)
        let cycleFound = recursiveTopologicalSorting(graph: g, initialVertex: p(0), stack: stack, status: &status)
        XCTAssertTrue(cycleFound)
    }
    
}

