//
//  Algorithms.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/16/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

struct Algorithms {
    
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
    
    /// Returns the random pivot index of specified range.
    ///
    /// - Parameters:
    ///     - lowerBound: Lower bound of the range.
    ///     - upperBound: Upper bound of the range.
    func randomIndex(lowerBound: Int, upperBound: Int) -> Int {
        let range: Range = lowerBound..<upperBound
        return range.random
    }
    
    /// Returns the pivot index of specified range by using median value of 3 random indexes.
    ///
    /// - Parameters:
    ///     - lowerBound: Lower bound of the range.
    ///     - upperBound: Upper bound of the range.
    func mediumOfThree(lowerBound: Int, upperBound: Int) -> Int {
        var randomElements: [Int] = []
        for _ in 0..<3 {
            randomElements.append(randomIndex(lowerBound: lowerBound, upperBound: upperBound))
        }
        randomElements.sort()
        return randomElements[1]
    }
}

enum SortingAlgorithm {
    
    case insert
    case median
    case quicksort
}
