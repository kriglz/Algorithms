//
//  ActionSpriteNode.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/15/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import SpriteKit

class ActionSpriteNode: SKSpriteNode {
    
    // MARK: - Properties
    
    static let duration = 0.2
    static let width = 5.0

    private var moveActions: SKAction?
    private var colorActions: SKAction?
    
    private var previousMoveActionIndex = 0
    private var previousColorActionIndex = 0

    // MARK: - Animation
    
    func addMoveByAction(translationLength: CGFloat, actionIndex: Int) {
        let action =  SKAction.moveBy(x: translationLength, y: 0, duration: ActionSpriteNode.duration)
        
        let durationIndex = actionIndex - previousMoveActionIndex
        
        if let currentActions = self.moveActions {
            let sequence = [currentActions, SKAction.wait(forDuration: ActionSpriteNode.duration * Double(durationIndex - 1)), action]
            moveActions = SKAction.sequence(sequence)
        } else {
            let sequence = [SKAction.wait(forDuration: ActionSpriteNode.duration * Double(durationIndex)), action]
            moveActions = SKAction.sequence(sequence)
        }
        
        previousMoveActionIndex = actionIndex
    }

    func addColorAction(isColorized: Bool, actionIndex: Int) {
        let action = SKAction.colorize(with: isColorized ? .gray : .white, colorBlendFactor: 1, duration: ActionSpriteNode.duration)

        let durationIndex = actionIndex - previousColorActionIndex

        if let currentActions = self.colorActions {
            let sequence = [currentActions, SKAction.wait(forDuration: ActionSpriteNode.duration * Double(durationIndex - 1)), action]
            colorActions = SKAction.sequence(sequence)
        } else {
            let sequence = [SKAction.wait(forDuration: ActionSpriteNode.duration * Double(durationIndex)), action]
            colorActions = SKAction.sequence(sequence)
        }
        
        previousColorActionIndex = actionIndex
    }
    
    func runActions() {
        guard var actions = self.moveActions else { return }
        
        if let colorActions = self.colorActions {
            actions = SKAction.group([actions, colorActions])
        }
        
        run(actions) { [weak self] in
            self?.previousMoveActionIndex = 0
            self?.previousColorActionIndex = 0
            
            self?.moveActions = nil
            self?.colorActions = nil
            
            self?.color = .white
        }
    }
}
