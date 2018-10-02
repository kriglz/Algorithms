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
    
    func draw(points: [CGPoint], color: CGColor = UIColor.darkGray.cgColor) {
        let pointSize = CGSize(width: 9, height: 9)
        points.forEach { pointPosition in
            let pointRectangle = CGRect(origin: CGPoint(x: pointPosition.x - pointSize.width / 2, y: pointPosition.y - pointSize.height / 2), size: pointSize)
            let circle = CGPath(ellipseIn: pointRectangle, transform: nil)
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circle
            shapeLayer.fillColor = color
            layer.addSublayer(shapeLayer)
        }
    }
    
    func draw(lineFrom points: [CGPoint]) {
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
    
    func draw(lines: [LineSegment]) {
        for line in lines {
            let lineLayer = CAShapeLayer()
            lineLayer.path = line.cgPath
            lineLayer.strokeColor = UIColor.white.cgColor
            lineLayer.lineWidth = 1
            layer.addSublayer(lineLayer)
        }
    }
    
    // MARK: - Drawing animation actions
    
    func perform(lineDrawingActions: [LineDrawingAction]) {
        let duration = 0.3
        let initialTime = CACurrentMediaTime()
        
        for action in lineDrawingActions {
            switch action.type {
            case .addition:
                addLine(with: action, beginTime: initialTime, duration: duration)
            case .removal:
                removeLine(with: action, beginTime: initialTime, duration: duration)
            }
        }
    }
    
    private func addLine(with action: LineDrawingAction, beginTime: TimeInterval, duration: Double) {
        let lineLayer = LineLayer(from: action.line.cgPath, with: action.line.uuid)
        layer.addSublayer(lineLayer)
        
        let drawAnimation = CABasicAnimation(keyPath: "opacity")
        drawAnimation.fillMode = CAMediaTimingFillMode.forwards
        drawAnimation.toValue = 1
        drawAnimation.beginTime = beginTime + duration * Double(action.index)
        drawAnimation.duration = duration
        drawAnimation.isRemovedOnCompletion = false
        lineLayer.add(drawAnimation, forKey: "showLine")
    }
    
    private func removeLine(with action: LineDrawingAction, beginTime: TimeInterval, duration: Double) {
        let lineToRemove = layer.sublayers?.first { layer in
            if let lineLayer = layer as? LineLayer, lineLayer.uuid == action.line.uuid {
                return true
            }
            return false
        }
        
        guard lineToRemove != nil else {
            NSLog("Asking to remove non existing line")
            return
        }
        
        let drawAnimation = CABasicAnimation(keyPath: "opacity")
        drawAnimation.fillMode = CAMediaTimingFillMode.forwards
        drawAnimation.toValue = 0
        drawAnimation.beginTime = beginTime + duration * Double(action.index)
        drawAnimation.duration = duration / 2
        drawAnimation.isRemovedOnCompletion = false
        lineToRemove!.add(drawAnimation, forKey: "hideLine")
    }
}
