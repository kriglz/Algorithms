//
//  Maze.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

// A maze object generated by Depth-first search algorithm.
class Maze {
    
    // MARK: - Properties
    
    weak var delegate: MazeDelegate? = nil
    
    var actionIndex = 0

    private(set) var vertexList = [Vertex]()
    
    private(set) var columns: Int
    private(set) var rows: Int
    
    private lazy var depthFirstAlgorithm = DepthFirstSearchAlgorithm(columns: columns, rows: rows)
    
    // MARK: - Initialization
    
    /// Returns a maze object.
    ///
    /// - Parameters:
    ///     - columns: Column number for the maze.
    ///     - rows: Row number for the maze.
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        
        depthFirstAlgorithm.delegate = self
    }
    
    /// Sets up a new maze.
    func setup() {
        reset()

        setupRawVertexList(columns: columns, rows: rows)
        fillUpVertexList()
    }
    
    /// Resets existing maze.
    private func reset() {
        vertexList = []
        actionIndex = 0
    }
    
    // MARK: - Vertex list set up
    
    /// Initialized empty matrix of size: columns x rows.
    ///
    /// - Parameters:
    ///     - columns: Column number for the maze.
    ///     - rows: Row number for the maze.
    private func setupRawVertexList(columns: Int, rows: Int) {
        let maxIndex = columns * rows
        
        for index in 0..<maxIndex {
            let vertex = Vertex(index: index)
            vertexList.append(vertex)
        }
    }
    
    /// Runs Depth-first search algorithm to setup Vertex list for maze.
    private func fillUpVertexList() {
        vertexList = depthFirstAlgorithm.search(in: vertexList)
    }
}

/// The object that acts as the delegate of the `Maze`.
///
/// The delegate must adopt the MazeDelegate protocol.
///
/// The delegate object is responsible for managing the maze vertex update.
protocol MazeDelegate: class {
    
    /// Tells the delegate that vertex was updated.
    ///
    /// - Parameters:
    ///     - maze: An object of the maze.
    ///     - vertex: A vertex node to be updated.
    ///     - actionIndex: Index of update action in maze setup sequence.
    func maze(_ maze: Maze, didUpdate vertex: Vertex, actionIndex: Int)
}
