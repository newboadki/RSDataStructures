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
    associatedtype Weight: Comparable /* Operator '+' should be defined for type Weight */
    
    
    /// Array of vertices
    var vertices: [Vertex] {get}
    
    /// Number of vertices in the graph
    var vertexCount: Int {get}
    
    /// Connetions between the vertices
    var edges: [(from: Vertex, to: Vertex, weight: Weight)] {get}
    
    /// Number of edges in the graph
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
    
    
    /// Finds a vertex with the given index as its key
    ///
    /// - Parameter index: index to search for
    /// - Returns: a vertex with the sought index or nil if not found
    /// - Complexity: Default implementation offers O(N), where N is the number of vertex in the graph. Concrete implemetations
    ///   can improve this time complexity given their knowledge of the internals of the data structure.
    func vertex(withIndex index: Vertex.K) -> Vertex?
    
    
    /// Cost associated with traversing the edge joining vertices identified by keys from and to.
    ///
    /// - Parameters:
    ///   - from: origin vertex
    ///   - to: destination vertex
    /// - Returns: The cost of the traversal.
    func weight(from: Vertex.K, to: Vertex.K) -> Weight?
}



// MARK: Basic default implementations

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
    
    /// Finds a vertex with the given index as its key
    ///
    /// - Parameter index: index to search for
    /// - Returns: a vertex with the sought index or nil if not found
    /// - Complexity: O(N), where N is the number of vertex in the graph. Concrete implemetations
    ///   can improve this time complexity given their knowledge of the internals of the data structure.
    func vertex(withIndex index: Vertex.K) -> Vertex? {
        let findings = self.vertices.filter { (vertex) -> Bool in
            return vertex.key == index
        }
        return findings.first
    }
}


enum VertexExplorationStatus {
    case undiscovered
    case discovered
    case explored
    case processed
}


/// This is a convenience graph that guarantees vertex' keys will be integers.
/// This restriction allows easy and efficient implementations. There are other ways to achieve
/// it without constraining the type of the key. However we define it for simplicity.
protocol IntegerIndexableGraph: Graph where Vertex.K == Int, Vertex.V == Int, Weight == Int {
    
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
    
    
    /// Default implementation follows Dijkstra algorithm
    func shortestPath(from: Vertex, to: Vertex,
                      minPaths:inout Dictionary<Vertex.K, Int>,
                      parent: inout Dictionary<Vertex.K, Vertex.K>,
                      priorityQueue: BasicBinaryHeap<Vertex>,
                      result: inout [Vertex.K])
}



// MARK: Topological sorting algorithms

extension IntegerIndexableGraph {
    
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



// MARK: Shortest path algorithms

extension IntegerIndexableGraph {
    
    /// Default implementation follows Dijkstra algorithm.
    ///
    /// - Parameters:
    ///   - from: Origin of the path
    ///   - to: Destination of the path
    ///   - minPaths: Data structure to keep the minimum distances found.
    ///   - parent: Data structure to keep track of the predecesors of any given node in the min path.
    ///   - priorityQueue: data structure to efficiently retrieve and update the vertex with the current minimum distance.
    ///   - result: data structure to return the keys of teh vertices in the minimum path.
    /// - Important: Conceptually, this belongs to the Graph protocol, it's not necessary for the Keys to be
    ///   integers for a graph to be able to implement Dijkstra's shortest path algorithm. It is here as a
    ///   simplification, because we would need:
    ///   - a) the weight to be KayValuePair.K so that we could update the priority queue with the result of a summing up keys.
    ///   - b) define a '+' operator on the KeyValuePair.K
    ///   The graph assumes that a vertex's KEY is the IDENTIFIER of the vertex (0, 1, 2, 3....vertices.count)
    ///   This algorithm uses a priority queue, and the queue uses KeyValuePairs. However the meaning is:
    ///    - the queue-element's KEY is the PRIORITY (a path's aggregated weight)
    ///    - the queue-element's VALUE is the IDENTIFIER of the vertex
    ///    => graph-element.KEY == queue-element.VALUE (VERTEX IDENTIFIER)
    ///    => graph-element.VALUE == queue-element.KEY (PRIORITY)
    func shortestPath(from: Vertex, to: Vertex,
                      minPaths:inout Dictionary<Vertex.K, Int>,
                      parent: inout Dictionary<Vertex.K, Vertex.K>,
                      priorityQueue: BasicBinaryHeap<Vertex>,
                      result: inout [Vertex.K]) {
        
        // Algorithm
        while let current = priorityQueue.dequeue() {
            for adjacent in self.adjacentVertices(of: current.value) {
                let min = Swift.min(minPaths[adjacent.key]!, (minPaths[current.value]! + self.weight(from:current.value, to: adjacent.key)!))
                if min != minPaths[adjacent.key] {
                    minPaths[adjacent.key] = min
                    priorityQueue.updatePriority(ofValue: adjacent.key, to: min)
                    parent[adjacent.key] = current.value
                }
            }
        }
        
        // Build the minium path
        var current: Vertex.K = to.key
        while current != from.key {
            result.append(current)
            current = parent[current]!
        }
        result.append(from.key)
    }
}
