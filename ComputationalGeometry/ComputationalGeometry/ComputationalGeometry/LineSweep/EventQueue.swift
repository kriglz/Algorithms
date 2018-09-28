//
//  EventQueue.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

/// A queue - array type object to store queues.
class EventQueue {
    
    // MARK: - Private properties
    
    /// An array to store queues.
    private var array: [EventPoint]
    
    // MARK: - Public properties
    
    /// Returns true if queus list is empty.
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    /// Returns first queue in the list.
    var first: EventPoint? {
        return array.first
    }
    
    /// Returns queue list as an array of `Vertex` type object.
    var list: [EventPoint] {
        return array
    }
    
    /// Returns smallest y (x if y is equal) coordinate `EventPoint` and removes it from the queue list.
    var smallest: EventPoint? {
        let smallest = array.min { (a, b) in
            if a.point.y == b.point.y {
                return a.point.x < b.point.x
            }
            
            return a.point.y < b.point.y
        }
        
        if smallest != nil {
            pop(eventPoint: smallest!)
        }
        
        return smallest
    }
    
    // MARK: - Initialization
    
    /// Initializes empty queue list.
    init() {
        array = []
    }
    
    // MARK: - Queue list update
    
    /// Adds an element to the end of the queue.
    ///
    /// - Parameters:
    ///     - element: An element to be added to the queue.
    func push(_ element: EventPoint) {
        array.append(element)
    }
    
    /// Removes first queue object in the queue list.
    @discardableResult func pop() -> EventPoint? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    /// Removes specified queue object in the list.
    ///
    /// - Parameters:
    ///     - vertex: An object of a type `Vertex` to be removed from the queue list.
    func pop(eventPoint: EventPoint) {
        if !isEmpty, let index = array.index(where: { $0 == eventPoint }) {
            array.remove(at: index)
        }
    }
    
    func event(for eventPoint: EventPoint) -> EventPoint? {
        return array.first(where: { $0 == eventPoint })
    }
}
