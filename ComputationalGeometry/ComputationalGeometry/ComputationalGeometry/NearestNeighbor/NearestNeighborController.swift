//
//  NearestNeighborController.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/9/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class NearestNeighborController {
    
    // MARK: - Properties
    
    private(set) var points: [CGPoint]
    private let algorithm: NearestNeighborAlgorithm
    private let frame: CGRect
    
    var treeActionBuffer: [LineDrawingAction] {
        guard !algorithm.treeActionBuffer.isEmpty else {
            return []
        }
        
        var actions = [LineDrawingAction]()
        
        for action in algorithm.treeActionBuffer {
            var startPoint = action.node.point
            var endPoint = action.node.parentPoint

            if endPoint == nil {
                endPoint = startPoint
                switch action.node.dimension {
                case 1:
                    startPoint.y = frame.minY
                    endPoint?.y = frame.maxY
                default:
                    startPoint.x = frame.minX
                    endPoint?.x = frame.maxX
                }
            } else {
                switch action.node.dimension {
                case 1:
//                    if endPoint!.x < action.node.point.x {
//                        startPoint.y = frame.minY
//                    } else {
//                        startPoint.y = frame.maxY
//                    }
                    endPoint?.x = action.node.point.x
                default:
                    endPoint?.y = action.node.point.y
                }
            }
            
            let line = Line(startPoint: startPoint, endPoint: endPoint!)
            let lineAction = LineDrawingAction(line: line, type: .addition, index: action.index)
            actions.append(lineAction)
        }
        
        return actions
    }
    
    // MARK: - Initialization
    
    init(pointCount: Int, in rect: CGRect) {
        self.frame = rect
        points = []
        
        for _ in 1...pointCount {
            let newPoint = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX), y: CGFloat.random(in: rect.minY...rect.maxY))
            points.append(newPoint)
        }
        
        algorithm = NearestNeighborAlgorithm(points: points)
    }
    
    // MARK: - Compute methods
    
    func nearestNeighbor(for point: CGPoint) -> CGPoint? {
        return algorithm.nearestNeighbor(for: point)
    }
}
