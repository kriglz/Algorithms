//
//  EventPoint.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class EventPoint {
    
    // MARK: - Properties
    
    private(set) var point: CGPoint
    private(set) var upperLineSegments = [LineSegment]()
    private(set) var lowerLineSegments = [LineSegment]()
    private(set) var intersectingLineSegments = [LineSegment]()

    // MARK: - Initialization
    
    init(_ point: CGPoint) {
        self.point = point
    }
    
    // MARK: - Segment managements
    
    func addUpperLineSegment(_ segment: LineSegment) {
        upperLineSegments.append(segment)
    }
    
    func addLowerLineSegment(_ segment: LineSegment) {
        lowerLineSegments.append(segment)
    }
    
    func addIntersectingLineSegment(_ segment: LineSegment) {
        intersectingLineSegments.append(segment)
    }
}

extension EventPoint: Equatable {
    
    static func == (lhs: EventPoint, rhs: EventPoint) -> Bool {
        return lhs.point == rhs.point
    }
}

struct PointSorter {
    
    /// Comparison assumes a horizontal sweep line starting from the top and sweeping down the plane.
    static func compare(_ i: CGPoint, _ j: CGPoint) -> Int {
        let deltaY = i.y - j.y
        let deltaX = i.x - j.x

        // When y coordinate the same, compare x coordinates.
        if deltaX == 0, deltaY == 0 {
            return 0
        }
        
        if deltaY > 0 {
            return -1
        } else if deltaY < 0 {
            return 1
        }
        
        if deltaX > 0 {
            return 1
        } else {
            return -1
        }
    }
}
