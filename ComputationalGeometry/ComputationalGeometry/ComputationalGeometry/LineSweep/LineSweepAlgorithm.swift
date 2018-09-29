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
    
    /// Process events by updating line state and reporting intersections.
    private func handleEventPoint(_ point: EventPoint) {
        // Find segments, if they exist, to left (and right) of event point in line state. Intersections can only happen between neighboring segments. Start with nearest ones because as line sweeps down we will find any other intersections that (for now) we put off.
        let leftSegment = lineState.leftNeighbourSegment(for: point)
        let rightSegment = lineState.rightNeighbourSegment(for: point)

        // Determine intersections from neighbouring line segments and get upper and lower segments for this event point. An intersection exist if > 1 segment is assosiated with event point.
        lineState.determineIntersecting(eventPoint: point, leftSegment: leftSegment, rightSegment: rightSegment)
        
        let interseptions = point.intersectingSegments
        let upperSegments = point.upperEndPointSegments
        let lowerSegments = point.lowerEndPointSegments
        
        if interseptions.count + upperSegments.count + lowerSegments.count > 1 {
            record(eventPoint: point, interseptions: interseptions, upperEndPointSegments: upperSegments, lowerEndPointSegments: lowerSegments)
        }
        
        // Delete everything after left until left's suvessor is right. Then update the sweep point, so insertion will be ordered. Only upper and lower segments are interesting because they are still active.
    }
    
    private func record(eventPoint: EventPoint, interseptions: [LineSegment], upperEndPointSegments: [LineSegment], lowerEndPointSegments: [LineSegment]) {
        // MARK: - TODO
    }
}
