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
    
    private let maze = Maze(columns: 4, rows: 4)

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Life cycle fucntions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(maze.view())
    }
}
