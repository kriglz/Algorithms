//
//  Maze+DijkstrasPriorityQueueAlgorithmDelegate.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 9/1/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

extension Maze: DijkstrasPriorityQueueAlgorithmDelegate {
    
    // MARK: - DijkstrasPriorityQueueAlgorithmDelegate implementation
    
    func dijkstrasPriorityQueueAlgorithm(_ algorithm: DijkstrasPriorityQueueAlgorithm, didUpdate vertex: Vertex) {
        delegate?.maze(self, didUpdate: vertex, actionIndex: actionIndex)
        actionIndex += 1
    }
}
