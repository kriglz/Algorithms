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
    
    func quicksortSortingAlgorithm(_ algorithm: QuicksortSortingAlgorithm, didSwap elementA: Int, and elementB: Int, deltaIndex: Int, actionIndex: Int) {
        graphView.swapElements(elementA, elementB, deltaIndex: deltaIndex, actionIndex: actionIndex)
    }
    
    func quicksortSortingAlgorithm(_ algorithm: QuicksortSortingAlgorithm, sortingRangeElements: [Int], actionIndex: Int) {
        graphView.colorElements(sortingRangeElements, actionIndex: actionIndex)
    }
    
    func quicksortSortingAlgorithmDidFinishSorting(_ algorithm: QuicksortSortingAlgorithm) {
        graphView.runAnimation()
    }    
}
