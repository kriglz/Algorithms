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
        
        var lines = [Line]()
        
        func requestLineAddition(fromPoint: CGPoint, toPoint: CGPoint) {
            let line = Line(startPoint: fromPoint, endPoint: toPoint)
            delegate?.convexHullScanAlgorithm(self, didAddLine: line)
            lines.append(line)
        }
        
        func requestRemovalOfMiddleOfLastThreePointLines() {
            delegate?.convexHullScanAlgorithm(self, didRemoveLine: lines.last!)
            lines.removeLast()
            
            delegate?.convexHullScanAlgorithm(self, didRemoveLine: lines.last!)
            lines.removeLast()
        }
        
        // Compute upper hull by starting with leftmost two points.
        let upperHull = ConvexHull(sortedPoints[0], sortedPoints[1])
        requestLineAddition(fromPoint: sortedPoints[0], toPoint: sortedPoints[1])
        for index in 2..<count {
            upperHull.add(point: sortedPoints[index])
            requestLineAddition(fromPoint: upperHull.points[upperHull.hullPointsCount - 2], toPoint: upperHull.points[upperHull.hullPointsCount - 1])
            
            while upperHull.hasThree, upperHull.areLastThreeNonRight {
                upperHull.removeMiddleOfLastThree()
                requestRemovalOfMiddleOfLastThreePointLines()
                requestLineAddition(fromPoint: upperHull.points[upperHull.hullPointsCount - 2], toPoint: upperHull.points[upperHull.hullPointsCount - 1])
            }
        }
        
        // Compute lower hull by starting with rightmost two points
        let lowerHull = ConvexHull(sortedPoints[count - 1], sortedPoints[count - 2])
        requestLineAddition(fromPoint: sortedPoints[count - 1], toPoint: sortedPoints[count - 2])
        for index in (0...(count - 3)).reversed() {
            lowerHull.add(point: sortedPoints[index])
            requestLineAddition(fromPoint: lowerHull.points[lowerHull.hullPointsCount - 2], toPoint: lowerHull.points[lowerHull.hullPointsCount - 1])

            while lowerHull.hasThree, lowerHull.areLastThreeNonRight {
                lowerHull.removeMiddleOfLastThree()
                requestRemovalOfMiddleOfLastThreePointLines()
                requestLineAddition(fromPoint: lowerHull.points[lowerHull.hullPointsCount - 2], toPoint: lowerHull.points[lowerHull.hullPointsCount - 1])
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
