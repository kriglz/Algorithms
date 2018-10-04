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

    private var comparator: (LineSegment, LineSegment) -> Int
    
    init(comparator: @escaping (LineSegment, LineSegment) -> Int) {
        self.comparator = comparator
    }
    
    func update(comparator: @escaping (LineSegment, LineSegment) -> Int) {
        self.comparator = comparator
    }
    
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
            if comparator(rightNodeValue, key) > 0 {
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
        if let nodeValue = node?.value, comparator(nodeValue, key) > 0, let newRightNode = node {
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
    
    /**
     * Because we are using leaf nodes only to store the segments, we can be
     * guaranteed that the node is going to be a leaf node. If this is
     * not the case, then we will encounter problems.
     *
     * We can casually throw away interior nodes of the tree, since they
     * don't actually store anything.
     */
    
    func delete(node: AugmentedBalancedBinaryNode) {
        // If node is the root, it is also a leaf, which means it is the last one in the tree.
        if node == root {
            root = nil
            size -= 1
            return
        }
        
        // Note that node's children all still have proper min/max set, so we must go to node's current grandparent, to ensure that min/max is properly dealt with.
        let nodeToDelete = node
        let parentToDelete = node.parent
        var otherSiblings: AugmentedBalancedBinaryNode?
        
        if nodeToDelete == nodeToDelete.parent?.left {
            otherSiblings = nodeToDelete.parent?.right
        } else {
            otherSiblings = nodeToDelete.parent?.left
        }
        
        // We could be one of TWO children directly below the root. Since we are
        // also a leaf, then we know that our sibling will now become the root.
        // handle now. MAKE SURE YOU CHANGE COLOR to BLACK for maintaining RED/BLACK
        // invariant.  See CLR algorithm. No need to modify min/max, since already
        // properly set for the other sibling.
        if nodeToDelete.parent == root {
            // detach to make root!
            otherSiblings?.update(parent: nil)
            otherSiblings?.update(color: .black)
            root = otherSiblings
            // we delete two nodes [node and p]
            size -= 1
            return
        }

        // Now we do the dirty work.
        let grandparentOfNodeToDelete = parentToDelete?.parent
        
        // snip out appropriately [we are deleting p after all, right?]
        otherSiblings?.update(parent: grandparentOfNodeToDelete)
        
        if node.parent == grandparentOfNodeToDelete?.left {
            grandparentOfNodeToDelete?.update(left: otherSiblings)
        } else {
            grandparentOfNodeToDelete?.update(right: otherSiblings)
        }
        
        if let otherSiblingsParent = otherSiblings?.parent {
            propagate(node: otherSiblingsParent)
        }
        
        size -= 2;  // have deleted two nodes [node and p]
    }
}
