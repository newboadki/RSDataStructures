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
struct AdjacencyListGraph<VertexInfo: KeyValuePair> : Graph where VertexInfo.K == Int {
    
    // MARK: Graph protocol
    
    typealias Vertex = VertexInfo
    
    
    public var vertices: [VertexInfo]
    
    public var edges: [(VertexInfo, VertexInfo)]
    
    public var directed: Bool
    
    private(set) var maxCountOfVertices = 1000
    
    /// Adjancency info for all vertices
    private var adjacencyList: [SinglyLinkedList<EdgeNode<VertexInfo>>]
    
    
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
}



