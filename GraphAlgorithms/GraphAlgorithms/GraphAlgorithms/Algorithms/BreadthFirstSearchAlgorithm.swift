//
//  BreadthFirstSearchAlgorithm.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/30/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

/// Breadth-first search algorithm for specified vertex array.
class BreadthFirstSearchAlgorithm {
    
    // MARK: - Properties
    
    weak var delegate: BreadthFirstSearchAlgorithmDelegate? = nil
    
    private var size = VertexListSize()
    
    // MARK: - Vertex list item management
    
    /// Generates new list or vertex based on Breadth-first search algorithm.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list to be searched.
    ///     - size: Vertex list size in columns and rows.
    func search(in vertexList: [Vertex], size: VertexListSize) -> [Vertex] {
        self.size = size
        let startIndex = (size.columns * size.rows) / 2
        return updateVertex(at: startIndex, in: vertexList)
    }
    
    /// Udpdates vertex list based on specified verex position in vertex node system using Breadth-first search algorithm.
    ///
    /// - Parameters:
    ///     - index: Index of specified vertex.
    ///     - vertexList: Vertex list to be searched.
    private func updateVertex(at index: Int, in vertexList: [Vertex]) -> [Vertex] {
        guard vertexList[index].stateColor != .black else { return vertexList }
        
        if vertexList[index].stateColor == .white {
            vertexList[index].stateColor = .gray
        }
        
        var queue = Queue<Vertex>()
        queue.push(vertexList[index])
        
        while !queue.isEmpty {
            let neighbourList = availableNeighbourVertexList(for: queue.first!.index, in: vertexList)
                        
            neighbourList.forEach {
                $0.predecessorIndex = queue.first!.index
                $0.stateColor = .gray
                queue.push($0)
                
                delegate?.breadthFirstSearchAlgorith(self, didUpdate: $0)
            }
            
            queue.pop()
            vertexList[index].stateColor = .black
        }
        
        return vertexList
    }
    
    /// Returns next in line neighbour vertex nodes.
    ///
    /// - Parameters:
    ///     - currentVertexIndex: Index of current vertex.
    ///     - vertexList: Vertex list of specifeid vertex.
    private func availableNeighbourVertexList(for currentVertexIndex: Int, in vertexList: [Vertex]) -> [Vertex] {
        let range = 0...(vertexList.count - 1)
        var neighbourVertexList = [Vertex]()

        // Left
        let leftIndex = currentVertexIndex - 1
        if currentVertexIndex == 0 || currentVertexIndex % size.columns > 0, range.contains(leftIndex), vertexList[leftIndex].stateColor == .white {
            neighbourVertexList.append(vertexList[leftIndex])
        }
        
        // Right
        let rightIndex = currentVertexIndex + 1
        if currentVertexIndex + 1 >= size.columns, (currentVertexIndex + 1) % size.columns > 0, range.contains(rightIndex), vertexList[rightIndex].stateColor == .white {
            neighbourVertexList.append(vertexList[rightIndex])
        }
        
        // Up
        let upIndex = currentVertexIndex + size.columns
        if range.contains(upIndex), vertexList[upIndex].stateColor == .white {
            neighbourVertexList.append(vertexList[upIndex])
        }
        
        // Down
        let downIndex = currentVertexIndex - size.columns
        if range.contains(downIndex), vertexList[downIndex].stateColor == .white {
            neighbourVertexList.append(vertexList[downIndex])
        }
        
        return neighbourVertexList
    }
}

/// The object that acts as the delegate of the `BreadthFirstSearchAlgorithm`.
///
/// The delegate must adopt the BreadthFirstSearchAlgorithmDelegate protocol.
///
/// The delegate object is responsible for managing the vertex update.
protocol BreadthFirstSearchAlgorithmDelegate: class {
    
    /// Tells the delegate that vertex was updated.
    ///
    /// - Parameters:
    ///     - algorithm: An object of the BreadthFirstSearchAlgorithm.
    ///     - vertex: A vertex node to be updated.
    func breadthFirstSearchAlgorith(_ algorithm: BreadthFirstSearchAlgorithm, didUpdate vertex: Vertex)
}
