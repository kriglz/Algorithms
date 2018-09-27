//
//  ConvexHullScanController.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/26/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ConvexHullScanController {
    
    // MARK: - Properties
    
    var convexHullScanActions: [PointAction] {
        return pointActionBuffer
    }
    
    private(set) var points = [CGPoint]()
    
    private let algorithm = ConvexHullScanAlgorithm()
    
    fileprivate var pointActionBuffer = [PointAction]()
    fileprivate var actionIndex = 0
    
    // MARK: - Initialization
    
    init(pointCount: Int, in rect: CGRect) {
        for _ in 0...pointCount {
            let newPoint = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX), y: CGFloat.random(in: rect.minY...rect.maxY))
            points.append(newPoint)
        }
    }
    
    // MARK: - Compute methods
    
    @discardableResult func compute() -> [CGPoint] {
        return algorithm.compute(points: points)
    }
}

extension ConvexHullScanController: ConvexHullScanAlgorithmDelegate {
    
    func convexHullScanAlgorithm(_ algorithm: ConvexHullScanAlgorithm, didAddPoint point: CGPoint) {
        let action = PointAction(point: point, action: .addition, sequenceNumber: actionIndex)
        pointActionBuffer.append(action)
        actionIndex += 1
    }
    
    func convexHullScanAlgorithmDidRemoveMiddleOfTheLastThreePoint(_ algorithm: ConvexHullScanAlgorithm) {
        let action = PointAction(point: points[points.count - 2], action: .removal, sequenceNumber: actionIndex)
        pointActionBuffer.append(action)
        actionIndex += 1
    }
}
