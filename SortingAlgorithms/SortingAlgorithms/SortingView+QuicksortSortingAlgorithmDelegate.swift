//
//  SortingView+QuicksortSortingAlgorithmDelegate.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/20/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

extension SortingView: QuicksortSortingAlgorithmDelegate {
    
    // MARK: - QuicksortSortingAlgorithmDelegate implementation
    
    func quicksortSortingAlgorithm(_ algorithm: QuicksortSortingAlgorithm, didSwap indexA: Int, and indexB: Int, actionIndex: Int) {
        graphView.swapElements(indexA, indexB, actionIndex: actionIndex, isInActiveRange: true)
    }
    
    func quicksortSortingAlgorithm(_ algorithm: QuicksortSortingAlgorithm, sortingRangeElementIndexes: [Int], actionIndex: Int) {
        graphView.colorElements(sortingRangeElementIndexes, actionIndex: actionIndex)
    }
    
    func quicksortSortingAlgorithmDidFinishSorting(_ algorithm: QuicksortSortingAlgorithm) {
        graphView.runAnimation()
    }    
}
