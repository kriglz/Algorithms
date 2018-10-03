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
//    func searchEntry(for key: LineSegment) -> AugmentedBalancedBinaryNode? {
//        var node = root
//        
//        if node == nil {
//            NSLog("Not preset node for key - \(key).")
//            return nil
//        }
//        
//        // Finds leaf entry. Use interior nodes (i.e., whose value is nil) to guide the location.
//        while node?.value == nil {
//            guard let comparison = node!.right?.min.compare(with: key) else {
//                continue
//            }
//            
//            if comparison > 0 {
//                node = node!.left
//            } else {
//                node = node!.right
//            }
//        }
//        
//        if let nodeValue = node?.value, nodeValue.equalTo(key) {
//            return node
//        }
//  
//        return nil
//    }
    
    func insert(lineSegment: LineSegment) {
        
    }
    
}
