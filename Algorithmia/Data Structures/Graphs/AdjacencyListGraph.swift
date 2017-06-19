//
//  BasicGraph.swift
//  UnitTests
//
//  Created by Borja Arias Drake on 14/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

/// An edge node and a position in the array 'adjacencyList' represent an edge (a -> b)
/// where:
///   - the origin vertex's KEY comes determined by the index in 'adjacencyList'
///   - and the destination vertex's KEY is defined by EdgeNode.destination.KEY
struct EdgeNode<VertexKeyInfo: KeyValuePair, Weight: Comparable> {
    
    /// Identifier of the
    var destination: VertexKeyInfo
    
    /// Cost of traversing to the destination from the current node.
    /// In an adjacency list this comes defined by a position in the array of vertices.
    var weight: Weight
    
    
    /// Designated initializer
    ///
    /// - Parameters:
    ///   - destinationVertexKey: destination vertex.
    ///   - weight: cost associated with traversing this edge.
    init(destinationVertexKey: VertexKeyInfo, weight: Weight) {
        self.destination = destinationVertexKey
        self.weight = weight
    }
}



/// This implementation of a graph uses a linked list to keep adjacency information.
/// Finding the first adjacent node of a given vertex takes O(1)
/// Iterating through its neighbours takes O(N)
///
/// This implementaiton assumes that vertices are identified with Integers, this is to be able
/// to efficiently and conviniently index them.
struct AdjacencyListGraph<VertexInfo: KeyValuePair> : IntegerIndexableGraph where VertexInfo.K == Int, VertexInfo.V == Int {    
    
    typealias Vertex = VertexInfo
    
    
    /// Vertices with which the graph was initialized
    public var vertices: [VertexInfo]
    
    /// Edges with which the graph was initialized
    public var edges: [(from: VertexInfo, to: VertexInfo, weight: Int)]
    
    /// This is a convenience variable, since a directed gaph is really
    /// implemented here if (a->b) exists but (b->a) does not.
    public var directed: Bool
    
    /// TODO: Not in use.
    private(set) var maxCountOfVertices = 1000
    
    /// Adjancency info for all vertices
    private var adjacencyList: [SinglyLinkedList<EdgeNode<VertexInfo, Int>>]
    
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - vertices: Array of vertices.
    ///   - edges: Connections between vertices.
    ///   - directed: wether the edges have a direction of traversal.
    init(vertices: [VertexInfo], edges: [(VertexInfo, VertexInfo, Int)], directed: Bool) {
        self.vertices = vertices.sorted(by: { (p1, p2) -> Bool in
            p1.key < p2.key
        })
        self.edges = edges
        self.directed = true
        self.adjacencyList = AdjacencyListGraph.adjacencyList(fromVertices: vertices, andEdges: edges)
    }
    
    
    /// Given a vertex v, its adjacent vertices are those such that:
    /// - Have an edge connecting them in undirected graphs.
    /// - Have a outgoing edge from v to the other vertix.
    ///
    /// - Parameter vertex: Origin vertex.
    /// - Returns: An array of edges.
    /// - Complexity: O(N), where N is v's degree.
    func adjacentVertices(of vertexIndex: Int) -> [VertexInfo] {
        var vertices = [VertexInfo]()
        let list = self.adjacencyList[vertexIndex]
        
        for adjNode in list {
            vertices.append(adjNode.destination)
        }
        
        return vertices
    }
    
    
    /// Cost associated with traversing an edge between two vertices.
    ///
    /// - Parameters:
    ///   - from: Key of the origin vertex
    ///   - to: Key of the destination vertex
    /// - Returns: the cost of traversing the edge joining from and to vertices.
    public func weight(from: Vertex.K, to: Vertex.K) -> Int? {
        let fromVertexAdjacencyList = self.adjacencyList[from]
        let searchResults = fromVertexAdjacencyList.filter { (edgeNode) -> Bool in
            return edgeNode.destination.key == to
        }
        return searchResults.first?.weight
    }
}



// MARK: Private methods

extension AdjacencyListGraph {
    
    /// Helper method to populate the internal data structures of an adjacency list graph.
    ///
    /// - Parameters:
    ///   - vertices: array of vertices in the graph
    ///   - edges: array of edges in the graph
    /// - Returns: array of linked lists (adjacency list).
    private static func adjacencyList(fromVertices vertices:[VertexInfo], andEdges edges:[(from: VertexInfo, to: VertexInfo, weight: Int)]) -> [SinglyLinkedList<EdgeNode<VertexInfo, Int>>] {
        var array = [SinglyLinkedList<EdgeNode<VertexInfo, Int>>](repeating: SinglyLinkedList<EdgeNode<VertexInfo, Int>>(), count: vertices.count)
        
        for edge in edges {
            let edgeNode = EdgeNode<VertexInfo, Int>(destinationVertexKey: edge.to, weight: edge.weight)
            array[edge.from.key].append(value: edgeNode)
        }
        
        return array
    }
}



//// MARK: IntegerIndexableGraph

extension AdjacencyListGraph {
    
    /// Finds a vertex with the given index as its key
    ///
    /// - Parameter index: index to search for
    /// - Returns: a vertex with the sought index or nil if not found
    /// - Complexity: O(1)
    func vertex(withIndex index: Int) -> Vertex? {
        return self.vertices[index]
    }
}

