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
