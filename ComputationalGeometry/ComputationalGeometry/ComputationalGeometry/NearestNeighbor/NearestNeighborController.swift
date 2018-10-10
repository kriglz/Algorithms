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
    
    private(set) var points = [CGPoint]()
    
    // MARK: - Initialization
    
    init(pointCount: Int, in rect: CGRect) {
        for _ in 1...pointCount {
            let newPoint = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX), y: CGFloat.random(in: rect.minY...rect.maxY))
            points.append(newPoint)
        }        
    }
    
}
