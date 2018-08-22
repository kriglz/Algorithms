//
//  SortingView+HeapSortingAlgorithmDelegate.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/21/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

extension SortingView: HeapSortingAlgorithmDelegate {
    
    // MARK: - HeapSortingAlgorithmDelegate implementation
    
    func heapSortingAlgorithm(_ algorithm: HeapSortingAlgorithm, didSwap indexA: Int, and indexB: Int, actionIndex: Int) {
        graphView.swapElements(indexA, indexB, actionIndex: actionIndex)
    }
    
    func heapSortingAlgorithmDidFinishSorting(_ algorithm: HeapSortingAlgorithm) {
        graphView.runAnimation()
    }
}
