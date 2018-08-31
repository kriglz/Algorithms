//
//  Direction.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

/// Direction type to the new vertex.
///
/// List of possible directions:
/// - up
/// - down
/// - left
/// - right
enum Direction: Int {
    
    case up = 1
    case down = 2
    case left = 3
    case right = 4
    
    /// Returns a random direction from all possible directions.
    static var random: Direction {
        let randomInt = (Int(arc4random_uniform(4)) + 1);
        return Direction.init(rawValue: randomInt) ?? .up
    }
}
