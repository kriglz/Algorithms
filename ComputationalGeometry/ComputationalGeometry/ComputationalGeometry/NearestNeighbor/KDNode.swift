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
    private(set) var left: KDNode?
    private(set) var right: KDNode?
    
    init(from point: CGPoint) {
        self.point = point
    }
    
    func update(right node: KDNode) {
        self.right = node
    }
    
    func update(left node: KDNode) {
        self.left = node
    }
    
    func isLeft(of neighborPoint: CGPoint) -> Bool {
        return neighborPoint.x > point.x
    }
}
