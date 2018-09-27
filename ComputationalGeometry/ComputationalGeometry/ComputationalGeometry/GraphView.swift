//
//  GraphView.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/26/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class GraphView: UIView {

    // MARK: - Initialization
    
    convenience init() {
        self.init(frame: .zero)
        
        self.isUserInteractionEnabled = false
    }
    
    func reset() {
        layer.sublayers?.removeAll()
    }

}
