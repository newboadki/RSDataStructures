//
//  GraphTraversals.swift
//  UnitTests
//
//  Created by Borja Arias Drake on 15/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


enum VertexExplorationStatus {
    case undiscovered
    case discovered
    case explored
    case processed
}


/// A topological sorting of the vetices of a graph
///
/// - Parameters:
///   - graph: The graph to traverse
///   - initialVertex: The indeces of the vertices must be numbered from 0 to (graph.vertexCount - 1)
/// - Returns: A topological sorting of the graph. Nil if the graph is not directed or contains cycles.
func iterativeTopologicalSorting<G: IntegerIndexableGraph>(graph: G, initialVertex: G.Vertex) -> StackBasedOnLinkedList<G.Vertex>? {
    
    guard graph.directed == true else {
        return nil
    }
    
    let explorationStack = StackBasedOnLinkedList<G.Vertex>()
    let topologicalylSortedSequence = StackBasedOnLinkedList<G.Vertex>()
    var status = [VertexExplorationStatus](repeating: .undiscovered, count: graph.vertexCount)
    
    status[initialVertex.key] = .discovered
    explorationStack.push(item: initialVertex)
    
    while let current = explorationStack.peek() {
        switch status[current.key] {
            case .discovered:
                // Discovered means that the node has been added to the explorationStack as part of
                // its parent exploring it's children.
                // We need to explore discovered vertices
                for adjacent in graph.adjacentVertices(of: current.key) {
                    
                    if (status[adjacent.key] != .processed) && (status[adjacent.key] != .undiscovered) {
                        print("Cycle found. Topological sorting will only work on DAGs.")
                        return nil
                    }
                    
                    if (status[adjacent.key] != .processed) && (status[adjacent.key] != .explored) {
                        status[adjacent.key] = .discovered
                        explorationStack.push(item: adjacent)
                    }
                }
                status[current.key] = .explored
                break
            
            case .explored:
                // A vertex is explored when all its adjacent nodes have been processed.
                // We find explored vertices the second time we come back after finishing the children.
                status[current.key] = .processed
                _ = explorationStack.pop()
                topologicalylSortedSequence.push(item: current)
                break
            
            case .processed:
                // Because we iterate, we add things to the stack, that might be re-added through
                // a different path if a cycle is found. by the time we find the vertex again,
                // the status should be processed and there's nothing to do other than removing it.
                _ = explorationStack.pop()
                break
            
            default:
                break
        }
        
    }
    return topologicalylSortedSequence
}

/// A topological sorting of the vetices of a graph
///
/// - Parameters:
///   - graph: The graph to traverse
///   - initialVertex: The indeces of the vertices must be numbered from 0 to (graph.vertexCount - 1)
/// - Returns: A topological sorting of the graph. Nil if the graph is not directed or contains cycles.
func recursiveTopologicalSorting<G: IntegerIndexableGraph, S: Stack>(graph: G, initialVertex: G.Vertex, stack: S, status: inout [VertexExplorationStatus]) -> Bool where S.Item == G.Vertex {
    
    status[initialVertex.key] = .discovered


    for adjacent in graph.adjacentVertices(of: initialVertex.key) {

        if status[adjacent.key] == .discovered && status[adjacent.key] != .processed {
            print("Cycle found. Topological sorting will only work on DAGs.")
            return true
        }
        
        if status[adjacent.key] != .discovered {
            let cycleFound = recursiveTopologicalSorting(graph: graph, initialVertex: adjacent, stack: stack, status: &status)
            if cycleFound == true {
                return true
            }
        }
    }

    status[initialVertex.key] = .processed
    stack.push(item: initialVertex)
    return false
}
