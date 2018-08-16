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
            
            let rect = NSRect(x: Double(index) * ActionSpriteNode.width * 1.2 + 30.0,
                              y: 30.0,
                              width: ActionSpriteNode.width,
                              height: 5 * Double(number))
            
            let node = ActionSpriteNode()
            node.anchorPoint.y = 0
            node.color = .white
            node.position = rect.origin
            node.size = rect.size
            
            node.name = "\(number)"

            scene.addChild(node)
        }
    }
    
    // MARK: - Animation
    
    func swapElements(_ i: Int, _ j: Int, actionIndex: Double) {
        guard let iNode = scene.childNode(withName: "\(i)") as? ActionSpriteNode,
            let jNode = scene.childNode(withName: "\(j)") as? ActionSpriteNode else { return }
        
        let iNodeAction = SKAction.moveBy(x: CGFloat(-ActionSpriteNode.width * 1.2), y: 0, duration: ActionSpriteNode.duration)
        let jNodeAction = SKAction.moveBy(x: CGFloat(ActionSpriteNode.width * 1.2), y: 0, duration: ActionSpriteNode.duration)
        
        iNode.addAction(action: iNodeAction, actionIndex: actionIndex)
        jNode.addAction(action: jNodeAction, actionIndex: actionIndex)
    }
    
    func performAnimation() {
        scene.children.forEach { child in
            if let node = child as? ActionSpriteNode {
                node.runActions()
            }
        }
    }
}
