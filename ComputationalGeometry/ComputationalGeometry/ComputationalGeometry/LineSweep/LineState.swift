//
//  LineState.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class LineState {
    
    // MARK: - Properties

    private(set) var sweepPoint: CGPoint!
    private var states = [LineSegment]()
    
    // MARK: - Sweep point update
    
    func setSweetPoint(_ point: CGPoint) {
        self.sweepPoint = point
    }
    
    // MARK: - Line segment update
    
    func insertSegment(_ segments: [LineSegment]) {
        states.append(contentsOf: segments)
    }
    
    func successor(for lineSegment: LineSegment) -> LineSegment? {
        if let lineSegmentIndex = states.firstIndex(where: { $0 == lineSegment }), (0..<states.count).contains(lineSegmentIndex + 1) {
            return states[lineSegmentIndex + 1]
        }
        return nil
    }
    
    func predecessor(for lineSegment: LineSegment) -> LineSegment? {
        if let lineSegmentIndex = states.firstIndex(where: { $0 == lineSegment }), (0..<states.count).contains(lineSegmentIndex - 1) {
            return states[lineSegmentIndex - 1]
        }
        return nil
    }
    
    func leftNeighbourSegment(for eventPoint: EventPoint) -> LineSegment? {
        return LineSegment(startPoint: .zero, endPoint: .zero)
    }
    
    func rightNeighbourSegment(for eventPoint: EventPoint) -> LineSegment? {
        return LineSegment(startPoint: .zero, endPoint: .zero)
    }
    
    // MARK: - Intersection point evaluation

    func determineIntersecting(eventPoint: EventPoint, leftSegment: LineSegment?, rightSegment: LineSegment?) {
        
    }
    
    func deleteSegmentRange(left: LineSegment?, right: LineSegment?) {
        
    }
}
