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
    
    private var mazeSize: VertexListSize {
        return VertexListSize(columns: columns, rows: rows)
    }
    
    // MARK: - Initialization
    
    /// Returns a maze object.
    ///
    /// - Parameters:
    ///     - columns: Column number for the maze.
    ///     - rows: Row number for the maze.
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
    }
    
    /// Sets up a new maze with specified alforithm.
    ///
    /// - Parameters:
    ///     - type: The type of algorithm to be used for maze generation.
    func setupAlgorithm(type: AlgorithmTypes) {
        reset()
        setupRawVertexList(columns: columns, rows: rows, hasIgnoredVertex: true)

        switch type {
        case .depthFirst:
            fillUpDFVertexList()
        case .breadthFirst:
            fillUpBFVertexList()
        case .dijkstras:
            fillUpDijkstrasVertexList()
        case .prims:
            fillUpPrimsVertexList()
        case .floydWarshall:
            fillUpFloydWarshallVertexList()
        }
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
    private func setupRawVertexList(columns: Int, rows: Int, hasIgnoredVertex: Bool = false) {
        let maxIndex = columns * rows
        
        for index in 0..<maxIndex {
            let vertex = Vertex(index: index)
            vertexList.append(vertex)
        }
        
        if hasIgnoredVertex {
            var vertexObstacleIndexList = [Int]()
            let maxNumber = maxIndex / 10
            for _ in 0...maxNumber {
                let randomIndex = Int.random(min: 0, max: vertexList.count - 1)
                vertexObstacleIndexList.append(randomIndex)
                vertexList[randomIndex].isIgnored = true
            }
            delegate?.maze(self, ignoredVertexIndexList: vertexObstacleIndexList)
        }
    }
    
    /// Runs Depth-first search algorithm to setup Vertex list for maze.
    private func fillUpDFVertexList() {
        let depthFirstAlgorithm = DepthFirstSearchAlgorithm()
        depthFirstAlgorithm.delegate = self
        vertexList = depthFirstAlgorithm.search(in: vertexList, size: mazeSize)
    }
    
    /// Runs Depth-first search algorithm to setup Vertex list for maze.
    private func fillUpBFVertexList() {
        let breadthFirstAlgorithm = BreadthFirstSearchAlgorithm()
        breadthFirstAlgorithm.delegate = self
        vertexList = breadthFirstAlgorithm.search(in: vertexList, size: mazeSize)
    }
    
    /// Runs Depth-first search algorithm to setup Vertex list for maze.
    private func fillUpDijkstrasVertexList() {
        let dijkstrasAlgorithm = DijkstrasPriorityQueueAlgorithm()
        dijkstrasAlgorithm.delegate = self
        vertexList = dijkstrasAlgorithm.search(in: vertexList, size: mazeSize)
    }
    
    /// Runs Prim's search algorithm to setup Vertex list for maze.
    private func fillUpPrimsVertexList() {
        let primsAlgorithm = PrimsAlgorithm()
        primsAlgorithm.delegate = self
        vertexList = primsAlgorithm.search(in: vertexList, size: mazeSize)
    }
    
    /// Runs Floyd-Warshall's search algorithm to setup Vertex list for maze.
    private func fillUpFloydWarshallVertexList() {
        let fWAlgorithm = FloydWarshallAlgorithm()
        fWAlgorithm.delegate = self
        vertexList = fWAlgorithm.search(in: vertexList, size: mazeSize)
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
    
    /// Informs the delegate about obstacle type vertex index.
    ///
    /// - Parameters:
    ///     - maze: An object of the maze.
    ///     - ignoredVertexIndexList: A list of vertex indexes who needs to be ignored.
    func maze(_ maze: Maze, ignoredVertexIndexList: [Int])
}
