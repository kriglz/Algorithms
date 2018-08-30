//
//  VertexStateColor.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

/// Vertex state types defines by color.
enum VertexStateColor {
    
    /// Vertex has not been visited yet.
    case white
    /// Vertex has been visited, but it may have adjacent vertex that has been not.
    case gray
    /// Vertex has been visited and so all its adjacent vertices.
    case black
}
