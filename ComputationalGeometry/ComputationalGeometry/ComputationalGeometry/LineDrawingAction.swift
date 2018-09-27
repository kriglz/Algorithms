//
//  LineDrawingAction.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

struct LineDrawingAction {
    
    enum ActionType {
        case addition
        case removal
    }
    
    let index: Int
    let line: Line
    let type: ActionType
    
    init(line: Line, type: ActionType, index: Int) {
        self.line = line
        self.type = type
        self.index = index
    }
}
