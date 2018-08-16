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
}
