//
//  GraphView.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    private var duration = 0.1
    
    // MARK: - Initialization

    convenience init() {
        self.init(frame: .zero)
        
        self.isUserInteractionEnabled = false
    }
    
    func reset() {
        layer.sublayers?.removeAll()
    }
    
    // MARK: - Views to draw
    
    func drawVertexLine(vertex: Vertex, in maze: Maze, actionIndex: Int, cellSize: Int = 10) {
        let columns = maze.columns
        let rows = maze.rows
        
        let lineLayer = CAShapeLayer()
        let linePath = CGPath.line(vertex: vertex, columns: columns, rows: rows, cellSize: cellSize)
        lineLayer.path = linePath
        lineLayer.lineWidth = 3
        
//        let normalizedIndex = CGFloat(vertex.index) / CGFloat(maze.rows * maze.columns)
//        lineLayer.strokeColor = UIColor(red: normalizedIndex, green: 0, blue: normalizedIndex * 0.5 + 0.5, alpha: 1).cgColor
        
        lineLayer.strokeColor = UIColor.white.cgColor
        
        layer.addSublayer(lineLayer)
        
        lineLayer.strokeStart = 1
        
        let drawAnimation = CABasicAnimation(keyPath: "strokeStart")
        drawAnimation.fillMode = kCAFillModeForwards
        drawAnimation.fromValue = 1
        drawAnimation.toValue = 0
        drawAnimation.beginTime = CACurrentMediaTime() + duration * Double(actionIndex)
        drawAnimation.duration = duration
        drawAnimation.isRemovedOnCompletion = false
        
        lineLayer.add(drawAnimation, forKey: "Draw")
    }
    
    func draw(maze: Maze, cellSize: Int = 30) {
        let vertexList = maze.vertexList
        let columns = maze.columns
        let rows = maze.rows

        let lineLayer = CAShapeLayer()
        let linePath = CGPath.maze(vertexList: vertexList, columns: columns, rows: rows, cellSize: cellSize)
        lineLayer.path = linePath
        lineLayer.lineWidth = 3
        lineLayer.strokeColor = UIColor.white.cgColor
        layer.addSublayer(lineLayer)
    }
    
    func drawGrid(columns: Int, rows: Int, cellSize: Int = 30) {
        let lineLayer = CAShapeLayer()
        let linePath = CGPath.grid(columns: columns, rows: rows, cellSize: cellSize)
        lineLayer.path = linePath
        lineLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(lineLayer)
    }
}
