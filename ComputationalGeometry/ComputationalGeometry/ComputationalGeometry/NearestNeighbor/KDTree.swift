//
//  KDTree.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/9/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class KDTree {
    
    // MARK: - Properties
    
    weak var delegate: KDTreeDelegate? = nil
    
    private(set) var root: KDNode?
    private var points: [CGPoint]!
    private var maxDimension: Int!
    
    // MARK: - Initialization
    
    /// Recursively construct kd tree using median methods on input point.
    init(maxDimension: Int, from points: [CGPoint]) {
        guard !points.isEmpty else {
            NSLog("0 points.")
            return
        }
        
        self.maxDimension = maxDimension
        self.points = points
    }
    
    func generate() {
        guard let rootNode = generateKDNode(dimension: 1, left: 0, right: points.count - 1) else {
            NSLog("No node available.")
            return
        }
        
        self.root = rootNode
    }
    
    // MARK: - KD node initialization
    
    /// KDNode recursive genration for the KDTree.
    private func generateKDNode(dimension: Int, left: Int, right: Int) -> KDNode? {
        guard right >= left else {
            NSLog("Wrong range - right < left")
            return nil
        }
        
        if right == left {
            let node = KDNode(dimension: dimension, point: points[left])
            delegate?.kdTree(self, didAdd: node)
            return node
        }
        
        // Order the array of points so the mth element will be the median and the elements prior to it will be all <=, though they won't be sorted; similarly, the elements after will be all >=.
        let medium = 1 + (right - left) / 2
        
        let algorithm = QuicksortSortingAlgorithm(sortingArray: points, dimension: dimension)
        algorithm.select(mediumIndex: medium, leftIndex: left, rightIndex: right)
        points = algorithm.sortingArray
        
        // Median point becomes the parent.
        let parentNode = KDNode(dimension: dimension, point: points[left + medium - 1])
        delegate?.kdTree(self, didAdd: parentNode)

        // Update the next dimesnion or reset back to 1.
        
        var updatedDimension = dimension + 1
        if updatedDimension > maxDimension {
            updatedDimension = 1
        }
        
        if let rightNode = generateKDNode(dimension: updatedDimension, left: left + medium, right: right) {
            rightNode.update(parent: parentNode)
            parentNode.update(right: rightNode)
        }
        
        if let leftNode = generateKDNode(dimension: updatedDimension, left: left, right: left + medium - 2) {
            leftNode.update(parent: parentNode)
            parentNode.update(left: leftNode)
        }
        
        return parentNode
    }
    
    // MARK: - Nearest node finding
    
    private func parent(for point: CGPoint) -> KDNode? {
        guard let root = self.root else {
            NSLog("No parent detected.")
            return nil
        }
        
        // Go through tree iteratively, varying from vertical to horizontal.
        var parent: KDNode? = root
        
        while true {
            // If point is left node, search that branch.
            if parent!.isLeft(point), let leftNode = parent?.left {
                parent = leftNode
                
            // If point is right node, search that branch.
            } else if parent!.isRight(point), let rightNode = parent?.right {
                parent = rightNode
                
            // Last node, return parent.
            } else {
                return parent
            }
        }
    }
    
    func nearestNeighbor(for point: CGPoint) -> CGPoint? {
        guard let root = root else {
            NSLog("No neighbors detected.")
            return nil
        }
        
        var smallestDistance = CGFloat.infinity
        var nearestNeighborPoint: CGPoint?
        
        // Find parent node to which neighbor would have been inserted. This is our best shot at locating the closest point. Compute best distance.
        if let parentNodePoint = parent(for: point)?.point {
            smallestDistance = point.distance(to: parentNodePoint)
            nearestNeighborPoint = parentNodePoint
        }
        
        // Check all rectangles that potentially overlap this smallest distance. If better is found, return it.
        if let closerPoint = root.nearestPoint(to: point, closerThan: smallestDistance) {
            nearestNeighborPoint = closerPoint
        }
        
        return nearestNeighborPoint
    }
}

protocol KDTreeDelegate: class {
    
    func kdTree(_ tree: KDTree, didAdd node: KDNode)
}
