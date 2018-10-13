//
//  ViewController.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/26/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Properties
    
    private let graphView = GraphView()
    
    private let convexHullScanButton = UIButton(type: .system)
    private let lineSweepButton = UIButton(type: .system)
    private let nearestNeighborButton = UIButton(type: .system)

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Life cycle fucntions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        
        view.addSubview(graphView)
        graphView.constraints(edgesTo: self.view)
        
        convexHullScanButton.setTitle("Convex Hull Scan", for: .normal)
        convexHullScanButton.addTarget(self, action: #selector(startConvexHullScanAction), for: .touchDown)
        
        lineSweepButton.setTitle("Line Sweep", for: .normal)
        lineSweepButton.addTarget(self, action: #selector(startLineSweepAction), for: .touchDown)
        
        nearestNeighborButton.setTitle("Nearest Neighbor", for: .normal)
        nearestNeighborButton.addTarget(self, action: #selector(startNearestNeighborAction), for: .touchDown)

        view.addSubview(convexHullScanButton)
        convexHullScanButton.translatesAutoresizingMaskIntoConstraints = false
        convexHullScanButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        convexHullScanButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(lineSweepButton)
        lineSweepButton.translatesAutoresizingMaskIntoConstraints = false
        lineSweepButton.bottomAnchor.constraint(equalTo: convexHullScanButton.topAnchor, constant: -20).isActive = true
        lineSweepButton.trailingAnchor.constraint(equalTo: convexHullScanButton.trailingAnchor).isActive = true
        
        view.addSubview(nearestNeighborButton)
        nearestNeighborButton.translatesAutoresizingMaskIntoConstraints = false
        nearestNeighborButton.bottomAnchor.constraint(equalTo: lineSweepButton.topAnchor, constant: -20).isActive = true
        nearestNeighborButton.trailingAnchor.constraint(equalTo: convexHullScanButton.trailingAnchor).isActive = true
    }
    
    // MARK: - Actionw
    
    @objc private func startConvexHullScanAction(_ sender: UIButton) {
        graphView.reset()

        let convexHullRectange = CGRect(x: graphView.frame.size.width / 4,
                                        y: graphView.frame.size.height / 4,
                                        width: graphView.frame.size.width / 2,
                                        height: graphView.frame.size.height / 2)
        
        let controller = ConvexHullScanController(pointCount: 15, in: convexHullRectange)
        graphView.draw(points: controller.points)
        
        controller.compute()
        let actions = controller.convexHullScanActions
        graphView.perform(lineDrawingActions: actions)
    }
    
    @objc private func startLineSweepAction(_ sender: UIButton) {
        graphView.reset()
        
        let controller = LineSweepController(lineCount: 15, in: view.frame)
        graphView.draw(lines: controller.lineSegments)
        
        let inersectionPoints = controller.compute()

//        print(controller.lineSegments)
        print(inersectionPoints)
    }
    
    @objc private func startNearestNeighborAction(_ sender: UIButton) {
        graphView.reset()

        let rect = CGRect(x: graphView.frame.size.width / 4,
                          y: graphView.frame.size.height / 4,
                          width: graphView.frame.size.width / 2,
                          height: graphView.frame.size.height / 2)
        
        let frameView = UIView(frame: rect)
        frameView.layer.borderColor = UIColor.red.cgColor
        frameView.layer.borderWidth = 1
        view.addSubview(frameView)
        
        let controller = NearestNeighborController(pointCount: 7, in: rect)
        graphView.draw(points: controller.points)

        let targetPoint = CGPoint.random(in: rect)
        graphView.draw(points: [targetPoint], color: UIColor.white.cgColor, pointSize: CGSize(width: 19, height: 19))
        
        var posibleNeighbour = targetPoint
        var posibleNeighbourDistance = CGFloat.infinity
        for point in controller.points {
            let distance = point.distance(to: targetPoint)
            if distance < posibleNeighbourDistance {
                posibleNeighbourDistance = distance
                posibleNeighbour = point
            }
        }
        
        if let nearest = controller.nearestNeighbor(for: targetPoint) {
            graphView.draw(points: [nearest], color: UIColor.blue.cgColor, pointSize: CGSize(width: 19, height: 19))
        }
        
        graphView.draw(points: [posibleNeighbour], color: UIColor.white.cgColor, pointSize: CGSize(width: 2, height: 2))
        graphView.perform(lineDrawingActions: controller.treeActionBuffer)
    }
}
