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
    
    private let maze = Maze(columns: 12, rows: 20)
    private let graphView = GraphView()

    private let startButton = UIButton(type: UIButtonType.system)
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Life cycle fucntions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        maze.delegate = self
        
        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(self, action: #selector(startAction(_:)), for: UIControlEvents.touchDown)
        
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true        
        
        view.addSubview(graphView)
        graphView.constraints(edgesTo: self.view)
    }
    
    // MARK: - Actions
    
    @objc private func startAction(_ sender: UIButton) {
        graphView.reset()
        maze.setup()
    }
}

extension MainViewController: MazeDelegate {
    
    // MARK: - MazeDelegate implementation
    
    func maze(_ maze: Maze, didUpdate vertex: Vertex, actionIndex: Int) {
        graphView.addVertexLine(vertex: vertex, in: maze, actionIndex: actionIndex)
    }
}
