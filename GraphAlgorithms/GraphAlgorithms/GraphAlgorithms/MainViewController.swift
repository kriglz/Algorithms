//
//  MainViewController.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let maze = Maze(columns: 15, rows: 15)
    private(set) var graphView = GraphView()

    private let dFStartButton = UIButton(type: UIButtonType.system)
    private let bFStartButton = UIButton(type: UIButtonType.system)

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Life cycle fucntions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        maze.delegate = self
        
        dFStartButton.setTitle("Depth-First", for: .normal)
        dFStartButton.addTarget(self, action: #selector(dFStartAction(_:)), for: UIControlEvents.touchDown)
        
        bFStartButton.setTitle("Breadth-First", for: .normal)
        bFStartButton.addTarget(self, action: #selector(bFStartAction(_:)), for: UIControlEvents.touchDown)
        
        view.addSubview(dFStartButton)
        dFStartButton.translatesAutoresizingMaskIntoConstraints = false
        dFStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        dFStartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(bFStartButton)
        bFStartButton.translatesAutoresizingMaskIntoConstraints = false
        bFStartButton.bottomAnchor.constraint(equalTo: dFStartButton.bottomAnchor).isActive = true
        bFStartButton.trailingAnchor.constraint(equalTo: dFStartButton.leadingAnchor, constant: -20).isActive = true
        
        view.addSubview(graphView)
        graphView.constraints(edgesTo: self.view)
    }
    
    // MARK: - Actions
    
    @objc private func dFStartAction(_ sender: UIButton) {
        graphView.reset()
        maze.setupDF()
        
//        graphView.draw(maze: maze)
//        graphView.drawGrid(columns: maze.columns, rows: maze.rows)
    }
    
    @objc private func bFStartAction(_ sender: UIButton) {
        graphView.reset()
        maze.setupBF()
    }
}
