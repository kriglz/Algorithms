//
//  SortingView+MedianSortingAlgorithmDelegate.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/20/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

extension SortingView: MedianSortingAlgorithmDelegate {
    
    func medianSortingAlgorithm(_ algorithm: MedianSortingAlgorithm, didSwap elementA: Int, and elementB: Int, deltaIndex: Int, actionIndex: Int) {
        graphView.swapElements(elementA, elementB, deltaIndex: deltaIndex, actionIndex: actionIndex)
    }
    
    func medianSortingAlgorithmDidFinishSorting(_ algorithm: MedianSortingAlgorithm) {
        graphView.runAnimation()
    }    
}
