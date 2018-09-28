//
//  EventPoint.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class EventPoint: Equatable {
    
    private(set) var point: CGPoint
    private var upperLineSegment: LineSegment?
    private var lowerLineSegment: LineSegment?

    init(_ point: CGPoint) {
        self.point = point
    }
    
    static func == (lhs: EventPoint, rhs: EventPoint) -> Bool {
        return false
    }
    
    func addUpperLineSegment(_ segment: LineSegment) {
        self.upperLineSegment = segment
    }
    
    func addLowerLineSegment(_ segment: LineSegment) {
        self.lowerLineSegment = segment
    }
    
}
