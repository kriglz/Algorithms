//
//  CGPath+Extension.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

extension CGPath {
    
    /// Draws grid of size - columns x rows.
    ///
    /// - Parameters:
    ///     - columns: The column number of the grid.
    ///     - rows: The row number of the grid.
    ///     - cellSize: The size of the grid cell.
    /// - Returns: Path to be drawn
    static func grid(columns: Int, rows: Int, cellSize: Int) -> CGPath {
        let path = UIBezierPath()
        
        for column in 0...columns {
            path.move(to: CGPoint(x: column * cellSize, y: 0))
            path.addLine(to: CGPoint(x: column * cellSize, y: cellSize * rows))
        }
        
        for row in 0...rows {
            path.move(to: CGPoint(x: 0, y: row * cellSize))
            path.addLine(to: CGPoint(x: cellSize * columns, y: row * cellSize))
        }
        
        UIColor.red.setStroke()
        path.stroke()
        return path.cgPath
    }
    
    /// Draws the maze.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list for the maze.
    ///     - columns: The column number of the maze grid.
    ///     - rows: The row number of the maze grid.
    ///     - cellSize: The size of the maze grid cell.
    /// - Returns: Path to be drawn
    static func maze(vertexList: [Vertex], columns: Int, rows: Int, cellSize: Int) -> CGPath {
        let path = UIBezierPath()
        
        for vertex in vertexList {
            guard vertex.predecessorIndex >= 0 else { continue }
            
            let index = vertex.index
            let predecessorIndex = vertex.predecessorIndex
            
            let cellRow = (Double(index) / Double(columns)).rounded(.down)
            let cellColumn = Double(index) - cellRow * Double(columns)
            
            let predecessorCellRow = (Double(predecessorIndex) / Double(columns)).rounded(.down)
            let predecessorCellColumn = Double(predecessorIndex) - predecessorCellRow * Double(columns)
            
            path.move(to: CGPoint(x: Double(cellSize) * ( 0.5 + cellColumn),
                                  y: Double(cellSize) * ( 0.5 + cellRow)))
            
            path.addLine(to: CGPoint(x: Double(cellSize) * ( 0.5 + predecessorCellColumn),
                                     y: Double(cellSize) * ( 0.5 + predecessorCellRow)))
        }
        
        path.lineWidth = 3
        UIColor.white.setStroke()
        path.stroke()
        return path.cgPath
    }
    
    /// Draws the maze.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list for the maze.
    ///     - columns: The column number of the maze grid.
    ///     - rows: The row number of the maze grid.
    ///     - cellSize: The size of the maze grid cell.
    /// - Returns: Path to be drawn
    static func line(vertex: Vertex, columns: Int, rows: Int, cellSize: Int) -> CGPath {
        let path = UIBezierPath()
        
        let index = vertex.index
        let predecessorIndex = vertex.predecessorIndex
        
        let cellRow = (Double(index) / Double(columns)).rounded(.down)
        let cellColumn = Double(index) - cellRow * Double(columns)
        
        let predecessorCellRow = (Double(predecessorIndex) / Double(columns)).rounded(.down)
        let predecessorCellColumn = Double(predecessorIndex) - predecessorCellRow * Double(columns)
        
        path.move(to: CGPoint(x: Double(cellSize) * ( 0.5 + cellColumn),
                              y: Double(cellSize) * ( 0.5 + cellRow)))
        
        path.addLine(to: CGPoint(x: Double(cellSize) * ( 0.5 + predecessorCellColumn),
                                 y: Double(cellSize) * ( 0.5 + predecessorCellRow)))
        
//        path.lineWidth = 3
//        UIColor.white.setStroke()
        path.stroke()
        return path.cgPath
    }
}
