//
//  Range+Extension.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/17/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

extension Range {
    
    /// Returns random `Int` number of specific range.
    var random: Int {
        get {
            let mini = UInt32(lowerBound as! Int)
            let maxi = UInt32(upperBound as! Int)
            
            return Int(mini + arc4random_uniform(maxi - mini))
        }
    }
}
