//
//  SortingView+InsertSortingAlgorithmDelegate.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/20/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

extension SortingView: InsertSortingAlgorithmDelegate {

    // MARK: - InsertSortingAlgorithmDelegate impementation

    func insertSortingAlgorithm(_ algorithm: InsertSortingAlgorithm, didSwap elementA: Int, and elementB: Int, deltaIndex: Int, actionIndex: Int) {
        graphView.swapElements(elementA, elementB, deltaIndex: deltaIndex, actionIndex: actionIndex)
    }
    
    func insertSortingAlgorithmDidFinishSorting(_ algorithm: InsertSortingAlgorithm) {
        graphView.runAnimation()
    }
}
