//
//  NearestNeighborController.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/9/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class NearestNeighborController {
    
    // MARK: - Properties
    
    private(set) var points: [CGPoint]
    private let algorithm: NearestNeighborAlgorithm
    private let frame: CGRect
    
    var treeActionBuffer: [LineDrawingAction] {
        guard !algorithm.treeActionBuffer.isEmpty else {
            return []
        }
        
        var actions = [LineDrawingAction]()
        
        for action in algorithm.treeActionBuffer {
            var startPoint = action.node.point
            var endPoint = action.node.point
            
            var parent = action.node.parent
            
            if parent == nil {
                switch action.node.dimension {
                case 1:
                    startPoint.y = frame.minY
                    endPoint.y = frame.maxY
                default:
                    startPoint.x = frame.minX
                    endPoint.x = frame.maxX
                }
            } else {
                endPoint = parent!.point
                
                switch action.node.dimension {
                case 1:
                    endPoint.x = action.node.point.x

//                    if parent?.parent == nil {
//                        if endPoint.y < action.node.point.y {
//                            startPoint.y = frame.maxY
//                        } else {
//                            startPoint.y = frame.minY
//                        }
//                    }
                    
                    while parent != nil {

                        if parent?.parent == nil {
                            if endPoint.y < action.node.point.y {
                                startPoint.y = frame.maxY
                            } else {
                                startPoint.y = frame.minY
                            }
                        }
                        
                        if let parentParent = parent?.parent {
                            if startPoint.y < parent!.point.y, startPoint.y > parentParent.point.y {
                                startPoint.y = parentParent.point.y
                            } else if startPoint.y > parent!.point.y, startPoint.y < parentParent.point.y {
                                startPoint.y = parentParent.point.y
                            }
                        }
                    
                        parent = parent?.parent
                    }
                    
                default:
                    endPoint.y = action.node.point.y
                    
                    if parent?.parent == nil, endPoint.x < action.node.point.x {
                        startPoint.x = frame.maxX
                    } else if parent?.parent == nil, endPoint.x > action.node.point.x {
                        startPoint.x = frame.minX
                    }
                    
                    while parent != nil {
//                        if parent?.parent == nil {
//                            if endPoint.x < action.node.point.x, startPoint.x < parent!.point.x {
//                                startPoint.x = parent!.point.x //frame.maxX
//                            } else if endPoint.x > action.node.point.x, startPoint.x > parent!.point.x {
//                                startPoint.x = parent!.point.x //frame.minX
//                            }
//                        }
                        
                        
                        if let parentParent = parent?.parent {
                            if startPoint.x < parent!.point.x, startPoint.x > parentParent.point.x {
                                startPoint.x = parentParent.point.x
                            } else if startPoint.x > parent!.point.x, startPoint.x < parentParent.point.x {
                                startPoint.x = parentParent.point.x
                            }
                        }
                        
                        parent = parent?.parent
                    }
                }
            }
            
            let line = Line(startPoint: startPoint, endPoint: endPoint)
            let lineAction = LineDrawingAction(line: line, type: .addition, index: action.index)
            actions.append(lineAction)
        }
        
        return actions
    }
    
    // MARK: - Initialization
    
    init(pointCount: Int, in rect: CGRect) {
        self.frame = rect
        points = []
        
        for _ in 1...pointCount {
            let newPoint = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX), y: CGFloat.random(in: rect.minY...rect.maxY))
            points.append(newPoint)
        }
        
        algorithm = NearestNeighborAlgorithm(points: points)
    }
    
    // MARK: - Compute methods
    
    func nearestNeighbor(for point: CGPoint) -> CGPoint? {
        return algorithm.nearestNeighbor(for: point)
    }
}
