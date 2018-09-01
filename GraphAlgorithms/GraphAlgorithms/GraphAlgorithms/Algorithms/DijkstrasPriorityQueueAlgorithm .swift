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
    
    private var size = VertexListSize()
    
    // MARK: - Vertex list item management
    
    func search(in vertexList: [Vertex], size: VertexListSize) -> [Vertex] {
        self.size = size
        let startIndex = 0 // (size.columns * size.rows) / 2
        return searchSingleSourceShortest(for: startIndex, in: vertexList)
    }
    
    private func searchSingleSourceShortest(for index: Int, in vertexList: [Vertex]) -> [Vertex] {
        let maxVertexIndex = vertexList.count - 1
        var queue = Queue<Vertex>()

        vertexList[index].distance = 0
        
        // Adds all vertex nodes to the queue.
        for index in 0...maxVertexIndex {
            queue.push(vertexList[index])
        }
        
        // Finds vertex in ever-shrinking set, whose distance is smallest.
        // Recomputes potential new paths to update allshortest paths.
        while !queue.isEmpty {
            let smallest = queue.smallest
            print(smallest)
            
            
        }
        
        
        
        return vertexList
    }
}
