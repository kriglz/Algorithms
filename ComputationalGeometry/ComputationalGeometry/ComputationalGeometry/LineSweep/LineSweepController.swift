//
//  LineSweepController.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class LineSweepController {
    
    private(set) var lines = [Line]()
    
    // MARK: - Initialization
    
    init(lineCount: Int, in rect: CGRect) {
        for _ in 0...lineCount {
            let start = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX), y: CGFloat.random(in: rect.minY...rect.maxY))
            let end = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX), y: CGFloat.random(in: rect.minY...rect.maxY))
            let newLine = Line(startPoint: start, endPoint: end)
            lines.append(newLine)
        }
    }
}
