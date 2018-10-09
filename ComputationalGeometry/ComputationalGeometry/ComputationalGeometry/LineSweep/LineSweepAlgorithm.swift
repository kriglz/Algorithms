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
    
    /// Interception point list.
    var interceptions = [CGPoint]()
    
    /// Computes the intersection of all segments from the array of segments.
    func intersections(for lineSegments: [LineSegment]) -> [CGPoint] {
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
            let smallestEventPoint = queue.smallest!
            handleEventPoint(smallestEventPoint)
        }
        
        // Return the report of all computed intersections.
        return interceptions
    }
    
    /// Process events by updating line state and reporting intersections.
    private func handleEventPoint(_ eventPoint: EventPoint) {
        // Find segments, if they exist, to left (and right) of event point in line state. Intersections can only happen between neighboring segments. Start with nearest ones because as line sweeps down we will find any other intersections that (for now) we put off.
        let left = lineState.leftNeighbour(for: eventPoint)
        let right = lineState.rightNeighbour(for: eventPoint)

        // Determine intersections from neighbouring line segments and get upper and lower segments for this event point. An intersection exist if > 1 segment is assosiated with event point.
        lineState.determineIntersecting(eventPoint: eventPoint, left: left, right: right)
        
        let interseptions = eventPoint.intersectingLineSegments
        let upperSegments = eventPoint.upperLineSegments
        let lowerSegments = eventPoint.lowerLineSegments
        
        if interseptions.count + upperSegments.count + lowerSegments.count > 1 {
            record(eventPoint: eventPoint, interseptions: interseptions, upperEndPointSegments: upperSegments, lowerEndPointSegments: lowerSegments)
        }
        
        // Delete everything after left until left's sucessor is right. Then update the sweep point, so insertion will be ordered. Only upper and intersection segments are interesting because they are still active.
        lineState.deleteRange(left: left, right: right)
        lineState.setSweetPoint(eventPoint.point)
        
        var update = false
        
        if !upperSegments.isEmpty {
            lineState.insertSegment(upperSegments)
            update = true
        }
        
        if !interseptions.isEmpty {
            lineState.insertSegment(interseptions)
            update = true
        }
    
        // If state shows no intersection at this event point, see if left and right segments intersect below sweep line, and update event queue properly. Otherwise, if there was an intersection, the order of segments between left and right have switched so we check two specific ranges, namely, left and its (new) successor, and right and its (new) predecessor.
        if !update, let left = left, let right = right {
            updateQueue(left: left, right: right)
            return
        }
        
        if let left = left, let right = lineState.successor(for: left) {
            updateQueue(left: left, right: right)
        }
        
        if let right = right, let left = lineState.predecessor(for: right) {
            updateQueue(left: left, right: right)
        }
    }
    
    private func record(eventPoint: EventPoint, interseptions: [LineSegment], upperEndPointSegments: [LineSegment], lowerEndPointSegments: [LineSegment]) {
        self.interceptions.append(eventPoint.point)
    }
    
    /// Any intersections below sweep line are inserted as event points.
    private func updateQueue(left: AugmentedBalancedBinaryNode, right: AugmentedBalancedBinaryNode) {
        // Determine if the two neighboring line segments intersect. Make sure that new intersection point is below the sweep line and not added twice.
        guard let rightKey = right.key, let point = left.key?.intersectionPoint(with: rightKey), point.y > lineState.sweepPoint.y else {
            NSLog("Segments do not intersect.")
            return
        }
      
        let newEventPoint = EventPoint(point)
        let oldEvent = queue.event(for: newEventPoint)
        if oldEvent == nil {
            queue.push(newEventPoint)
        }
        
        print(newEventPoint)
    }
}
