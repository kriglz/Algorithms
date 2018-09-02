//
//  DijkstrasPriorityQueueAlgorithm .swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/31/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

/// Dijkstra's Priority Queue search algorithm for specified vertex array.
class DijkstrasPriorityQueueAlgorithm {

    // MARK: - Properties
    
    weak var delegate: DijkstrasPriorityQueueAlgorithmDelegate? = nil
    
    private var size = VertexListSize()
    
    // MARK: - Vertex list item management
    
    /// Searches for shortest path in vertex list based on Dijkstra's Priority Queue search algorithm.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list to be searched.
    ///     - size: Vertex list size in columns and rows.
    func search(in vertexList: [Vertex], size: VertexListSize) -> [Vertex] {
        self.size = size
        let startIndex = (size.columns * size.rows) / 2
        return searchSingleSourceShortest(for: startIndex, in: vertexList)
    }
    
    /// Searches for single shortest path in vertex list.
    ///
    /// - Parameters:
    ///     - index: Index of specified initial vertex.
    ///     - vertexList: Vertex list to be searched.
    private func searchSingleSourceShortest(for index: Int, in vertexList: [Vertex]) -> [Vertex] {
        let maxVertexIndex = vertexList.count - 1
        var queue = Queue<Vertex>()
        
        // Adds all vertex nodes to the queue.
        for index in 0...maxVertexIndex {
            queue.push(vertexList[index])
        }
        
        // Set source vertex distance to 0.
        vertexList[index].distance = 0
        
        // Finds vertex in ever-shrinking set, whose distance is smallest.
        // Recomputes potential new paths to update allshortest paths.
        while !queue.isEmpty {
            let smallestDistanceVertex = queue.smallest!
            smallestDistanceVertex.stateColor = .black
            queue.pop(vertex: smallestDistanceVertex)
            
            let neighbourList = smallestDistanceVertex.availableNeighbourVertexList(in: vertexList, with: size)
            neighbourList.forEach {
                // Weight/distance to neighbour vertex nodes is always set to 1.
                let alternativeDistance = smallestDistanceVertex.distance + 1
                
                if alternativeDistance < $0.distance {
                    $0.stateColor = .gray
                    $0.distance = alternativeDistance
                    $0.predecessorIndex = smallestDistanceVertex.index
                    
                    delegate?.dijkstrasPriorityQueueAlgorithm(self, didUpdate: $0)
                }
            }
        }
        
        return vertexList
    }
}

/// The object that acts as the delegate of the `DijkstrasPriorityQueueAlgorithm`.
///
/// The delegate must adopt the DijkstrasPriorityQueueAlgorithmDelegate protocol.
///
/// The delegate object is responsible for managing the vertex update.
protocol DijkstrasPriorityQueueAlgorithmDelegate: class {
    
    /// Tells the delegate that vertex was updated.
    ///
    /// - Parameters:
    ///     - algorithm: An object of the DijkstrasPriorityQueueAlgorithm.
    ///     - vertex: A vertex node to be updated.
    func dijkstrasPriorityQueueAlgorithm(_ algorithm: DijkstrasPriorityQueueAlgorithm, didUpdate vertex: Vertex)
}
