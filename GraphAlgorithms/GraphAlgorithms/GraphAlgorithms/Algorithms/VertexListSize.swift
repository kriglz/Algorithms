//
//  VertexListSize.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

/// Vertex list size object.
struct VertexListSize {
    
    var columns: Int
    var rows: Int
    
    /// Returns a vertex list size object.
    ///
    /// - Parameters:
    ///     - columns: Number of columns.
    ///     - rows: Number of rows.
    init(columns: Int = 4, rows: Int = 4) {
        self.columns = columns
        self.rows = rows
    }
}
