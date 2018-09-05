//
//  Maze+FloydWarshallAlgorithmDelegate.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 9/4/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

extension Maze: FloydWarshallAlgorithmDelegate {
    
    // MARK: - FloydWarshallAlgorithmDelegate implementation
    
    func floydWarshallAlgorithm(_ algorithm: FloydWarshallAlgorithm, didUpdate vertex: Vertex) {
        delegate?.maze(self, didUpdate: vertex, actionIndex: actionIndex)
        actionIndex += 1
    }
}
