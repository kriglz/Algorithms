//
//  GraphView.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class GraphView: UIView {

    // MARK: - Initialization

    convenience init() {
        self.init(frame: .zero)
        
    }
    
    // MARK: - Views to draw
    
    func draw(maze: Maze, cellSize: Int = 30) {
        let vertexList = maze.vertexList
        let columns = maze.columns
        let rows = maze.rows

        let size = CGSize(width: cellSize * columns, height: cellSize * rows)
        let view = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        CGPath.maze(vertexList: vertexList, columns: columns, rows: rows, cellSize: cellSize)
        
        view.layer.contents = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
        UIGraphicsEndImageContext()
        
        addSubview(view)
    }
    
    func drawGrid(columns: Int, rows: Int, cellSize: Int = 30) {
        let size = CGSize(width: cellSize * columns, height: cellSize * rows)
        let view = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        CGPath.grid(columns: columns, rows: rows, cellSize: cellSize)
        
        view.layer.contents = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
        UIGraphicsEndImageContext()
        
        addSubview(view)
    }
    
}
