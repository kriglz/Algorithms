//
//  PointAction.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

struct PointAction {
    
    enum AnimationAction {
        
        case addition
        case removal
    }
    
    let sequenceNumber: Int
    let point: CGPoint
    let action: AnimationAction
    
    init(point: CGPoint, action: AnimationAction, sequenceNumber: Int) {
        self.point = point
        self.action = action
        self.sequenceNumber = sequenceNumber
    }
}
