//
//  LineSegment.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class LineSegment {
 
    private(set) var start: CGPoint
    private(set) var end: CGPoint
    
    init(startPoint: CGPoint, endPoint: CGPoint) {
        self.start = startPoint
        self.end = endPoint
    }
    
    func intersectionPoint(with lineSegment: LineSegment) -> CGPoint? {
        return .zero
    }
}
