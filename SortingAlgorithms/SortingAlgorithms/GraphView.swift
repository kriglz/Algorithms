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
    
        scene.scaleMode = .fill
        scene.backgroundColor = .clear
        scene.size = CGSize(width: 150.0, height: 150.0)
        
        setupGraph()
    }
    
    // MARK: - SpriteKit setup
    
    /// Sets up graph view with unsorted children.
    func setupGraph() {
        for (index, number) in sortingArray.enumerated() {
            
            let rect = NSRect(x: Double(index) * ActionSpriteNode.width * 1.2 + 30.0,
                              y: 30.0,
                              width: ActionSpriteNode.width,
                              height: ActionSpriteNode.heightMultiplicationConstant * Double(number))
            
            let node = ActionSpriteNode()
            node.anchorPoint.y = 0
            node.color = ActionSpriteNode.defaultColor
            node.position = rect.origin
            node.size = rect.size
            
            node.name = "\(index)"

            scene.addChild(node)
        }
    }
    
    /// Removes all children from the scene.
    func reset() {
        scene.children.forEach { $0.removeFromParent() }
    }
    
    // MARK: - Animation
    
    /// Swap specific elements of the array.
    func swapElements(_ i: Int, _ j: Int, actionIndex: Int, isInActiveRange: Bool = false) {
        guard let iNode = scene.childNode(withName: "\(i)") as? ActionSpriteNode,
            let jNode = scene.childNode(withName: "\(j)") as? ActionSpriteNode else { return }
        
        let deltaIndex = i.distance(to: j)
        let iNodeTranslationLength = CGFloat(ActionSpriteNode.width * 1.2) * CGFloat(deltaIndex)
        let jNodeTranslationLength = -CGFloat(ActionSpriteNode.width * 1.2) * CGFloat(deltaIndex)
        
        iNode.name = "\(j)"
        jNode.name = "\(i)"

        iNode.addMoveByAction(translationLength: iNodeTranslationLength, actionIndex: actionIndex, isInActiveRange: isInActiveRange)
        jNode.addMoveByAction(translationLength: jNodeTranslationLength, actionIndex: actionIndex, isInActiveRange: isInActiveRange)
    }
    
    /// Color active elements of array.
    func colorElements(_ elementIndexes: [Int], actionIndex: Int) {
        scene.children.forEach { child in
            if let node = child as? ActionSpriteNode {
                if let name = node.name, let nodeName = Int(name), elementIndexes.contains(nodeName) {
                    node.addColorAction(isColorized: true, actionIndex: actionIndex)
                } else {
                    node.addColorAction(isColorized: false, actionIndex: actionIndex)
                }
            }
        }
    }
    
    /// Update elements value or/and height.
    func updateElement(_ element: Int, to value: Int, actionIndex: Int) {
        guard let node = scene.childNode(withName: "\(element)") as? ActionSpriteNode else { return }
        node.addHeightChangeAction(height: value, actionIndex: actionIndex)
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
