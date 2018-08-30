//
//  Maze+DepthFirstSearchAlgorithmDelegate.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

extension Maze: DepthFirstSearchAlgorithmDelegate {
    
    // MARK: - DepthFirstSearchAlgorithmDelegate implementation
    
    func depthFirstSearchAlgorithm(_ algorithm: DepthFirstSearchAlgorithm, didUpdate vertex: Vertex) {
        delegate?.maze(self, didUpdate: vertex, actionIndex: actionIndex)
        actionIndex += 1
    }
}
