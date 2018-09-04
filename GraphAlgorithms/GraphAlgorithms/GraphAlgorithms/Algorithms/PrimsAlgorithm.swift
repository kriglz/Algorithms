//
//  PrimsAlgorithm.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 9/4/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

/// Prim's search algorithm for specified vertex array.
class PrimsAlgorithm {
    
    // MARK: - Properties
    
    weak var delegate: PrimsAlgorithmDelegate? = nil
    
    private var size = VertexListSize()
    
    // MARK: - Vertex list item management
    
    /// Searches for shortest path in vertex list based on Prim's search algorithm.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list to be searched.
    ///     - size: Vertex list size in columns and rows.
    func search(in vertexList: [Vertex], size: VertexListSize) -> [Vertex] {
        self.size = size
        let index = Vertex.startIndex(for: vertexList)
        return searchMinimumSpanningTree(for: index, in: vertexList)
    }
    
    /// Searches for minimum spanning tree path in vertex list.
    ///
    /// - Parameters:
    ///     - index: Index of specified initial vertex.
    ///     - vertexList: Vertex list to be searched.
    private func searchMinimumSpanningTree(for index: Int, in vertexList: [Vertex]) -> [Vertex] {
        var queue = Queue<Vertex>()

        // Set source vertex distance to 0.
        vertexList[index].distance = 0
        vertexList[index].stateColor = .gray
        
        queue.push(vertexList[index])
        
        // Finds vertex in ever-shrinking set, whose distance is smallest.
        // Recomputes potential new paths to update allshortest paths.
        while !queue.isEmpty {
            let smallestDistanceVertex = queue.smallest!
            smallestDistanceVertex.stateColor = .black
            queue.pop(vertex: smallestDistanceVertex)
            
            let neighbourList = smallestDistanceVertex.availableNeighbourVertexList(in: vertexList, with: size)
            neighbourList.forEach {
                $0.stateColor = .gray
                queue.push($0)
                
                // Weight/distance to neighbour vertex nodes is equal to neighbour vertex index difference.
                let weight = ($0.index - smallestDistanceVertex.index)
                
                if weight < $0.distance {
                    $0.distance = weight
                    $0.predecessorIndex = smallestDistanceVertex.index
                    
                    delegate?.primsAlgorithm(self, didUpdate: $0)
                }
            }
        }
        
        return vertexList
    }
}


/// The object that acts as the delegate of the `PrimsAlgorithm`.
///
/// The delegate must adopt the PrimsAlgorithmDelegate protocol.
///
/// The delegate object is responsible for managing the vertex update.
protocol PrimsAlgorithmDelegate: class {
    
    /// Tells the delegate that vertex was updated.
    ///
    /// - Parameters:
    ///     - algorithm: An object of the PrimsAlgorithm.
    ///     - vertex: A vertex node to be updated.
    func primsAlgorithm(_ algorithm: PrimsAlgorithm, didUpdate vertex: Vertex)
}
