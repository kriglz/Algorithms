//
//  KDTree.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/9/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class KDTree {
    
    private(set) var root: KDNode?
    private var points: [CGPoint]!

    /// Recursively construct kd tree using median methods on input point.
    init(from points: [CGPoint]) {
        guard !points.isEmpty else {
            NSLog("0 points.")
            return
        }
        
        self.points = points
        
        guard let rootNode = generateKDNode(left: 0, right: points.count - 1) else {
            NSLog("No node available.")
            return
        }
        
        self.root = rootNode
    }
    
    /// Gets a medium value recursively.
    private func generateKDNode(left: Int, right: Int) -> KDNode? {
        guard right >= left else {
            NSLog("Wrong range - right < left")
            return nil
        }
        
        if right == left {
            return KDNode(from: points[left])
        }
        
        // Order the array of points so the mth element will be the median and the elements prior to it will be all <=, though they won't be sorted; similarly, the elements after will be all >=.
        let medium = 1 + (right - left) / 2
        let algorithm = QuicksortSortingAlgorithm(sortingArray: points)
//        algorithm.select(mediumIndex: medium, leftIndex: 0, rightIndex: points.count - 1)
        
        algorithm.select(mediumIndex: medium, leftIndex: left, rightIndex: right)
        points = algorithm.sortingArray
        
        // Median point becomes the parent.
        let parentNode = KDNode(from: points[left + medium - 1])
        
        if let leftNode = generateKDNode(left: left, right: left + medium - 2) {
            parentNode.update(left: leftNode)
        }
        
        if let rightNode = generateKDNode(left: left + medium, right: right) {
            parentNode.update(right: rightNode)
        }
        
        return parentNode
    }
}
