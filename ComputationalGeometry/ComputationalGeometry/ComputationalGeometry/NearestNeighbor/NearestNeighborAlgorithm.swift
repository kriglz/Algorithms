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
    
    private(set) var treeActionBuffer = [TreeLineDrawingAction]()
    fileprivate var actionIndex = 0
    
    init(points: [CGPoint]) {
        self.points = points
        self.tree = KDTree(maxDimension: 2, from: points)
        self.tree.delegate = self
        self.tree.generate()
    }
    
    func nearestNeighbor(for point: CGPoint) -> CGPoint? {
        return tree.nearestNeighbor(for: point)
    }
}

extension NearestNeighborAlgorithm: KDTreeDelegate {
    
    func kdTree(_ tree: KDTree, didAdd node: KDNode) {
        let action = TreeLineDrawingAction(node: node, index: actionIndex)
        treeActionBuffer.append(action)
        actionIndex += 1
    }
}
