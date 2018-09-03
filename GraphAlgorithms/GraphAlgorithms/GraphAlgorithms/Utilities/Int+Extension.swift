//
//  Int+Extension.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 9/2/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Foundation

extension Int {
    
    /// Returns random number from the range.
    static func random(min: Int, max: Int) -> Int {
        return Int(Float(arc4random()) / 0xFFFFFFFF * Float(max - min)) + min
    }
}
