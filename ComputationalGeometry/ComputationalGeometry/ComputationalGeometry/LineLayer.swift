//
//  LineLayer.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class LineLayer: CAShapeLayer {
    
    private(set) var uuid: String!
    
    convenience init(from path: CGPath, color: CGColor = UIColor.white.cgColor, opacity: Float = 0, with uuid: String) {
        self.init()
        
        self.uuid = uuid
        
        self.path = path
        self.strokeColor = color
        self.lineWidth = 3
        self.opacity = opacity
    }
}
