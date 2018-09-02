//
//  Vertex.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

/// A node object which contains properties to define its position and state in node system.
class Vertex {
    
    /// The index of the previous in line vertex node.
    var predecessorIndex = -1
    /// The index of current vertex node.
    var index: Int
    /// The distance to the source vertex node.
    var distance = Int.max
    /// The state defined by color of current vertex node.
    var stateColor = VertexStateColor.white
    
    /// Returns a vertex node.
    ///
    /// - Parameters:
    ///     - index: Unique index for the vertex node.
    init(index: Int) {
        self.index = index
    }
    
    /// Returns next in line neighbour vertex nodes.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list of specifeid vertex.
    ///     - size: Vertex list size.
    func availableNeighbourVertexList(in vertexList: [Vertex], with size: VertexListSize) -> [Vertex] {
        let range = 0...(vertexList.count - 1)
        var neighbourVertexList = [Vertex]()
        
        // Randomizing neighbour vertex sequence to create patters.
        let randomDirections = Direction.randomDirections
        randomDirections.forEach { direciton in
            switch direciton {
            case .left:
                if index == 0 || index % size.columns == 0 { break }

                let leftIndex = index - 1
                if range.contains(leftIndex), vertexList[leftIndex].stateColor == .white {
                    neighbourVertexList.append(vertexList[leftIndex])
                }
            case .right:
                let rightIndex = index + 1
                if rightIndex >= size.columns, rightIndex % size.columns == 0 { break }
                
                if range.contains(rightIndex), vertexList[rightIndex].stateColor == .white {
                    neighbourVertexList.append(vertexList[rightIndex])
                }
                
            case .up:
                let upIndex = index + size.columns
                if range.contains(upIndex), vertexList[upIndex].stateColor == .white {
                    neighbourVertexList.append(vertexList[upIndex])
                }
                
            case .down:
                let downIndex = index - size.columns
                if range.contains(downIndex), vertexList[downIndex].stateColor == .white {
                    neighbourVertexList.append(vertexList[downIndex])
                }
            }
        }
        
        return neighbourVertexList
    }
}

extension Vertex: Equatable {
    
    static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.index == rhs.index
    }
}
