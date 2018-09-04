//
//  Maze+PrimsAlgorithmDelegate.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 9/4/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

extension Maze: PrimsAlgorithmDelegate {
    
    // MARK: - PrimsAlgorithmDelegate implementation

    func primsAlgorithm(_ algorithm: PrimsAlgorithm, didUpdate vertex: Vertex) {
        delegate?.maze(self, didUpdate: vertex, actionIndex: actionIndex)
        actionIndex += 1
    }
}
