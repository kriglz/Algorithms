//
//  ConexHull.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class ConexHull {
    
    // MARK: - Parameters
    
    private(set) var points = [CGPoint]()
    
    var hullPointsCount: Int {
        return points.count
    }
    
    var hasThree: Bool {
        return hullPointsCount >= 3
    }
    
    var areLastThreeNonRight: Bool {
        // TODO, do determinant calc.
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
    
    func mergePoints(with lowerHull: ConexHull) -> [CGPoint] {
        var hullPoints = self.points
        
        let lowerHullPoints = lowerHull.points.dropFirst().dropLast()
        hullPoints.append(contentsOf: lowerHullPoints)
        
        return hullPoints
    }
}

