//
//  Vertex.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

/// A node object which contains properties to define its position and state in node system.
class Vertex {
    
    /// The index of the previous in line vertex node.
    var predecessorIndex = -1
    /// The index of current vertex node.
    var index: Int
    /// The state defined by color of current vertex node.
    var stateColor = VertexStateColor.white
    
    /// Returns a vertex node.
    ///
    /// - Parameters:
    ///     - index: Unique index for the vertex node.
    init(index: Int) {
        self.index = index
    }
}

/// Vertex state types defines by color.
enum VertexStateColor {
    
    /// Vertex has not been visited yet.
    case white
    /// Vertex has been visited, but it may have adjacent vertex that has been not.
    case gray
    /// Vertex has been visited and so all its adjacent vertices.
    case black
}

/// Direction type to the new vertex.
///
/// List of possible directions:
/// - up
/// - down
/// - left
/// - right
enum Direction: Int {
    
    case up = 1
    case down = 2
    case left = 3
    case right = 4
    
    /// Returns a random direction from all possible directions.
    static var random: Direction {
        let randomInt = (Int(arc4random_uniform(4)) + 1);
        return Direction.init(rawValue: randomInt) ?? .up
    }
}
