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
        
        func requestLineAddition(fromPoint: CGPoint, toPoint: CGPoint) {
            let line = Line(startPoint: fromPoint, endPoint: toPoint)
            delegate?.convexHullScanAlgorithm(self, didAddLine: line)
        }
        
        func requestRemovalOfMiddleOfLastThreePointLines() {
            let fromLine = Line(startPoint: sortedPoints[count - 2], endPoint: sortedPoints[count - 1])
            delegate?.convexHullScanAlgorithm(self, didRemoveLine: fromLine)
            
            let toLine = Line(startPoint: sortedPoints[count - 3], endPoint: sortedPoints[count - 2])
            delegate?.convexHullScanAlgorithm(self, didRemoveLine: toLine)
        }
        
        // Compute upper hull by starting with leftmost two points.
        let upperHull = ConexHull(sortedPoints[0], sortedPoints[1])
        requestLineAddition(fromPoint: sortedPoints[0], toPoint: sortedPoints[1])
        for index in 2..<count {
            upperHull.add(point: sortedPoints[index])
            requestLineAddition(fromPoint: sortedPoints[index - 1], toPoint: sortedPoints[index])
            
            while upperHull.hasThree, upperHull.areLastThreeNonRight {
                upperHull.removeMiddleOfLastThree()
                requestRemovalOfMiddleOfLastThreePointLines()
            }
        }
        
        // Compute lower hull by starting with rightmost two points
        let lowerHull = ConexHull(sortedPoints[count - 1], sortedPoints[count - 2])
        requestLineAddition(fromPoint: sortedPoints[count - 1], toPoint: sortedPoints[count - 2])
        for index in (0...(count - 3)).reversed() {
            lowerHull.add(point: sortedPoints[index])
            requestLineAddition(fromPoint: sortedPoints[index], toPoint: sortedPoints[index + 1])

            while lowerHull.hasThree, lowerHull.areLastThreeNonRight {
                lowerHull.removeMiddleOfLastThree()
                requestRemovalOfMiddleOfLastThreePointLines()
            }
        }
        
        // Remove duplicate end points when combining.
        let hullConexPoints = upperHull.mergePoints(with: lowerHull)
        
        return hullConexPoints
    }
}

protocol ConvexHullScanAlgorithmDelegate: class {
    
    func convexHullScanAlgorithm(_ algorithm: ConvexHullScanAlgorithm, didAddLine line: Line)
    
    func convexHullScanAlgorithm(_ algorithm: ConvexHullScanAlgorithm, didRemoveLine line: Line)
}
