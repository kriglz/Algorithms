//
//  Maze+BreadthFirstSearchAlgorithmDelegate.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/31/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

extension Maze: BreadthFirstSearchAlgorithmDelegate {

    // MARK: - BreadthFirstSearchAlgorithmDelegate implementation
    
    func breadthFirstSearchAlgorithm(_ algorithm: BreadthFirstSearchAlgorithm, didUpdate vertex: Vertex) {
        delegate?.maze(self, didUpdate: vertex, actionIndex: actionIndex)
        actionIndex += 1
    }
}
