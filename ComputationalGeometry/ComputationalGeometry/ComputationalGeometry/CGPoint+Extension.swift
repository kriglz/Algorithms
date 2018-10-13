//
//  CGPoint+Extension.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/10/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

extension CGPoint {

    static func random(in rect: CGRect) -> CGPoint {
        let min = rect.min
        let max = rect.max
        
        let randomX = CGFloat.random(in: min.x...max.x)
        let randomY = CGFloat.random(in: min.y...max.y)
        
        return CGPoint(x: randomX, y: randomY)
    }
    
    func distance(to point: CGPoint) -> CGFloat {
        let xDelta = (self.x - point.x)
        let yDelta = (self.y - point.y)
        return sqrt(pow(xDelta, 2) + pow(yDelta, 2))
    }

    func value(for dimension: Int) -> CGFloat {
        switch dimension {
        case 1:
            return x
        default:
            return y
        }
    }
}
