//
//  LineState.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class LineState {
    
    private(set) var sweepPoint: CGPoint!
    
    func successor(for lineSegment: LineSegment) -> LineSegment {
        return LineSegment(startPoint: .zero, endPoint: .zero)
    }
    
    func predecessor(for lineSegment: LineSegment) -> LineSegment {
        return LineSegment(startPoint: .zero, endPoint: .zero)
    }
    
    func setSweetPoint(_ point: CGPoint) {
        self.sweepPoint = point
    }
    
    func insertSegment(_ segments: [LineSegment]) {
        
    }
    
    func leftNeighbourSegment(for eventPoint: EventPoint) -> LineSegment? {
        return LineSegment(startPoint: .zero, endPoint: .zero)
    }
    
    func rightNeighbourSegment(for eventPoint: EventPoint) -> LineSegment? {
        return LineSegment(startPoint: .zero, endPoint: .zero)
    }
    
    func determineIntersecting(eventPoint: EventPoint, leftSegment: LineSegment?, rightSegment: LineSegment?) {
        
    }
    
    func deleteSegmentRange(left: LineSegment?, right: LineSegment?) {
        
    }
}
