//
//  Graph.swift
//  UnitTests
//
//  Created by Borja Arias Drake on 14/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


/// A graph G = (V, E)  is a set of vertices V and set of connections between vertices, called edges.
protocol Graph {
    
    associatedtype Vertex: KeyValuePair
    
    /// Array of vertices
    var vertices: [Vertex] {get}
    
    var vertexCount: Int {get}
    
    /// Connetions between the vertices
    var edges: [(Vertex, Vertex)] {get}
    
    var edgeCount: Int {get}
    
    /// In a directed graph, connections between vertices have a direction,
    /// making (a -> b) different from (b -> a)
    var directed: Bool {get}
    
    
    
    
    
    /// Given a vertex v, its adjacent vertices are those such that:
    /// - Have an edge connecting them in undirected graphs.
    /// - Have a outgoing edge from v to the other vertix.
    ///
    /// - Parameter vertex: Origin vertex.
    /// - Returns: An array of edges.
    /// - Complexity: O(N), where N is v's degree.
    func adjacentVertices(of vertex: Vertex.K) -> [Vertex]
}

extension Graph {
    
    var vertexCount: Int {
        get {
            return self.vertices.count
        }
        
    }
    
    var edgeCount: Int {
        get {
            return self.edges.count
        }
        
    }
}


enum VertexExplorationStatus {
    case undiscovered
    case discovered
    case explored
    case processed
}


protocol IntegerIndexableGraph: Graph where Vertex.K == Int {
    
    /// Finds a vertex with the given index as its key
    ///
    /// - Parameter index: index to search for
    /// - Returns: a vertex with the sought index or nil if not found
    /// - Complexity: Default implementation offers O(N), where N is the number of vertex in the graph. Concrete implemetations
    ///   can improve this time complexity given their knowledge of the internals of the data structure.
    func vertex(withIndex index: Int) -> Vertex?
    
    
    /// Returns a stack containing a topological sorting according to the implicit sorting of the vertices
    ///
    /// - Parameter graph: graph to be traversed
    /// - Returns: a stack containing a topological sorting according to the implicit sorting of the vertices
    func iterativeTopologicalSort<G: IntegerIndexableGraph>(graph: G) -> StackBasedOnLinkedList<G.Vertex>?
    
    
    /// Returns a stack containing a topological sorting according to the implicit sorting of the vertices
    ///
    /// - Parameter graph: graph to be traversed
    /// - Returns: a stack containing a topological sorting according to the implicit sorting of the vertices
    func recursiveTopologicalSort<G: IntegerIndexableGraph>(graph: G) -> StackBasedOnLinkedList<G.Vertex>?
}

extension IntegerIndexableGraph {
    
    /// Finds a vertex with the given index as its key
    ///
    /// - Parameter index: index to search for
    /// - Returns: a vertex with the sought index or nil if not found
    /// - Complexity: O(N), where N is the number of vertex in the graph. Concrete implemetations
    ///   can improve this time complexity given their knowledge of the internals of the data structure.
    func vertex(withIndex index: Int) -> Vertex? {
        let findings = self.vertices.filter { (vertex) -> Bool in
            return vertex.key == index
        }
        return findings.first
    }
    
    /// Returns a stack containing a topological sorting according to the implicit sorting of the vertices
    ///
    /// - Parameter graph: graph to be traversed
    /// - Returns: a stack containing a topological sorting according to the implicit sorting of the vertices
    func iterativeTopologicalSort<G: IntegerIndexableGraph>(graph: G) -> StackBasedOnLinkedList<G.Vertex>? {
        
        var status = [VertexExplorationStatus](repeating: .undiscovered, count: graph.vertices.count)
        let stack = StackBasedOnLinkedList<G.Vertex>()
        
        for i in 0..<graph.vertexCount {
            if status[i] == .undiscovered {
                let success = iterativeTopologicalSortSingleNode(graph: graph, initialVertex: graph.vertex(withIndex: i)!, stack: stack, status: &status)
                if !success {
                    return nil
                }
            }
        }
        
        return stack
    }
    
    
    /// A topological sorting of the vetices of a graph
    ///
    /// - Parameters:
    ///   - graph: The graph to traverse
    ///   - initialVertex: The indeces of the vertices must be numbered from 0 to (graph.vertexCount - 1)
    /// - Returns: A boolean indicating the success of the operation. False can mean that it's not a DAG or that loops where found.
    func iterativeTopologicalSortSingleNode<G: IntegerIndexableGraph, S: Stack>(graph: G, initialVertex: G.Vertex, stack: S, status: inout [VertexExplorationStatus]) -> Bool where S.Item == G.Vertex {
        
        guard graph.directed == true else {
            return false
        }
        
        let explorationStack = StackBasedOnLinkedList<G.Vertex>()
        
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
                            // Cycle found. Topological sorting will only work on DAGs.
                            return false
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
                    stack.push(item: current)
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
        return true
    }
    
    
    /// Returns a stack containing a topological sorting according to the implicit sorting of the vertices
    ///
    /// - Parameter graph: graph to be traversed
    /// - Returns: a stack containing a topological sorting according to the implicit sorting of the vertices
    func recursiveTopologicalSort<G: IntegerIndexableGraph>(graph: G) -> StackBasedOnLinkedList<G.Vertex>? {
        
        var status = [VertexExplorationStatus](repeating: .undiscovered, count: graph.vertices.count)
        let stack = StackBasedOnLinkedList<G.Vertex>()
        
        for i in 0..<graph.vertexCount {
            if status[i] == .undiscovered {
                let success = recursiveTopologicalSortSingleNode(graph: graph, initialVertex: graph.vertex(withIndex: i)!, stack: stack, status: &status)
                if !success {
                    return nil
                }
            }
        }
        
        return stack
    }
    
    
    /// A topological sorting of the vetices of a graph
    ///
    /// - Parameters:
    ///   - graph: The graph to traverse
    ///   - initialVertex: The indeces of the vertices must be numbered from 0 to (graph.vertexCount - 1)
    /// - Returns: A topological sorting of the graph. Nil if the graph is not directed or contains cycles.
    func recursiveTopologicalSortSingleNode<G: IntegerIndexableGraph, S: Stack>(graph: G, initialVertex: G.Vertex, stack: S, status: inout [VertexExplorationStatus]) -> Bool where S.Item == G.Vertex {
        
        status[initialVertex.key] = .discovered
        
        
        for adjacent in graph.adjacentVertices(of: initialVertex.key) {
            
            if status[adjacent.key] == .discovered && status[adjacent.key] != .processed {
                // Cycle found. Topological sorting will only work on DAGs.
                return false
            }
            
            if (status[adjacent.key] != .discovered) && status[adjacent.key] != .processed {
                let success = recursiveTopologicalSortSingleNode(graph: graph, initialVertex: adjacent, stack: stack, status: &status)
                if success == false {
                    return false
                }
            }
        }
        
        status[initialVertex.key] = .processed
        stack.push(item: initialVertex)
        return true
    }
    
}

/// TODO: Merge TraversableGraph and TraversableBinaryTree protocols
protocol TraversableGraph : Graph, Sequence {
    
    var iterator : AnyIterator<Vertex>? {get set}
}


/*extension TraversableGraph {
    
    public func makeIterator() -> AnyIterator<Vertex> {
        if let existingIterator = self.iterator {
            return existingIterator
        } else {
            return self.defaultIterator()
        }
    }

    fileprivate func defaultIterator() -> AnyIterator<Vertex> {
        
    }
}*/
