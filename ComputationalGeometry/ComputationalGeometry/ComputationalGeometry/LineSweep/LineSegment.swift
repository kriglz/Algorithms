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
    
    var cgPath: CGPath {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        return path.cgPath
    }
    
    init(startPoint: CGPoint, endPoint: CGPoint) {
        self.start = startPoint
        self.end = endPoint
    }
    
    func intersectionPoint(with lineSegment: LineSegment) -> CGPoint? {
        return .zero
    }
    
    /// Determine if the given point is to the right of the line segment, if we view the line segment from the lower (end) point to the upper (start) point.
    func pointOnRight(of point: CGPoint) -> Bool {
        return false
    }
    
    /// Determine if the given point is to the left of the line segment, if we view the line segment from the lower (end) point to the upper (start) point.
    func pointOnLeft(of point: CGPoint) -> Bool {
        return false
    }
}

extension LineSegment: Equatable {
    
    static func == (lhs: LineSegment, rhs: LineSegment) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}
