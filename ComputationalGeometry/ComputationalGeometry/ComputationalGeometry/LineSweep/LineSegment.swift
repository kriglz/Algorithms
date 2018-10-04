//
//  LineSegment.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class LineSegment {
 
    var cgPath: CGPath {
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        return path.cgPath
    }
    
    private(set) var start: CGPoint
    private(set) var end: CGPoint
    
    private var sign: Int = 0
    private var slope: CGFloat = 0
    
    private var isHorizontal: Bool {
        return start.y == end.y
    }
    
    private var isVertical: Bool {
        return start.x == end.x
    }

    init(startPoint: CGPoint, endPoint: CGPoint) {
        self.start = startPoint
        self.end = endPoint
        
        // Evaluate sign and slope.
        evaluateSlopeAndSign()
    }
    
    /// Evaluates sign and slope of the line segment.
    private func evaluateSlopeAndSign() {
        if start.x == end.x {
            slope = CGFloat.nan
            sign = 1
        } else {
            slope = (end.y - start.y) / (end.x - start.x)
            
            if slope < 0 {
                sign = -1 
            } else {
                // Even for 0/horizontal case.
                sign = 1
            }
        }
        
    }
    
    func intersectionPoint(with lineSegment: LineSegment) -> CGPoint? {
        return .zero
    }
    
    /**
     * Given the line segment in its reverse-directed orientation (from lower to upper
     * point), determine if point p is to the right of the line, as you head from lower
     * to upper.
     *
     * If it is exactly on the line, then we return false.
     *
     * Note that we use the following inverted equation for lines to make the determination.
     * The equation can easily be confirmed, but care must be taken based upon the sign
     * of the slope (since we are dividing by m).
     *
     *                 (y2 - y1)
     *    0 = y - y1 - --------- (x - x1)
     *                 (x2 - x1)
     *
     * Since this operation is SO COMMON, we use a standard trick to remove the IF statements.
     * Specifically, if m is positive, then we check if res &lt; 0 but if m is negative, then we
     * check if -res &lt; 0. Thus we also need to store the SIGN of the slope with each segment.
     */
    
    /// Determine if the given point is to the right of the line segment, if we view the line segment from the lower (end) point to the upper (start) point.
    func pointOnRight(of point: CGPoint) -> Bool {
        if isVertical {
            return point.x > self.start.x
        } else if isHorizontal {
            return point.y > self.start.y
        }
        
        let res = point.y - end.y - slope * (point.x - end.x)
        return res * CGFloat(sign) < 0
    }
    
    /**
     * Given the line segment in its reverse-directed orientation (from lower to upper point), determine
     * if point p is to the left of the line, as you head from lower to upper
     *
     * If it is exactly on the line, then we return false.
     *
     * See {@link #pointOnRight(IPoint)} for the mathematical explanation
     * for these equations, as well as importance of sign.
     */
    
    /// Determine if the given point is to the left of the line segment, if we view the line segment from the lower (end) point to the upper (start) point.
    func pointOnLeft(of point: CGPoint) -> Bool {
        if isVertical {
            return start.x > point.x
        } else if isHorizontal {
            return start.y > point.y
        }
        
        let res = point.y - end.y - slope * (point.x - end.x)
        return res * CGFloat(sign) > 0
    }
}

extension LineSegment: Equatable {
    
    static func == (lhs: LineSegment, rhs: LineSegment) -> Bool {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}
