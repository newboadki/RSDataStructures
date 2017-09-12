//
//  AdjacencyListGraphTests.swift
//  UnitTests
//
//  Created by Borja Arias Drake on 18/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import XCTest

class AdjacencyListGraphTests: XCTestCase {
    
    func testShortestPath() {
        let vertices = [p(0),p(1),p(2),p(3),p(4),p(5)]
        let edges = [(from: p(0), to: p(1), weight: 10),
                     (from: p(0), to: p(2), weight: 6),
                     (from: p(0), to: p(4), weight: 5),
                     (from: p(1), to: p(3), weight: 1),
                     (from: p(3), to: p(4), weight: 20),
                     (from: p(3), to: p(5), weight: 2),
                     (from: p(4), to: p(5), weight: 20)]
        let g = AdjacencyListGraph<IntegerPair>(vertices: vertices, edges:edges, directed: true)
        let pq = BasicBinaryHeap<IntegerPair>(type: .min)
        var minPaths = [0: 0,
                        1: 999,
                        2: 999,
                        3: 999,
                        4: 999,
                        5: 999]
        var parent = [0: -1,
                      1: -1,
                      2: -1,
                      3: -1,
                      4: -1,
                      5: -1]
        var result = [Int]()
        try? pq.enqueue(item: IntegerPair(key: 0, value: 0))
        try? pq.enqueue(item: IntegerPair(key: 999, value: 1))
        try? pq.enqueue(item: IntegerPair(key: 999, value: 2))
        try? pq.enqueue(item: IntegerPair(key: 999, value: 3))
        try? pq.enqueue(item: IntegerPair(key: 999, value: 4))
        try? pq.enqueue(item: IntegerPair(key: 999, value: 5))
        let _ = g.shortestPath(from: p(0),
                                    to: p(5),
                                    minPaths: &minPaths,
                                    parent: &parent,
                                    priorityQueue: pq,
                                    result:&result)
        let expectation = [5,3,1,0]
        XCTAssertTrue(result == expectation)
    }
    
}
