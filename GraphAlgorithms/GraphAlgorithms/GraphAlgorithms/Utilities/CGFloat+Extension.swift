//
//  CGFloat+Extension.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/30/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

extension CGFloat {
    
    /// Returns random number from the range.
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random * (max - min) + min
    }
    
    /// Returns a random floating point number between 0.0 and 1.0.
    public static var random: CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
}
