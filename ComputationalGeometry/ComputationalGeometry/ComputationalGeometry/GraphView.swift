//
//  GraphView.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/26/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class GraphView: UIView {

    // MARK: - Initialization
    
    convenience init() {
        self.init(frame: .zero)
        
        self.isUserInteractionEnabled = false
    }
    
    func reset() {
        layer.sublayers?.removeAll()
    }

    // MARK: - Draw methods
    
    func draw(points: [CGPoint], color: CGColor = UIColor.black.cgColor) {
        let pointSize = CGSize(width: 5, height: 5)
        points.forEach { pointPosition in
            let pointRectangle = CGRect(origin: pointPosition, size: pointSize)
            let circle = CGPath(ellipseIn: pointRectangle, transform: nil)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circle
            shapeLayer.fillColor = color
            layer.addSublayer(shapeLayer)
        }
    }
    
    func draw(line points: [CGPoint]) {
        guard points.count > 2 else {
            NSLog("Line has less than two points")
            return
        }
        
        let linePath = UIBezierPath()
        linePath.move(to: points.first!)
        for index in 1..<points.count {
            linePath.addLine(to: points[index])
        }
        linePath.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = linePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        layer.addSublayer(shapeLayer)
    }
    
    func perform(lineDrawingActions: [LineDrawingAction]) {
        for action in lineDrawingActions {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = action.line.cgPath
            shapeLayer.strokeColor = UIColor.red.cgColor
            layer.addSublayer(shapeLayer)
        }
    }
}
