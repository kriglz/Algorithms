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
