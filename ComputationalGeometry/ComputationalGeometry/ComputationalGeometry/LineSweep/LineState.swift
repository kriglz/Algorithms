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

    private(set) var sweepPoint: CGPoint! {
        didSet {
            self.state.update(comparator: compare)
        }
    }
    
    private var state: AugmentedBalancedTree!
    
    /// Return minimum node in state tree (or null if state tree is empty).
    var minimumInTree: AugmentedBalancedBinaryNode? {
        guard var node = state.root else {
            NSLog("minimumInTree = nil. Root is nil.")
            return nil
        }
        
        while node.left != nil {
            node = node.left!
        }
        
        return node
    }
    
    init() {
        self.state = AugmentedBalancedTree(comparator: compare)
    }
    
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
    
    // MARK: - Neighbor node finding
    
    /// Return successor leaf in the tree. We can be guaranteed to be called with a LEAF node, since interior nodes are only guiding the process.
    func successor(for node: AugmentedBalancedBinaryNode) -> AugmentedBalancedBinaryNode? {
        var successor = node
        
        // If we are the right-child of a node, must go back.
        while successor != state.root, successor == successor.parent?.right, successor.parent != nil {
            successor = successor.parent!
        }
        
        // Now we have reached a node by whose parent we are not the right. If we are indeed at the root, then no successor.
        if successor == state.root {
            return nil
        }
        
        // Otherwise go to the right, and find the left-most child. This node is the successor.
        guard let right = successor.parent?.right else {
            return nil
        }
        
        successor = right
        
        while successor.left != nil {
            successor = successor.left!
        }
        
        return successor
    }
    
    /// Return predecessor leaf in the tree. We can be guaranteed to be called with a LEAF node, since interior nodes are only guiding the process.
    func predecessor(for node: AugmentedBalancedBinaryNode) -> AugmentedBalancedBinaryNode? {
        var predecessor = node
        
        // If we are the left-child of a node, must go back.
        while predecessor != state.root, predecessor == predecessor.parent?.left, predecessor.parent != nil {
            predecessor = predecessor.parent!
        }
        
        // Now we have reached a node by whose parent we are not the right. If we are indeed at the root, then no successor.
        if predecessor == state.root {
            return nil
        }
        
        // Otherwise go to the left, and find the right-most child. This node is the pred
        guard let left = predecessor.parent?.left else {
            return nil
        }
        
        predecessor = left
        
        while predecessor.right != nil {
            predecessor = predecessor.right!
        }
        
        return predecessor
    }
    
    /// Find node within the state that is the closest neighbor (on the left) to the given event point. Make a line from the given point to the x-intersection on the sweep line. If we find multiple with same point, we have to keep on going to the left. Specifically, if compare returns 0, we keep going to the left.
    func leftNeighbour(for eventPoint: EventPoint) -> AugmentedBalancedBinaryNode? {
        guard var node = state.root else {
            return nil
        }
        
        while node.key == nil {
            if let right = node.right, let rightValue = right.min, rightValue.pointOnRight(of: eventPoint.point) {
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
    
    /// Find segment within the state that is the closest neighbor (on the right) to the given event point. If we find multiple with same point, we have to keep on going to the right. Specifically, if compare returns 0, we keep going to the right.
    func rightNeighbour(for eventPoint: EventPoint) -> AugmentedBalancedBinaryNode? {
        guard var node = state.root else {
            return nil
        }
        
        while node.key == nil {
            if let left = node.left, let leftValue = left.max, leftValue.pointOnLeft(of: eventPoint.point) {
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
    
    func compare(_ firstLineSegment: LineSegment, _ secondLineSegment: LineSegment) -> Int {
        let intersectionPoint = firstLineSegment.intersectionPoint(with: secondLineSegment)
        
        if intersectionPoint == nil {
            // We know that the sweepPt is on o2, so we simply determine the side that o1 falls upon. We know this since we are only invoked by the insert method where o1 already exists in the tree and o2 is the newly added segment.
            if firstLineSegment.pointOnRight(of: sweepPoint) {
                return -1
            }
            
            if firstLineSegment.pointOnLeft(of: sweepPoint) {
                return 1
            }
            
            return 0
        }
        
        // Does intersection occur above sweep point? If so, then reverse standard
        // left-to-right ordering; if intersection is below the sweep line, then
        // use standard left-to-right ordering
        if let point = intersectionPoint, PointSorter.compare(point, sweepPoint) > 0 {
            if firstLineSegment.pointOnRight(of: secondLineSegment.start) {
                return -1
            } else {
                return 1
            }
        } else {
            if firstLineSegment.pointOnRight(of: secondLineSegment.end) {
                return -1
            } else {
                return 1
            }
        }
    }
    
    // MARK: - Intersection point evaluation

    /// Only intersections are allowed with neighboring segments in the line state. Thus we check from the successor of left, right through (but not including) right. These left and right are the first segments that match.
    func determineIntersecting(eventPoint: EventPoint, left: AugmentedBalancedBinaryNode?, right: AugmentedBalancedBinaryNode?) {
        guard sweepPoint != nil else {
            return
        }
        
        var leftNode = left
        
        if let left = left {
            leftNode = successor(for: left)
        } else {
            leftNode = minimumInTree
        }
        
        while leftNode != right {
            // Can ignore start and end because those intersection types are already handled.
            if let leftLineSegment = leftNode?.key, !leftLineSegment.start.equalTo(eventPoint.point), !leftLineSegment.end.equalTo(eventPoint.point) {
                eventPoint.addIntersectingLineSegment(leftLineSegment)
            }
            
            if leftNode != nil {
                leftNode = successor(for: leftNode!)
            } else {
                return
            }
        }
    }
    
    func deleteRange(left: AugmentedBalancedBinaryNode?, right: AugmentedBalancedBinaryNode?) {
        var nodeToDelete: AugmentedBalancedBinaryNode?
        
        if let leftNode = left {
            nodeToDelete = successor(for: leftNode)
        } else {
            nodeToDelete = minimumInTree
        }
        
        if right == nil {
            if let nodeToDelete = nodeToDelete {
                state.delete(node: nodeToDelete)
            }
            return
        }
        
        while nodeToDelete != right {
            if let nodeToDelete = nodeToDelete {
                state.delete(node: nodeToDelete)
            }
            
            // Note: We always go back to the original spot, since we want to drain everything in between. Note that 'left' never leaves the tree.
            if let leftNode = left {
                nodeToDelete = successor(for: leftNode)
            } else {
                nodeToDelete = minimumInTree
            }
        }
    }
}
