//
//  NearestNeighborAlgorithm.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/9/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class NearestNeighborAlgorithm {
    
    private var points: [CGPoint]
    private var tree: KDTree
    
    init(points: [CGPoint]) {
        self.points = points
        self.tree = KDTree(from: points)
    }
    
    func nearestNeighbor(for point: CGPoint) -> CGPoint? {
        return tree.nearestNeighbor(for: point)
    }
}
