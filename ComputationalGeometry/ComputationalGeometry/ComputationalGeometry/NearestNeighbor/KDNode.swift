//
//  KDNode.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/9/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class KDNode {
    
    private(set) var point: CGPoint
    private(set) var left: KDNode?
    private(set) var right: KDNode?
    
    init(from point: CGPoint) {
        self.point = point
    }
    
    func update(right node: KDNode) {
        self.right = node
    }
    
    func update(left node: KDNode) {
        self.left = node
    }
    
    func isLeft(of neighborPoint: CGPoint) -> Bool {
        return neighborPoint.x > point.x
    }
    
    /// In sub-tree rooted at node, see if one of its descendants is closer to rawTarget than min[0].
    func nearestPoint(to target: CGPoint, closerThan distance: CGFloat) -> CGPoint? {
        var closestPoint: CGPoint? = nil
        var minimumDistance = distance
        
        let newDistance = target.distance(to: point)
        if distance > newDistance {
            closestPoint = point
            minimumDistance = distance - newDistance
        }
        
        // Evaluate if perpendicular distance to the axis along which node separates the plane needs to be computed for subtree nodes.
        let perpendicularDistance = abs(point.x - target.x)
        
        // If perpendicular distance is smaller than the smallest known distance, check both branches.
        if perpendicularDistance < minimumDistance {
            // Return closer one.
            if let rightPoint = self.right?.nearestPoint(to: point, closerThan: minimumDistance) {
                closestPoint = rightPoint
            }
            
            if let leftPoint = self.left?.nearestPoint(to: point, closerThan: minimumDistance) {
                closestPoint = leftPoint
            }
            
        } else {
            // Determine which branch to go.
            if point.x > target.x, let leftPoint = self.left?.nearestPoint(to: target, closerThan: minimumDistance) {
                closestPoint = leftPoint
            }
            
            if point.x <= target.x, let rightPoint = self.right?.nearestPoint(to: target, closerThan: minimumDistance) {
                closestPoint = rightPoint
            }
        }
        
        return closestPoint
    }
}
