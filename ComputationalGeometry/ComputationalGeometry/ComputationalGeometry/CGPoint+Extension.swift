//
//  CGPoint+Extension.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/10/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

extension CGPoint {
    
    func distance(to point: CGPoint) -> CGFloat {
        let xDelta = (self.x - point.x)
        let yDelta = (self.y - point.y)
        return sqrt(pow(xDelta, 2) + pow(yDelta, 2))
    }
}
