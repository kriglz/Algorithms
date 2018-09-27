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
        let duration = 0.3
        let initialTime = CACurrentMediaTime()
        
        for action in lineDrawingActions {
            switch action.type {
            case .addition:
                addLine(with: action, beginTime: initialTime, duration: duration)
            case .removal:
                continue
            }
        }
    }
    
    private func addLine(with action: LineDrawingAction, beginTime: TimeInterval, duration: Double) {
        let lineLayer = UniqueIdLayer(from: action.line.cgPath, with: action.line.uuid)
        layer.addSublayer(lineLayer)
        
        let drawAnimation = CABasicAnimation(keyPath: "opacity")
        drawAnimation.fillMode = CAMediaTimingFillMode.forwards
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        drawAnimation.beginTime = beginTime + duration * Double(action.index)
        drawAnimation.duration = duration
        drawAnimation.isRemovedOnCompletion = false
        lineLayer.add(drawAnimation, forKey: "lineOpacity")
    }
}

class UniqueIdLayer: CAShapeLayer {
    
    private(set) var uuid: UUID!
    
    convenience init(from path: CGPath, with uuid: UUID) {
        self.init()
        
        self.uuid = uuid
        
        self.path = path
        self.strokeColor = UIColor.red.cgColor
        self.opacity = 0
    }
}
