//
//  CGRect+Extension.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/12/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

extension CGRect {
    
    var min: CGPoint {
        return CGPoint(x: origin.x, y: origin.y)
    }
    
    var max: CGPoint {
        return CGPoint(x: origin.x + size.width, y: origin.y + size.height)
    }
}
