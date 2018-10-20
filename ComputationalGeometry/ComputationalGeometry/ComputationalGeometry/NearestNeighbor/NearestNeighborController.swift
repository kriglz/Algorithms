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
            let line = action.node.line(in: frame)
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
        
//        for x in 1...pointCount / 2 {
//            let xx = x * 20
//            for y in 1...pointCount / 2 {
//                let yy = y * 20
//                let newPoint = CGPoint(x: yy, y: xx)
//                points.append(newPoint)
//            }
//        }
        
        algorithm = NearestNeighborAlgorithm(points: points)
    }
    
    // MARK: - Compute methods
    
    func nearestNeighbor(for point: CGPoint) -> CGPoint? {
        return algorithm.nearestNeighbor(for: point)
    }
}
