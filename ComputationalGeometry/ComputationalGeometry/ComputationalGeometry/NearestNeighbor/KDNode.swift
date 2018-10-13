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
    private(set) var parentPoint: CGPoint?
    
    private(set) var dimension: Int
    
    private var coordinate: CGFloat {
        switch dimension {
        case 1:
            return point.x
        default:
            return point.y
        }
    }
    
    init(dimension: Int, point: CGPoint) {
        self.dimension = dimension
        self.point = point
    }
    
    func update(right node: KDNode) {
        self.right = node
    }
    
    func update(left node: KDNode) {
        self.left = node
    }
    
    func update(parent point: CGPoint) {
        self.parentPoint = point
    }
    
    func isLeft(_ neighborPoint: CGPoint) -> Bool {
        switch dimension {
        case 1:
            if let leftNode = left {
                return neighborPoint.x < leftNode.point.x
            }
        default:
            if let leftNode = left {
                return neighborPoint.y < leftNode.point.y
            }
        }
        
        return false
    }
    
    func isRight(_ neighborPoint: CGPoint) -> Bool {
        switch dimension {
        case 1:
            if let rightNode = right {
                return neighborPoint.x > rightNode.point.x
            }
        default:
            if let rightNode = right {
                return neighborPoint.y > rightNode.point.y
            }
        }
        
        return false
    }
    
    /// In sub-tree rooted at node, see if one of its descendants is closer to rawTarget than min[0].
    func nearestPoint(to target: CGPoint, closerThan distance: CGFloat) -> CGPoint? {
        var closestPoint: CGPoint? = nil
        var minimumDistance = distance
        
        let newDistance = target.distance(to: point)
        if distance > newDistance {
            closestPoint = point
            minimumDistance = newDistance
        }
        
        // Evaluate if perpendicular distance to the axis along which node separates the plane needs to be computed for subtree nodes.
        let perpendicularDistance = abs(coordinate - target.value(for: dimension))
        
        // If perpendicular distance is smaller than the smallest known distance, check both branches.
        if perpendicularDistance < minimumDistance {
            // Return closer one.
            if let rightPoint = self.right?.nearestPoint(to: target, closerThan: minimumDistance), rightPoint.distance(to: target) < minimumDistance {
                closestPoint = rightPoint
            }
            
            if let leftPoint = self.left?.nearestPoint(to: target, closerThan: minimumDistance), leftPoint.distance(to: target) < minimumDistance {
                closestPoint = leftPoint
            }
            
        } else {
            // Determine which branch to go.
            if coordinate > target.value(for: dimension), let leftPoint = self.left?.nearestPoint(to: target, closerThan: minimumDistance), leftPoint.distance(to: target) < minimumDistance {
                closestPoint = leftPoint
                
            } else if coordinate <= target.value(for: dimension), let rightPoint = self.right?.nearestPoint(to: target, closerThan: minimumDistance), rightPoint.distance(to: target) < minimumDistance {
                closestPoint = rightPoint
            }
        }
        
        return closestPoint
    }
}
