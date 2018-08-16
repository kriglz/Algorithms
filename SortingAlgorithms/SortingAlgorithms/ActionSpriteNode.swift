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
    
    private var actions: SKAction?
    private var previousActionIndex = 0.0
    
    // MARK: - Animation
    
    func addAction(action: SKAction, actionIndex: Double) {
        let durationIndex = actionIndex - previousActionIndex
        
        if let currentActions = self.actions {
            let sequence = [currentActions, SKAction.wait(forDuration:  ActionSpriteNode.duration * (durationIndex - 1)), action]
            actions = SKAction.sequence(sequence)
            
        } else {
            let sequence = [SKAction.wait(forDuration:  ActionSpriteNode.duration * durationIndex), action]
            actions = SKAction.sequence(sequence)
        }
        
        previousActionIndex = actionIndex
    }
    
    func runActions() {
        guard let action = self.actions else { return }
        self.run(action)
    }
}
