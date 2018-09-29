//
//  LineState.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class LineState {
    
    func leftNeighbourSegment(for eventPoint: EventPoint) -> LineSegment? {
        return LineSegment(startPoint: .zero, endPoint: .zero)
    }
    
    func rightNeighbourSegment(for eventPoint: EventPoint) -> LineSegment? {
        return LineSegment(startPoint: .zero, endPoint: .zero)
    }
    
    func determineIntersecting(eventPoint: EventPoint, leftSegment: LineSegment?, rightSegment: LineSegment?) {
        
    }
}
