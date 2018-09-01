//
//  Queue.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/31/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

/// A queue - array type object to store queues.
public struct Queue<T> {
    
    // MARK: - Private properties
    
    /// An array to store queues.
    private var array: [T]
    
    // MARK: - Public properties
    
    /// Returns true if queus list is empty.
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    /// Returns first queue in the list.
    var first: T? {
        return array.first
    }
    
    /// Returns smallest distance `Vertex`.
    var smallest: Vertex? {
        if let vertexArray = array as? [Vertex] {
            return vertexArray.min { (a, b) in
                a.distance < b.distance
            }            
        }
        return nil
    }
    
    // MARK: - Initialization
    
    /// Initializes empty queue list.
    init() {
        array = []
    }
    
    // MARK: - Queue list update
    
    /// Adds an element to the end of the queue.
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    /// Removes first queue object in the list.
    @discardableResult mutating func pop() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
}
