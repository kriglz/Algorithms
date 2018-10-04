//
//  LineSweepController.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class LineSweepController {
    
    private(set) var lineSegments = [LineSegment]()
    private let algorithm = LineSweepAlgorithm()
    
    // MARK: - Initialization
    
    init(lineCount: Int, in rect: CGRect) {
        let end = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX), y: CGFloat.random(in: rect.minY...rect.maxY))
        let first = LineSegment(startPoint: .zero, endPoint: end)
        
        let endTwo = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX), y: CGFloat.random(in: rect.minY...rect.maxY))
        let second = LineSegment(startPoint: .zero, endPoint: endTwo)
        
        lineSegments.append(first)
        lineSegments.append(second)
        
//        for _ in 0...lineCount {
//            let start = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX), y: CGFloat.random(in: rect.minY...rect.maxY))
//            let end = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX), y: CGFloat.random(in: rect.minY...rect.maxY))
//            let newLine = LineSegment(startPoint: start, endPoint: end)
//            lineSegments.append(newLine)
//        }
    }
    
    // MARK: - Compute methods
    
    @discardableResult func compute() -> [CGPoint] {
        return algorithm.intersections(for: lineSegments)
    }
}
