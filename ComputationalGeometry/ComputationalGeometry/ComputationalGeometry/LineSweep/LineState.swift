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
        segments.forEach {
            state.insert(lineSegment: $0)
        }
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
    
    // Find node within the state that is the closest neighbor (on the left) to the given event point. Make a line from the given point to the x-intersection on the sweep line. If we find multiple with same point, we have to keep on going to the left. Specifically, if compare returns 0, we keep going to the left.
    func leftNeighbour(for eventPoint: EventPoint) -> AugmentedBalancedBinaryNode? {
        guard var node = state.root else {
            return nil
        }
        
        while node.key == nil {
            if let right = node.right, right.min.pointOnRight(of: eventPoint.point) {
                node = right
            } else if let left = node.left {
                node = left
            }
        }
        
        if let key = node.key, key.pointOnRight(of: eventPoint.point) {
            return node
        }
        
        return nil
    }
    
    // Find segment within the state that is the closest neighbor (on the right) to the given event point. If we find multiple with same point, we have to keep on going to the right. Specifically, if compare returns 0, we keep going to the right.
    func rightNeighbour(for eventPoint: EventPoint) -> AugmentedBalancedBinaryNode? {
        guard var node = state.root else {
            return nil
        }
        
        while node.key == nil {
            if let left = node.left, left.max.pointOnLeft(of: eventPoint.point) {
                node = left
            } else if let right = node.right {
                node = right
            }
        }
        
        if let key = node.key, key.pointOnLeft(of: eventPoint.point) {
            return node
        }

        return nil
    }
    
    // MARK: - Intersection point evaluation

    func determineIntersecting(eventPoint: EventPoint, left: AugmentedBalancedBinaryNode?, right: AugmentedBalancedBinaryNode?) {
        
    }
    
    func deleteSegmentRange(left: AugmentedBalancedBinaryNode?, right: AugmentedBalancedBinaryNode?) {
        
    }
}
