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
    private(set) var parent: KDNode?
    
    private(set) var dimension: Int
    
    private var startPoint: CGPoint?
    private var endPoint: CGPoint?
    
    private var coordinate: CGFloat {
        switch dimension {
        case 1:
            return point.x
        default:
            return point.y
        }
    }
    
    var lineMinPoint: CGPoint? {
        switch dimension {
        case 1:
            if startPoint!.y < endPoint!.y {
                return startPoint
            }
            return endPoint
        default:
            if startPoint!.x < endPoint!.x {
                return startPoint
            }
            return endPoint
        }
    }
    
    var lineMaxPoint: CGPoint? {
        switch dimension {
        case 1:
            if startPoint!.y > endPoint!.y {
                return startPoint
            }
            return endPoint
        default:
            if startPoint!.x > endPoint!.x {
                return startPoint
            }
            return endPoint
        }
    }

    @discardableResult func line(in frame: CGRect) -> Line {
        startPoint = point
        endPoint = point
        
        guard let parent = self.parent else {
            switch dimension {
            case 1:
                startPoint?.y = frame.maxY
                endPoint?.y = frame.minY
            default:
                startPoint?.x = frame.maxX
                endPoint?.x = frame.minX
            }
            
            return Line(startPoint: startPoint ?? point, endPoint: endPoint ?? point)
        }
        
        endPoint = parent.point

        guard let grandparent = parent.parent else {
            switch dimension {
            case 1:
                endPoint?.x = point.x
                
                if endPoint!.y < point.y {
                    startPoint?.y = frame.maxY
                } else {
                    startPoint?.y = frame.minY
                }
            default:
                endPoint?.y = point.y
                
                if endPoint!.x < point.x {
                    startPoint?.x = frame.maxX
                } else {
                    startPoint?.x = frame.minX
                }
            }
            return Line(startPoint: startPoint ?? point, endPoint: endPoint ?? point)
        }
        
        switch dimension {
        case 1:
            endPoint?.x = point.x

            if startPoint!.y < parent.point.y {
                startPoint?.y = grandparent.lineMinPoint?.y ?? point.y
            } else {
                startPoint?.y = grandparent.lineMaxPoint?.y ?? point.y
            }
            
        default:
            endPoint?.y = point.y

            if startPoint!.x < parent.point.x {
                startPoint?.x = grandparent.lineMinPoint?.x ?? point.x
            } else {
                startPoint?.x = grandparent.lineMaxPoint?.x ?? point.x
            }
        }
        
        return Line(startPoint: startPoint ?? point, endPoint: endPoint ?? point)
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
    
    func update(parent: KDNode) {
        self.parent = parent
    }
    
    func isLeft(_ neighborPoint: CGPoint) -> Bool {
        switch dimension {
        case 1:
            return neighborPoint.x < point.x
        default:
            return neighborPoint.y < point.y
        }
    }
    
    func isRight(_ neighborPoint: CGPoint) -> Bool {
        switch dimension {
        case 1:
            return neighborPoint.x > point.x
        default:
            return neighborPoint.y > point.y
        }
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
