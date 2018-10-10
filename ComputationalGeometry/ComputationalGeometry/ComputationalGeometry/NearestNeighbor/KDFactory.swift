//
//  KDFactory.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/9/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class KDFactory {
    
    var points: [CGPoint]!
    
    /// REcursively construct kd tree using median methods on input point.
    func generateKDTree(from points: [CGPoint]) -> KDTree? {
        guard !points.isEmpty else {
            NSLog("0 points.")
            return nil
        }
        
        self.points = points
        
        let tree = KDTree()
        guard let rootNode = generateKDNode(left: 0, right: points.count - 1) else {
            NSLog("No node available.")
            return nil
        }
        
        tree.update(root: rootNode)
        return tree
    }
    
    /// Gets a medium value recursively.
    private func generateKDNode(left: Int, right: Int) -> KDNode? {
        guard right > left else {
            NSLog("Wrong range - right < left")
            return nil
        }
        
        if right == left {
            return KDNode(from: points[left])
        }
        
        // Order the array of points so the mth element will be the median and the elements prior to it will be all <=, though they won't be sorted; similarly, the elements after will be all >=.
        let medium = 1 + (right - left) / 2
        let algorithm = QuicksortSortingAlgorithm(sortingArray: points)
        algorithm.select(mediumIndex: medium, leftIndex: 0, rightIndex: points.count - 1)
        points = algorithm.sortingArray
        
        // Median point becomes the parent.
        let parentNode = KDNode(from: points[left + medium - 1])
        
        let leftNode = generateKDNode(left: left, right: left + medium - 2)
        let rightNode = generateKDNode(left: left + medium, right: right)
        parentNode.update(right: rightNode)
        parentNode.update(left: leftNode)
        
        return parentNode
    }
}
