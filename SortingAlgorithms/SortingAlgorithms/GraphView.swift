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
    
    /// Sets up graph view with unsorted children.
    func setupGraph() {
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
    
    /// Removes all children from the scene.
    func reset() {
        scene.children.forEach { $0.removeFromParent() }
    }
    
    // MARK: - Animation
    
    /// Swap specific elements of the array.
    func swapElements(_ i: Int, _ j: Int, deltaIndex: Int, actionIndex: Int) {
        guard let iNode = scene.childNode(withName: "\(i)") as? ActionSpriteNode,
            let jNode = scene.childNode(withName: "\(j)") as? ActionSpriteNode else { return }
        
        let iNodeTranslationLength = CGFloat(-ActionSpriteNode.width * 1.2) * CGFloat(deltaIndex)
        let jNodeTranslationLength = CGFloat(ActionSpriteNode.width * 1.2) * CGFloat(deltaIndex)
        
        iNode.addMoveByAction(translationLength: iNodeTranslationLength, actionIndex: actionIndex)
        jNode.addMoveByAction(translationLength: jNodeTranslationLength, actionIndex: actionIndex)
    }
    
    /// Color active elements of array.
    func colorElements(_ elements: [Int], actionIndex: Int) {
        scene.children.forEach { child in
            if let node = child as? ActionSpriteNode {
                if let name = node.name, let nodeName = Int(name), elements.contains(nodeName) {
                    node.addColorAction(isColorized: true, actionIndex: actionIndex)
                } else {
                    node.addColorAction(isColorized: false, actionIndex: actionIndex)
                }
            }
        }
    }
    
    /// Performs the sorting animation.
    func runAnimation() {
        scene.children.forEach { child in
            if let node = child as? ActionSpriteNode {
                node.runActions()
            }
        }
    }
}
