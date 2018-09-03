//
//   MainViewController+MazeDelegate.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

extension MainViewController: MazeDelegate {
    
    // MARK: - MazeDelegate implementation
    
    func maze(_ maze: Maze, didUpdate vertex: Vertex, actionIndex: Int) {
        graphView.drawVertexLine(vertex: vertex, in: maze, actionIndex: actionIndex)
    }
    
    func maze(_ maze: Maze, ignoredVertexIndexList: [Int]) {
        graphView.drawObstacles(for: ignoredVertexIndexList, in: maze)
    }
}
