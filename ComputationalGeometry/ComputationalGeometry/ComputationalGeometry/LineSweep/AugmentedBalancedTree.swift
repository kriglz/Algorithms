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
    
    /// Returns the node assosiated with the specified key.
    func searchEntry(for key: CGPoint) -> AugmentedBalancedBinaryNode? {
        var node = root
        
        if node == nil {
            NSLog("Not preset node for key - \(key).")
            return nil
        }
        
        // Finds leaf entry. Use interior nodes (i.e., whose value is nil) to guide the location.
//        while node != nil {
//            let comparison = node!.right?.min.compare(with: key)
//            
//            if comparison == 0 {
//                return node
//            } else if comparison > 0 {
//                node = node!.left
//            } else {
//                node = node!.right
//            }
//        }
        
        
//        while node != nil {
//            let compare = key - node!.key
//
//            if compare == 0 {
//                return node
//            } else if compare < 0 {
//                node = node?.left
//            } else {
//                node = node?.right
//            }
//        }
        
        
        
        return nil
        

        
        // find leaf entry.
        // Use interior nodes (i.e., whose value is null) to guide the location.
//        while (t.value() == null) {
//            int cmp = compare(t.right().min, key);
//            if (cmp > 0) {
//                t = t.left();
//            } else {
//                t = t.right();
//            }
//        }
//
//        if (t.value().equals(key)) {
//            return t;
//        }
//
//        return null;
    }
}

extension CGPoint {
    
    func compare(with point: CGPoint) -> CGFloat {
        if self.y != point.y {
            return self.y - point.y
        } else {
            return self.x - point.x
        }
    }
}
