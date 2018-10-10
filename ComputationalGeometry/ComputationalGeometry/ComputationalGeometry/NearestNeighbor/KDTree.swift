//
//  KDTree.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/9/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class KDTree {
    
    private(set) var root: KDNode?
    
    func updateRoot(to node: KDNode) {
        self.root = node
    }
}
