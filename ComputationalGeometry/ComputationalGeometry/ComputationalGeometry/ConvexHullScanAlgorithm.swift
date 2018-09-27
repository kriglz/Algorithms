//
//  ConvexHullScanAlgorithm.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/26/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ConvexHullScanAlgorithm {
    
    @discardableResult func compute(points: [CGPoint]) -> [CGPoint] {
        let count = points.count

        guard count > 3 else {
            NSLog("received <= 3 points.")
            return points
        }
        
        // Sort by x coordinate, if ==, by y coordinate.
        let sorted = points.sorted { (firstPoint, secondPoint) -> Bool in
            if firstPoint.x == secondPoint.x {
                return firstPoint.y < secondPoint.y
            }
            
            return firstPoint.x < secondPoint.x
        }
        
        
        
        return sorted
    }
}
