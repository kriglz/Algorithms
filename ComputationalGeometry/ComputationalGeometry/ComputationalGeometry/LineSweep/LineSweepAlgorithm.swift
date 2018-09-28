//
//  LineSweepAlgorithm.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class LineSweepAlgorithm {
    
    /// Stores line sweep state.
    let lineState = LineState()
    
    /// Stores event queue.
    var queue = EventQueue()
    
    /// Computes the intersection of all segments from the array of segments.
    func intersections(for lineSegments: [LineSegment]) {
        // Construct queue from segments. Ensure that only unique points appear by combining all information as it is discovered.
        for segment in lineSegments {
            var eventPoint = EventPoint(segment.start)
            
            let oldStartEventPoint = queue.event(for: eventPoint)
            if oldStartEventPoint == nil {
                queue.push(eventPoint)
            } else {
                eventPoint = oldStartEventPoint!
            }
            
            // Add upper line segment to event point (the object in the queue).
            eventPoint.addUpperLineSegment(segment)
            
            eventPoint = EventPoint(segment.end)
            let oldEndEventPoint = queue.event(for: eventPoint)
            if oldEndEventPoint == nil {
                queue.push(eventPoint)
            } else {
                eventPoint = oldEndEventPoint!
            }
            
            // Add lower line segment to event point (the object in the queue).
            eventPoint.addLowerLineSegment(segment)
        }
        
        // Sweet top to bottom, processing each event point in the queue.
        while !queue.isEmpty {
            let point = queue.smallest!
            handleEventPoint(point)
        }
        
        // Return the report of all computed intersections.
    }
    
    private func handleEventPoint(_ point: EventPoint) {
        
    }
    
}
