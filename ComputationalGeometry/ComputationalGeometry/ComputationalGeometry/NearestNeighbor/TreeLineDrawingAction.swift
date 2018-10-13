//
//  TreeLineDrawingAction.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/12/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

struct TreeLineDrawingAction {
    
    let index: Int
    let node: KDNode
    
    init(node: KDNode, index: Int) {
        self.node = node
        self.index = index
    }
}
