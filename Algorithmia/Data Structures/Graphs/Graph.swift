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

protocol IntegerIndexableGraph: Graph where Vertex.K == Int {    
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
