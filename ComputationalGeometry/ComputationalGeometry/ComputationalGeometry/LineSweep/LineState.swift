//
//  LineState.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/28/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class LineState {
    
    // MARK: - Properties

    private(set) var sweepPoint: CGPoint!
    private var state = AugmentedBalancedTree()
    
    // MARK: - Sweep point update
    
    func setSweetPoint(_ point: CGPoint) {
        self.sweepPoint = point
    }
    
    // MARK: - Line segment update
    
    func insertSegment(_ segments: [LineSegment]) {

    }
    
    func successor(for node: AugmentedBalancedBinaryNode) -> AugmentedBalancedBinaryNode? {
        var successor = node
        
        // If we are the right-child of a node, must go back.
        while successor != state.root, successor == successor.parent.right {
            successor = successor.parent
        }
        
        // Now we have reached a node by whose parent we are not the right. If we are indeed at the root, then no successor.
        if successor == state.root {
            return nil
        }
        
        // Otherwise go to the right, and find the left-most child. This node is the successor.
        guard let right = successor.parent.right else {
            return nil
        }
        
        successor = right
        
        while successor.left != nil {
            successor = successor.left!
        }
        
        return successor
    }
    
    func predecessor(for node: AugmentedBalancedBinaryNode) -> AugmentedBalancedBinaryNode? {
        var predecessor = node
        
        // If we are the left-child of a node, must go back.
        while predecessor != state.root, predecessor == predecessor.parent.left {
            predecessor = predecessor.parent
        }
        
        // Now we have reached a node by whose parent we are not the right. If we are indeed at the root, then no successor.
        if predecessor == state.root {
            return nil
        }
        
        // Otherwise go to the left, and find the right-most child. This node is the pred
        guard let left = predecessor.parent.left else {
            return nil
        }
        
        predecessor = left
        
        while predecessor.right != nil {
            predecessor = predecessor.right!
        }
        
        return predecessor
    }
    
    func leftNeighbour(for eventPoint: EventPoint) -> AugmentedBalancedBinaryNode? {
        return nil
    }
    
    func rightNeighbour(for eventPoint: EventPoint) -> AugmentedBalancedBinaryNode? {
        return nil
    }
    
    // MARK: - Intersection point evaluation

    func determineIntersecting(eventPoint: EventPoint, left: AugmentedBalancedBinaryNode?, right: AugmentedBalancedBinaryNode?) {
        
    }
    
    func deleteSegmentRange(left: AugmentedBalancedBinaryNode?, right: AugmentedBalancedBinaryNode?) {
        
    }
}
