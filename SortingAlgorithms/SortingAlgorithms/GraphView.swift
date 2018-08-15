//
//  GraphView.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/15/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa
import SpriteKit

class GraphView: NSView {
    
    // MARK: - Properties

    private var sortingArray: [Int] = []
 
    private let spriteKitView = SKView()
    private let scene = SKScene()
    
    private let nodeWidth = 5
    
    // MARK: - Initialization
    
    convenience init(array: [Int]) {
        self.init(frame: .zero)
        
        sortingArray = array
        
        self.addSubview(spriteKitView)
        spriteKitView.constraints(edgesTo: self)
        spriteKitView.allowsTransparency = true

        spriteKitView.presentScene(scene)
    
        scene.scaleMode = .aspectFill
        scene.backgroundColor = .clear
        
        scene.size = CGSize(width: 300.0, height: 200.0)
        
        setupGraph()
    }
    
    // MARK: - SpriteKit setup
    
    private func setupGraph() {
        for (index, number) in sortingArray.enumerated() {
            
            let rect = NSRect(x: Double(index * nodeWidth) * 1.2 + 30.0,
                              y: 30.0,
                              width: Double(nodeWidth),
                              height: 5 * Double(number))
            
            let node = ActionSpriteNode()
            node.anchorPoint.y = 0
            node.color = .white
            node.position = rect.origin
            node.size = rect.size
            
            node.name = "\(index)"

            scene.addChild(node)
        }
    }
    
    // MARK: - Animation
    
    func swapAt(_ i: Int, j: Int) {
        let iChild = scene.children.first { node in
            if node.name == "\(i)" {
                return true
            }
            return false
        }
        
        let jChild = scene.children.first { node in
            if node.name == "\(j)" {
                return true
            }
            return false
        }
        
        guard let iNode = iChild as? ActionSpriteNode, let jNode = jChild as? ActionSpriteNode else { return }
        
        let iNodePosition = iNode.position
        
        iNode.addAction(action: SKAction.move(to: jNode.position, duration: 1))
        jNode.addAction(action: SKAction.move(to: iNodePosition, duration: 1))
    }
    
    func performAnimation() {
        scene.children.forEach { child in
            if let node = child as? ActionSpriteNode {
                node.runActions()
            }
        }
    }
}

class ActionSpriteNode: SKSpriteNode {
    
    private var actions: SKAction?
    
    func addAction(action: SKAction) {
        if let currentActions = self.actions {
            let sequence = [currentActions, action]
            actions = SKAction.sequence(sequence)
        } else {
            actions = action
        }
    }
    
    func runActions() {
        guard let action = self.actions else { return }
        self.run(action)
    }
}
