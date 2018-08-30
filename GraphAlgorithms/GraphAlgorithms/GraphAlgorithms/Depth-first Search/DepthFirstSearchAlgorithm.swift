//
//  DepthFirstSearchAlgorithm.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Foundation

/// Depth-first search algorithm for specified vertex array.
class DepthFirstSearchAlgorithm {
    
    // MARK: - Properties

    weak var delegate: DepthFirstSearchAlgorithmDelegate? = nil
    
    private var columns: Int
    private var rows: Int

    // MARK: - Initialization
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
    }
    
    // MARK: - Vertex list item management
    
    /// Generates new list or vertex based on Depth-first search algorithm.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list to be searched.
    func search(in vertexList: [Vertex]) -> [Vertex] {
        return updateVertex(at: 0, in: vertexList)
    }
    
    /// Udpdates vertex based on position in vertex node system using Depth-first search algorithm.
    ///
    /// - Parameters:
    ///     - index: Index of specified vertex.
    ///     - vertexList: Vertex list to be searched.
    private func updateVertex(at index: Int, in vertexList: [Vertex]) -> [Vertex] {
        guard vertexList[index].stateColor != .black else { return vertexList }
        
        if vertexList[index].stateColor == .white {
            vertexList[index].stateColor = .gray
        }
        
        var randomDirections = [Direction]()
        func randomDirectionVertex() -> Vertex? {
            let direction = Direction.random
            
            if randomDirections.contains(direction) {
                return randomDirectionVertex()
            }
            
            randomDirections.append(direction)
            
            let newVertex = nextVertex(for: index, in: vertexList, towards: direction)
            
            if newVertex == nil, randomDirections.count >= 4 {
                return nil
            }
            
            if newVertex == nil, randomDirections.count < 4 {
                return randomDirectionVertex()
            }
            
            if newVertex != nil, newVertex!.stateColor != .white, randomDirections.count < 4  {
                return randomDirectionVertex()
            }
            
            if newVertex != nil, newVertex!.stateColor == .white {
                return newVertex
            }
            
            return nil
        }
        
        if let newVertex = randomDirectionVertex() {
            newVertex.predecessorIndex = index
            delegate?.depthFirstSearchAlgorithm(self, didUpdate: newVertex)
            return updateVertex(at: newVertex.index, in: vertexList)
        
        } else {
            vertexList[index].stateColor = .black
            
            let predecessorIndex = vertexList[index].predecessorIndex
            if predecessorIndex > -1 {
                return updateVertex(at: predecessorIndex, in: vertexList)
            }
        }
        
        return vertexList
    }
    
    /// Returns next in line vertex node for specified direction.
    ///
    /// - Parameters:
    ///     - currentVertexIndex: Index of current vertex.
    ///     - vertexList: Vertex list of specifeid vertex.
    ///     - direction: Next in line vertex direction.
    private func nextVertex(for currentVertexIndex: Int, in vertexList: [Vertex], towards direction: Direction) -> Vertex? {
        var index = currentVertexIndex
        
        switch direction {
        case .left:
            // Return nil for left most current vertex.
            if currentVertexIndex == 0 || currentVertexIndex % columns == 0 {
                return nil
            }
            index -= 1
        case .right:
            // Return nil for right most current vertex.
            if currentVertexIndex + 1 >= columns, (currentVertexIndex + 1) % columns == 0 {
                return nil
            }
            index += 1
        case .up:
            index += columns
        case .down:
            index -= columns
        }
        
        guard index < vertexList.count, index >= 0 else { return nil }
        
        return vertexList[index]
    }
}

/// The object that acts as the delegate of the `DepthFirstSearchAlgorithm`.
///
/// The delegate must adopt the DepthFirstSearchAlgorithmDelegate protocol.
///
/// The delegate object is responsible for managing the vertex update.
protocol DepthFirstSearchAlgorithmDelegate: class {
    
    /// Tells the delegate that vertex was updated.
    ///
    /// - Parameters:
    ///     - algorithm: An object of the DepthFirstSearchAlgorithm.
    ///     - vertex: A vertex node to be updated.
    func depthFirstSearchAlgorithm(_ algorithm: DepthFirstSearchAlgorithm, didUpdate vertex: Vertex)
}
