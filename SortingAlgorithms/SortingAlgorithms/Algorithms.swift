//
//  Algorithms.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/16/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

class Algorithms {
    
    /// Compares numbers A and B
    ///
    /// Returns 1 if A > B
    ///
    /// Returns 0 if A < B or A = B
    ///
    /// - Parameters:
    ///     - numberA: First comparable number
    ///     - numberB: Second comparable number
    func compare(numberA: Int, numberB: Int) -> Int {
        if numberA > numberB {
            return 1
        }
        return 0
    }
    
    /// Return random pivot index of specified range.
    ///
    /// - Parameters:
    ///     - lowerBound: Lower bound of the range.
    ///     - upperBound: Upper bound of the range.
    func randomIndex(lowerBound: Int, upperBound: Int) -> Int {
        let range: Range = lowerBound..<upperBound
        return range.random
    }
}

enum SortingAlgorithm {
    case insert
    case median
}
