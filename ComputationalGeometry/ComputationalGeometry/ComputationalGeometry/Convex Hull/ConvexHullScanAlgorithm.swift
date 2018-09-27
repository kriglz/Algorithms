//
//  ConvexHullScanAlgorithm.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/26/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ConvexHullScanAlgorithm {
    
    // MARK: - Properties
    
    weak var delegate: ConvexHullScanAlgorithmDelegate? = nil
    
    // MARK: - Compute method
    
    @discardableResult func compute(points: [CGPoint]) -> [CGPoint] {
        let count = points.count

        guard count > 3 else {
            NSLog("received <= 3 points.")
            return points
        }
        
        // Sort by x coordinate, if ==, by y coordinate.
        let sortedPoints = points.sorted { (firstPoint, secondPoint) -> Bool in
            if firstPoint.x == secondPoint.x {
                return firstPoint.y < secondPoint.y
            }
            
            return firstPoint.x < secondPoint.x
        }
        
        // Compute upper hull by starting with leftmost two points.
        let upperHull = ConexHull(sortedPoints[0], sortedPoints[1])
        for index in 2..<count {
            upperHull.add(point: sortedPoints[index])
            delegate?.convexHullScanAlgorithm(self, didAddPoint: sortedPoints[index])
            
            while upperHull.hasThree, upperHull.areLastThreeNonRight {
                upperHull.removeMiddleOfLastThree()
                delegate?.convexHullScanAlgorithmDidRemoveMiddleOfTheLastThreePoint(self)
            }
        }
        
        // Compute lower hull by starting with rightmost two points
        let lowerHull = ConexHull(sortedPoints[count - 1], sortedPoints[count - 2])
        for index in (0...(count - 3)).reversed() {
            lowerHull.add(point: sortedPoints[index])
            delegate?.convexHullScanAlgorithm(self, didAddPoint: sortedPoints[index])

            while lowerHull.hasThree, lowerHull.areLastThreeNonRight {
                lowerHull.removeMiddleOfLastThree()
                delegate?.convexHullScanAlgorithmDidRemoveMiddleOfTheLastThreePoint(self)
            }
        }
        
        // Remove duplicate end points when combining.
        let hullConexPoints = upperHull.mergePoints(with: lowerHull)
        
        return hullConexPoints
    }
}

protocol ConvexHullScanAlgorithmDelegate: class {
    
    func convexHullScanAlgorithm(_ algorithm: ConvexHullScanAlgorithm, didAddPoint point: CGPoint)
    
    func convexHullScanAlgorithmDidRemoveMiddleOfTheLastThreePoint(_ algorithm: ConvexHullScanAlgorithm)
}
