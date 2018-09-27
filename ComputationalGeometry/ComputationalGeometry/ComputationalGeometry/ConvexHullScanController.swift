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
    
    private(set) var points = [CGPoint]()
    
    private let algorithm = ConvexHullScanAlgorithm()
    
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
