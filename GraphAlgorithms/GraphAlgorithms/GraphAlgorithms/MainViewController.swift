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
    private let dijkstrasStartButton = UIButton(type: UIButtonType.system)
    private let primsStartButton = UIButton(type: UIButtonType.system)

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Life cycle fucntions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        maze.delegate = self
        
        dFStartButton.setTitle("Depth-First", for: .normal)
        dFStartButton.addTarget(self, action: #selector(dFStartAction(_:)), for: .touchDown)
        
        bFStartButton.setTitle("Breadth-First", for: .normal)
        bFStartButton.addTarget(self, action: #selector(bFStartAction(_:)), for: .touchDown)
        
        dijkstrasStartButton.setTitle("Dijkstra's", for: .normal)
        dijkstrasStartButton.addTarget(self, action: #selector(dijkstrasStartAction(_:)), for: .touchDown)

        primsStartButton.setTitle("Prim's", for: .normal)
        primsStartButton.addTarget(self, action: #selector(primsStartAction(_:)), for: .touchDown)
        
        view.addSubview(dFStartButton)
        dFStartButton.translatesAutoresizingMaskIntoConstraints = false
        dFStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        dFStartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(bFStartButton)
        bFStartButton.translatesAutoresizingMaskIntoConstraints = false
        bFStartButton.bottomAnchor.constraint(equalTo: dFStartButton.bottomAnchor).isActive = true
        bFStartButton.trailingAnchor.constraint(equalTo: dFStartButton.leadingAnchor, constant: -20).isActive = true
        
        view.addSubview(bFStartButton)
        bFStartButton.translatesAutoresizingMaskIntoConstraints = false
        bFStartButton.bottomAnchor.constraint(equalTo: dFStartButton.bottomAnchor).isActive = true
        bFStartButton.trailingAnchor.constraint(equalTo: dFStartButton.leadingAnchor, constant: -20).isActive = true
        
        view.addSubview(dijkstrasStartButton)
        dijkstrasStartButton.translatesAutoresizingMaskIntoConstraints = false
        dijkstrasStartButton.bottomAnchor.constraint(equalTo: bFStartButton.bottomAnchor).isActive = true
        dijkstrasStartButton.trailingAnchor.constraint(equalTo: bFStartButton.leadingAnchor, constant: -20).isActive = true
        
        view.addSubview(primsStartButton)
        primsStartButton.translatesAutoresizingMaskIntoConstraints = false
        primsStartButton.bottomAnchor.constraint(equalTo: dFStartButton.topAnchor, constant: -20).isActive = true
        primsStartButton.trailingAnchor.constraint(equalTo: dFStartButton.trailingAnchor).isActive = true
        
        view.addSubview(graphView)
        graphView.constraints(edgesTo: self.view)
    }
    
    // MARK: - Actions
    
    @objc private func dFStartAction(_ sender: UIButton) {
        graphView.reset()
        maze.setupAlgorithm(type: .depthFirst)
        
//        graphView.draw(maze: maze)
//        graphView.drawGrid(columns: maze.columns, rows: maze.rows)
    }
    
    @objc private func bFStartAction(_ sender: UIButton) {
        graphView.reset()
        maze.setupAlgorithm(type: .breadthFirst)
    }
    
    @objc private func dijkstrasStartAction(_ sender: UIButton) {
        graphView.reset()
        maze.setupAlgorithm(type: .dijkstras)
    }
    
    @objc private func primsStartAction(_ sender: UIButton) {
        graphView.reset()
        maze.setupAlgorithm(type: .prims)
    }
}
