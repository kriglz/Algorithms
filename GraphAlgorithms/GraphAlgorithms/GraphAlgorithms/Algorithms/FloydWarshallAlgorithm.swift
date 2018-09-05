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
        
        // Sets up default matrix.
        for index in 0..<count {
            distanceMatrix[index][index] = 0
            
            let neighbourList = vertexList[index].availableNeighbourVertexList(in: vertexList, with: size)
            neighbourList.forEach {                
                // Weight/distance to neighbour vertex nodes is equal to neighbour vertex index difference.
                let weight = abs($0.index - vertexList[index].index)
                let neighbourIndex = $0.index
                
                distanceMatrix[index][neighbourIndex] = weight
                predecessorMatrix[index][neighbourIndex] = index
            }
        }
        
        // Optimizes paths.
        for pivotIndex in 0..<count {
            for rowIndex in 0..<count {
                guard pivotIndex != rowIndex, !vertexList[pivotIndex].isIgnored, !vertexList[rowIndex].isIgnored else { continue }

                for columnIndex in 0..<count {
                    guard pivotIndex != columnIndex, rowIndex != columnIndex, !vertexList[columnIndex].isIgnored  else { continue }

                    var alterantiveDistance = Double(distanceMatrix[rowIndex][pivotIndex])
                    alterantiveDistance += Double(distanceMatrix[pivotIndex][columnIndex])
                    
                    if alterantiveDistance < Double(distanceMatrix[rowIndex][columnIndex]) {
                        distanceMatrix[rowIndex][columnIndex] = Int(alterantiveDistance)
                        predecessorMatrix[rowIndex][columnIndex] = predecessorMatrix[pivotIndex][columnIndex]
                    }
                }
            }
        }
        
        // Finds shortest paths.
        let sourceIndex = Vertex.startIndex(for: vertexList)
        var targetIndex = count - 1

        while targetIndex >= 0 {
            if let path = constructShortestPath(from: sourceIndex, to: targetIndex, for: vertexList, predecessorMatrix) {
                for vertexInPath in path {
                    delegate?.floydWarshallAlgorithm(self, didUpdate: vertexInPath)
                }
            }
            targetIndex -= 1
        }

        return vertexList
    }
    
    /// Constructs shortest path in given vertex list.
    ///
    /// - Parameters:
    ///     - sourceIndex: A path's source index.
    ///     - targetIndex: A path's target index.
    ///     - vertexList: Vertex list to be searched.
    ///     - predecessorMatrix: A matrix of all pair predecessors.
    private func constructShortestPath(from sourceIndex: Int, to targetIndex: Int, for vertexList: [Vertex], _ predecessorMatrix: [[Int]]) -> [Vertex]? {
        guard vertexList[targetIndex].stateColor == .white else { return nil }
        
        var path: [Vertex]?
        var pathTargetIndex = targetIndex
        
        while pathTargetIndex != sourceIndex {
            if predecessorMatrix[sourceIndex][pathTargetIndex] == -1, vertexList[pathTargetIndex].isIgnored == true {
                return nil
            }
            
            let predecessorIndex = predecessorMatrix[sourceIndex][pathTargetIndex]
            
            vertexList[pathTargetIndex].stateColor = .gray
            vertexList[pathTargetIndex].predecessorIndex = predecessorIndex
            
            if path == nil {
                path = [Vertex]()
            }
            path!.insert(vertexList[pathTargetIndex], at: 0)
            
            pathTargetIndex = predecessorIndex
        }
        
        return path
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
