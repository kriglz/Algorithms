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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Life cycle fucntions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(graphView)
        graphView.constraints(edgesTo: self.view)
    }
}

