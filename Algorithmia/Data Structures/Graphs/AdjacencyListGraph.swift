//
//  BasicGraph.swift
//  UnitTests
//
//  Created by Borja Arias Drake on 14/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation


struct EdgeNode<VertexKeyInfo: KeyValuePair, Weight: Comparable> {
    
    /// Identifier of the
    var destination: VertexKeyInfo
    
    /// Cost of traversing to the destination from the current node.
    /// In an adjacency list this comes defined by a position in the array of vertices.
    var weight: Weight
    
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
/// to efficiently index them.
struct AdjacencyListGraph<VertexInfo: KeyValuePair, W: Comparable> : IntegerIndexableGraph where VertexInfo.K == Int {
    
    typealias Vertex = VertexInfo
    typealias Weight = W
    
    
    public var vertices: [VertexInfo]
    
    public var edges: [(from: VertexInfo, to: VertexInfo, weight: W)]
    
    public var directed: Bool
    
    private(set) var maxCountOfVertices = 1000
    
    /// Adjancency info for all vertices
    private var adjacencyList: [SinglyLinkedList<EdgeNode<VertexInfo, W>>]
    
    
    init(vertices: [VertexInfo], edges: [(VertexInfo, VertexInfo, W)], directed: Bool) {
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
    func adjacentVertices(of vertex: Int) -> [VertexInfo] {        
        var vertices = [VertexInfo]()
        let list = self.adjacencyList[vertex]
        for adjNode in list {
            vertices.append(adjNode.destination)
        }
        
        return vertices
    }
    
    
    private static func adjacencyList(fromVertices:[VertexInfo], andEdges:[(from: VertexInfo, to: VertexInfo, weight: W)]) -> [SinglyLinkedList<EdgeNode<VertexInfo, W>>] {
        var array = [SinglyLinkedList<EdgeNode<VertexInfo, W>>](repeating: SinglyLinkedList<EdgeNode<VertexInfo, W>>(), count: fromVertices.count)
        
        for edge in andEdges {            
            let edgeNode = EdgeNode<VertexInfo, W>(destinationVertexKey: edge.to, weight: edge.weight)
            array[edge.0.key].append(value: edgeNode)
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

