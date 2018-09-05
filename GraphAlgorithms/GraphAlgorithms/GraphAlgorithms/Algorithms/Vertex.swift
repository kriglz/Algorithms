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
    /// The vertex node property set to true id it needs to be ignored in algortithm.
    var isIgnored = false
    
    /// Returns a vertex node.
    ///
    /// - Parameters:
    ///     - index: Unique index for the vertex node.
    init(index: Int) {
        self.index = index
    }
    
    /// Returns start index for algorithm.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list of specifeid vertex.
    static func startIndex(for vertexList: [Vertex]) -> Int {
        //        let startIndex = Int(CGFloat.random(min: 0, max: CGFloat(size.columns * size.rows)) / 2)
        var startIndex = vertexList.count / 2
        
        if vertexList[startIndex].isIgnored, let firstVertex = vertexList.first(where: { $0.isIgnored == false }) {
            startIndex = firstVertex.index
        }
        
        return startIndex
    }
    
    /// Returns boolen indicating if specified vertex is a neighbour vertex.
    ///
    /// - Parameters:
    ///     - vertex: Vertex to be identified as a neighbour.
    func isNeighbour(of vertex: Vertex, in size: VertexListSize) -> Bool {
        // Current vertex is most left vertex.
        if index == 0 || index % size.columns == 0 {
            return false
        }
        
        // Current vertex is most right vertex.
        let rightIndex = index + 1
        if rightIndex >= size.columns, rightIndex % size.columns == 0 {
            return false
        }
        
        // Specified vertex is left direction neighbour.
        if index == vertex.index - 1 {
            return true
        }
        
        // Specified vertex is right direction neighbour.
        if index == rightIndex {
            return true
        }
        
        // Specified vertex is up direction neighbour.
        if index == vertex.index + size.columns {
            return true
        }
        
        // Specified vertex is down direction neighbour.
        if index == vertex.index - size.columns {
            return true
        }

        return false
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
                if range.contains(leftIndex), vertexList[leftIndex].stateColor == .white, !vertexList[leftIndex].isIgnored {
                    neighbourVertexList.append(vertexList[leftIndex])
                }
            case .right:
                let rightIndex = index + 1
                if rightIndex >= size.columns, rightIndex % size.columns == 0 { break }
                
                if range.contains(rightIndex), vertexList[rightIndex].stateColor == .white, !vertexList[rightIndex].isIgnored {
                    neighbourVertexList.append(vertexList[rightIndex])
                }
                
            case .up:
                let upIndex = index + size.columns
                if range.contains(upIndex), vertexList[upIndex].stateColor == .white, !vertexList[upIndex].isIgnored {
                    neighbourVertexList.append(vertexList[upIndex])
                }
                
            case .down:
                let downIndex = index - size.columns
                if range.contains(downIndex), vertexList[downIndex].stateColor == .white, !vertexList[downIndex].isIgnored {
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
