//
//  SortingView+InsertionSortingAlgorithmDelegate.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/20/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

extension SortingView: InsertionSortingAlgorithmDelegate {

    // MARK: - InsertionSortingAlgorithmDelegate impementation

    func insertionSortingAlgorithm(_ algorithm: InsertionSortingAlgorithm, didSwap indexA: Int, and indexB: Int, actionIndex: Int) {
        graphView.swapElements(indexA, indexB, actionIndex: actionIndex)
    }
    
    func insertionSortingAlgorithmDidFinishSorting(_ algorithm: InsertionSortingAlgorithm) {
        graphView.runAnimation()
    }
}
