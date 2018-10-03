//
//  AugmentedBalancedBinaryNode.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/3/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class AugmentedBalancedBinaryNode {
    
    private(set) var max: CGPoint
    private(set) var min: CGPoint
    
    private(set) var parent: AugmentedBalancedBinaryNode
    
    private(set) var right: AugmentedBalancedBinaryNode? = nil
    private(set) var left: AugmentedBalancedBinaryNode? = nil
    
    private(set) var key: CGPoint
    private(set) var value: CGPoint
    
    private var color = Color.black
    
    enum Color {
        case red
        case black
    }
    
    init(key: CGPoint, value: CGPoint, parent: AugmentedBalancedBinaryNode) {
        self.key = key
        self.value = value
        self.parent = parent
        
        self.min = value
        self.max = value
    }
    
    func update(color: Color) {
        self.color = color
    }
    
    func update(right node: AugmentedBalancedBinaryNode) {
        self.right = node
    }
    
    func update(left node: AugmentedBalancedBinaryNode) {
        self.left = node
    }
    
    func update(parent node: AugmentedBalancedBinaryNode) {
        self.parent = node
    }
    
    func update(value: CGPoint) {
        self.value = value
    }
    
    func update(max value: CGPoint) {
        self.max = value
    }
    
    func update(min value: CGPoint) {
        self.min = value
    }
}

extension AugmentedBalancedBinaryNode: Equatable {
    
    static func == (lhs: AugmentedBalancedBinaryNode, rhs: AugmentedBalancedBinaryNode) -> Bool {
        return lhs.key == rhs.key && lhs.value == rhs.value
    }
}

