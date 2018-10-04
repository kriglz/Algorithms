//
//  AugmentedBalancedTree.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/3/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class AugmentedBalancedTree {
    
    private(set) var root: AugmentedBalancedBinaryNode?
    private var size = 0

    /// Must make sure that interior nodes contain no segments; rather, only the leaves do.
    func insert(lineSegment key: LineSegment) {
        var node = root
        
        if node == nil {
            root = AugmentedBalancedBinaryNode(key: key, value: key, parent: nil)
            size += 1
            return
        }
        
        // Not a root. Find where it should go. Use interior nodes (i.e., whose value is null) to guide the location.
        while node?.value == nil {
            guard let rightNodeValue = node?.right?.min else { break }
            if compare(rightNodeValue, key) > 0 {
                node = node?.left
            } else {
                node = node?.right
            }
        }
        
        // We are now at a leaf node. Convert this node into a sub-tree of size 3 (new parent, with a new child to be sibling to the old one. Note that node could still be the root (a one-node tree).
        let newParent = AugmentedBalancedBinaryNode(key: nil, value: nil, parent: node?.parent)
        let newNode = AugmentedBalancedBinaryNode(key: key, value: key, parent: newParent)

        if node == root {
            root = newParent
        } else if newParent.parent?.left == node {
            newParent.parent?.update(left: newParent)
        } else {
            newParent.parent?.update(right: newParent)
        }
        
        // Re-parent the node we found when looking where to place key.
        node?.update(parent: newParent)

        // Sort out which is left and right child
        if let nodeValue = node?.value, compare(nodeValue, key) > 0, let newRightNode = node {
            // Node is the right children.
            newParent.update(right: newRightNode)
            newParent.update(left: newNode)
        } else if let newLeftNode = node {
            // Node is the left children.
            newParent.update(left: newLeftNode)
            newParent.update(right: newNode)
        }
        
        // Set min/max for the new parent.
        if let newLeftNodeMin = newParent.left?.min {
            newParent.update(min: newLeftNodeMin)
        }
        if let newRightNodeMax = newParent.right?.max {
            newParent.update(max: newRightNodeMax)
        }
        
        // Two nodes have been inserted.
        size += 2;
        
        // Propagate the changes up. Start with newParent.
        if let parentsParent = newParent.parent {
            propagate(node: parentsParent)
        }
        
        // Rebalance, starting with the new parent.
        fixAfterInsertion(node: newParent)
    }
    
    /// Updates min/max segments up the tree.
    func propagate(node: AugmentedBalancedBinaryNode) {
        var nodeToPropagate: AugmentedBalancedBinaryNode? = node
        
        var leftNode: AugmentedBalancedBinaryNode?
        var rightNode: AugmentedBalancedBinaryNode?

        while nodeToPropagate != nil {
            leftNode = node.left
            rightNode = node.right
            
            var updated = false
            
            if node.min != leftNode?.min, let leftNodeMin = leftNode?.min {
                nodeToPropagate?.update(min: leftNodeMin)
                updated = true
            }
            
            if node.max != rightNode?.max, let rightNodeMax = rightNode?.max{
                nodeToPropagate?.update(max: rightNodeMax)
                updated = true
            }
            
            if !updated {
                break
            }
            
            nodeToPropagate = nodeToPropagate?.parent
        }
    }
    
    func fixAfterInsertion(node: AugmentedBalancedBinaryNode) {
        var insertedNode: AugmentedBalancedBinaryNode? = node
        
        node.update(color: .red)
        
        while insertedNode != nil, insertedNode != root, insertedNode?.parent?.color == .red {
            if insertedNode?.parent == insertedNode?.parent?.parent?.right {
                if let rightOfParentsParent = insertedNode?.parent?.parent?.right, rightOfParentsParent.color == .red {
                    insertedNode?.parent?.parent?.update(color: .red)
                    insertedNode?.parent?.update(color: .black)
                    rightOfParentsParent.update(color: .black)
                    
                    insertedNode = insertedNode?.parent?.parent
                } else {
                    if insertedNode == insertedNode?.parent?.right, let insertedNodeParent = insertedNode?.parent {
                        rotateLeft(insertedNodeParent)
                    }
                    
                    insertedNode?.parent?.update(color: .black)
                    insertedNode?.parent?.parent?.update(color: .red)
                    
                    if let parentsParentNode = insertedNode?.parent?.parent {
                        rotateRight(parentsParentNode)
                    }
                }
            } else {
                if let leftOfParentsParent = insertedNode?.parent?.parent?.left, leftOfParentsParent.color == .red {
                    insertedNode?.parent?.update(color: .black)
                    leftOfParentsParent.update(color: .black)
                    insertedNode?.parent?.parent?.update(color: .red)
                    
                    insertedNode = insertedNode?.parent?.parent
                } else {
                    if insertedNode == insertedNode?.parent?.left, let insertedNodeParent = insertedNode?.parent {
                        rotateRight(insertedNodeParent)
                    }
                    
                    insertedNode?.parent?.update(color: .black)
                    insertedNode?.parent?.parent?.update(color: .red)
                    
                    if let parentsParentNode = insertedNode?.parent?.parent {
                        rotateLeft(parentsParentNode)
                    }
                }
            }
        }

        root?.update(color: .red)
        
        propagate(node: node)
    }
    
    func rotateLeft(_ node: AugmentedBalancedBinaryNode) {
        let rightNode = node.right
        
        if let left = node.left {
            node.update(right: left)
        }
        
        if rightNode?.left != nil, let nodeParent = node.parent {
            rightNode?.left?.update(parent: node)
            rightNode?.update(parent: nodeParent)
        }
        
        if node.parent == nil {
            root = rightNode
        } else if node.parent?.left == node, let right = rightNode {
            node.parent?.update(left: right)
        } else if let right = rightNode {
            node.parent?.update(right: right)
            rightNode?.update(left: node)
            node.update(parent: right)
        }

        
        // This only works since we *know* the actual types are
        // subtypes. node was the old parent (p), and it has now become the left
        // child of parent. We must update min/max nodes of the two affected
        // nodes.
        let rotatedNode = node
        let parentNode = node.parent

        
        if let max = rotatedNode.right?.max {
            rotatedNode.update(max: max)
        }
        
        if let min = rotatedNode.left?.min {
            rotatedNode.update(min: min)
        }
        
        if let max = parentNode?.right?.max {
            parentNode?.update(max: max)
        }
        
        if let min = parentNode?.left?.min {
            parentNode?.update(min: min)
        }
    }
    
    func rotateRight(_ node: AugmentedBalancedBinaryNode) {
        let leftNode = node.left
        
        if let right = node.right {
            node.update(left: right)
        }
        
        if leftNode?.right != nil, let nodeParent = node.parent {
            leftNode?.right?.update(parent: node)
            leftNode?.update(parent: nodeParent)
        }
        
        if node.parent == nil {
            root = leftNode
        } else if node.parent?.right == node, let left = leftNode {
            node.parent?.update(right: left)
        } else if let left = leftNode {
            node.parent?.update(left: left)
            leftNode?.update(right: node)
            node.update(parent: left)
        }
        
        
        // This only works since we *know* the actual types are
        // subtypes. node was the old parent (p), and it has now become the right
        // child of parent. We must update min/max nodes of the two affected
        // nodes.
        let rotatedNode = node
        let parentNode = node.parent
        
        
        if let max = rotatedNode.right?.max {
            rotatedNode.update(max: max)
        }
        
        if let min = rotatedNode.left?.min {
            rotatedNode.update(min: min)
        }
        
        if let max = parentNode?.right?.max {
            parentNode?.update(max: max)
        }
        
        if let min = parentNode?.left?.min {
            parentNode?.update(min: min)
        }
    }
    
    func delete(node: AugmentedBalancedBinaryNode) {
        
    }
    
    func compare(_ firstLineSegment: LineSegment, _ secondLineSegment: LineSegment) -> Int {
//        public int compare(ILineSegment o1, ILineSegment o2) {
//            IPoint p = o1.intersection(o2);
//            if (p == null) {
//                // we know that the sweepPt is on o2, so we simply determine
//                // the side that o1 falls upon. We know this since we are only
//                // invoked by the insert method where o1 already exists in the tree
//                // and o2 is the newly added segment.
//                if (o1.pointOnRight(sweepPt)) { return -1; }
//                if (o1.pointOnLeft(sweepPt)) { return +1; }
//                return 0;
//            }
//
//            // Does intersection occur above sweep point? If so, then reverse standard
//            // left-to-right ordering; if intersection is below the sweep line, then
//            // use standard left-to-right ordering
//            if (EventPoint.pointSorter.compare(p, sweepPt) > 0) {
//                if (o1.pointOnRight(o2.getStart())) {
//                    return -1;
//                } else {
//                    return +1;
//                }
//            } else {
//                if (o1.pointOnRight(o2.getEnd())) {
//                    return -1;
//                } else {
//                    return +1;
//                }
//            }
//        }
        return 0
    }
}
