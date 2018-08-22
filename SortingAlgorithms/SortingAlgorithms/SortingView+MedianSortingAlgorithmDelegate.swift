//
//  SortingView+MedianSortingAlgorithmDelegate.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/20/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

extension SortingView: MedianSortingAlgorithmDelegate {
    
    // MARK: - MedianSortingAlgorithmDelegate implementation
    
    func medianSortingAlgorithm(_ algorithm: MedianSortingAlgorithm, didSwap indexA: Int, and indexB: Int, actionIndex: Int) {
        graphView.swapElements(indexA, indexB, actionIndex: actionIndex, isInActiveRange: true)
    }
    
    func medianSortingAlgorithm(_ algorithm: MedianSortingAlgorithm, sortingRangeElementIndexes: [Int], actionIndex: Int) {
        graphView.colorElements(sortingRangeElementIndexes, actionIndex: actionIndex)
    }
    
    func medianSortingAlgorithmDidFinishSorting(_ algorithm: MedianSortingAlgorithm) {
        graphView.runAnimation()
    }    
}
