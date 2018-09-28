//
//  ConvexHull.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ConvexHull {
    
    // MARK: - Parameters
    
    private(set) var points = [CGPoint]()
    
    var hullPointsCount: Int {
        return points.count
    }
    
    var hasThree: Bool {
        return hullPointsCount >= 3
    }
    
    /*
     
     Determinant needs to be computed to determine the right turn of 3 points.
     
     Three points L(i-1), L(i), and the candidate point p form a right turn if cp is negative.
     If cp == 0, three points are collinear, or if cp > 0, the three points determine the left turn.
     
     Matrix ->
     
     1    L(i-1).x  L(i-1).y
     1    L(i).x    L(i).y
     1    p.x       p.y
     
     Cross product ->
     
     cp = (L(i).x - L(i - 1).x) * (p.y - L(i - 1).y) - (L(i).y - L(i - 1).y) * (p.x - L(i - 1).x)
 
    */
    var areLastThreeNonRight: Bool {
        let last = points[hullPointsCount - 1]
        let secondLast = points[hullPointsCount - 2]
        let thirdLast = points[hullPointsCount - 3]

        let cp = (secondLast.x - thirdLast.x) * (last.y - thirdLast.y) - (secondLast.y - thirdLast.y) * (last.x - thirdLast.x)
        
        if cp >= 0 {
            return true
        }
        
        return false
    }
    
    // MARK: - Initialization
    
    init(_ zeroPoint: CGPoint, _ firstPoint: CGPoint) {
        points.append(contentsOf: [zeroPoint, firstPoint])
    }
    
    // MARK: - Hull points update
    
    func add(point: CGPoint) {
        points.append(point)
    }
    
    func removeMiddleOfLastThree() {
        points.remove(at: hullPointsCount - 2)
    }
    
    func mergePoints(with lowerHull: ConvexHull) -> [CGPoint] {
        var hullPoints = self.points
        
        let lowerHullPoints = lowerHull.points.dropFirst().dropLast()
        hullPoints.append(contentsOf: lowerHullPoints)
        
        return hullPoints
    }
}

