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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Life cycle fucntions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(graphView)
        graphView.constraints(edgesTo: self.view)
        
        convexHullScanButton.setTitle("Convex Hull Scan", for: .normal)
        convexHullScanButton.addTarget(self, action: #selector(startConvexHullScanAction), for: .touchDown)
        
        view.addSubview(convexHullScanButton)
        convexHullScanButton.translatesAutoresizingMaskIntoConstraints = false
        convexHullScanButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        convexHullScanButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
    }
    
    // MARK: - Actionw
    
    @objc private func startConvexHullScanAction(_ sender: UIButton) {
        graphView.reset()
        
        let convexHullRectange = CGRect(x: graphView.frame.size.width / 4,
                                        y: graphView.frame.size.height / 4,
                                        width: graphView.frame.size.width / 2,
                                        height: graphView.frame.size.height / 2)
        
        let controller = ConvexHullScanController(pointCount: 30, in: convexHullRectange)
        graphView.draw(points: controller.points)
        
        controller.compute()
        let actions = controller.convexHullScanActions
        graphView.perform(lineDrawingActions: actions)
    }
}

