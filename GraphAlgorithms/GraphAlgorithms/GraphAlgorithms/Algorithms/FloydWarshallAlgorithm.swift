//
//  FloydWarshallAlgorithm.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 9/4/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

/// Floyd-Warshall's search algorithm for specified vertex array.
class FloydWarshallAlgorithm {
   
    // MARK: - Properties
    
    weak var delegate: FloydWarshallAlgorithmDelegate? = nil
    
    private var size = VertexListSize()
    
    // MARK: - Vertex list item management
    
    /// Searches for shortest path in vertex list based on Floyd-Warshall search algorithm.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list to be searched.
    ///     - size: Vertex list size in columns and rows.
    func search(in vertexList: [Vertex], size: VertexListSize) -> [Vertex] {
        self.size = size
        return searchAllPairsShortestPath(in: vertexList)
    }
    
    /// Searches for all pairs shortest path in vertex list.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list to be searched.
    private func searchAllPairsShortestPath(in vertexList: [Vertex]) -> [Vertex] {
        let count = vertexList.count
        
        var distanceMatrix = [[Int]](repeating: [Int](repeating: Int.max, count: count), count: count)
        var predecessorMatrix = [[Int]](repeating: [Int](repeating: -1, count: count), count: count)
        
        for index in 0..<count {
            distanceMatrix[index][index] = 0
            
            let neighbourList = vertexList[index].availableNeighbourVertexList(in: vertexList, with: size)
            neighbourList.forEach {
                
                // Weight/distance to neighbour vertex nodes is equal to neighbour vertex index difference.
                let weight = ($0.index - vertexList[index].index)
                let neighbourIndex = $0.index
                
                distanceMatrix[index][neighbourIndex] = weight
                predecessorMatrix[index][neighbourIndex] = index
            }
        }
        
        for pivotIndex in 0..<count {
            for rowIndex in 0..<count {
                for columnIndex in 0..<count {
                    
                    if vertexList[rowIndex].isNeighbour(of: vertexList[columnIndex], in: size) {
                        vertexList[columnIndex].predecessorIndex = rowIndex
                        delegate?.floydWarshallAlgorithm(self, didUpdate: vertexList[columnIndex])
                        continue
                    }
                    
                    guard pivotIndex != rowIndex else { continue }
                    
                    guard vertexList[pivotIndex].isNeighbour(of: vertexList[rowIndex], in: size),
                        vertexList[pivotIndex].isNeighbour(of: vertexList[columnIndex], in: size) else { continue }
                    
                    var alterantiveDistance = Double(distanceMatrix[rowIndex][pivotIndex])
                    alterantiveDistance += Double(distanceMatrix[pivotIndex][columnIndex])
                    
                    if alterantiveDistance < Double(distanceMatrix[rowIndex][columnIndex]) {
                        distanceMatrix[rowIndex][columnIndex] = Int(alterantiveDistance)
                        predecessorMatrix[rowIndex][columnIndex] = predecessorMatrix[pivotIndex][columnIndex]
                        
                        vertexList[pivotIndex].predecessorIndex = rowIndex
                        delegate?.floydWarshallAlgorithm(self, didUpdate: vertexList[pivotIndex])
                        
                        vertexList[columnIndex].predecessorIndex = pivotIndex
                        delegate?.floydWarshallAlgorithm(self, didUpdate: vertexList[columnIndex])
                        
                    } else if vertexList[rowIndex].isNeighbour(of: vertexList[columnIndex], in: size) {
                        vertexList[columnIndex].predecessorIndex = rowIndex
                        delegate?.floydWarshallAlgorithm(self, didUpdate: vertexList[columnIndex])
                    }
                }
            }
        }
        
        return vertexList
    }
}

/// The object that acts as the delegate of the `FloydWarshallAlgorithm`.
///
/// The delegate must adopt the FloydWarshallAlgorithmDelegate protocol.
///
/// The delegate object is responsible for managing the vertex update.
protocol FloydWarshallAlgorithmDelegate: class {
    
    /// Tells the delegate that vertex was updated.
    ///
    /// - Parameters:
    ///     - algorithm: An object of the FloydWarshallAlgorithm.
    ///     - vertex: A vertex node to be updated.
    func floydWarshallAlgorithm(_ algorithm: FloydWarshallAlgorithm, didUpdate vertex: Vertex)
}
