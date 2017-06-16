//
//  BasicGraph.swift
//  UnitTests
//
//  Created by Borja Arias Drake on 14/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation

class EdgeNode<VertexKeyInfo: KeyValuePair> {
    
    /// Identifier of the
    var destination: VertexKeyInfo
    
    
    init(destinationVertexKey: VertexKeyInfo) {
        self.destination = destinationVertexKey
    }
}


/// This implementation of a graph uses a linked list to keep adjacency information.
/// Finding the first adjacent node of a given vertex takes O(1)
/// Iterating through its neighbours takes O(N)
///
/// This implementaiton assumes that vertices are identified with Integers, this is to be able
/// to efficiently index them.
struct AdjacencyListGraph<VertexInfo: KeyValuePair> : IntegerIndexableGraph where VertexInfo.K == Int {
    
    // MARK: Graph protocol
    
    typealias Vertex = VertexInfo
    
    
    public var vertices: [VertexInfo]
    
    public var edges: [(VertexInfo, VertexInfo)]
    
    public var directed: Bool
    
    private(set) var maxCountOfVertices = 1000
    
    /// Adjancency info for all vertices
    private var adjacencyList: [SinglyLinkedList<EdgeNode<VertexInfo>>]
    
    
    init(vertices: [VertexInfo], edges: [(VertexInfo, VertexInfo)], directed: Bool) {
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
    
    // MARK: Implementation
    
    private static func adjacencyList(fromVertices:[VertexInfo], andEdges:[(VertexInfo, VertexInfo)]) -> [SinglyLinkedList<EdgeNode<VertexInfo>>] {
        var array = [SinglyLinkedList<EdgeNode<VertexInfo>>](repeating: SinglyLinkedList<EdgeNode<VertexInfo>>(), count: fromVertices.count)
        
        for edge in andEdges {            
            let edgeNode = EdgeNode<VertexInfo>(destinationVertexKey: edge.1)
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

