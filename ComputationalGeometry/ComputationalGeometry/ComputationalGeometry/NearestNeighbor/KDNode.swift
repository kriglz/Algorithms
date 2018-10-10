//
//  KDNode.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/9/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class KDNode {
    
    private var point: CGPoint
    private var left: KDNode?
    private var right: KDNode?
    
    init(from point: CGPoint) {
        self.point = point
    }
    
    func update(right node: KDNode) {
        self.right = node
    }
    
    func update(left node: KDNode) {
        self.left = node
    }
}
