//
//  SortingView+BucketSortingAlgorithmDelegate.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/22/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

extension SortingView: BucketSortingAlgorithmDelegate {
    
    // MARK: - BucketSortingAlgorithmDelegate implementation

    func bucketSortingAlgorithm(_ algorithm: BucketSortingAlgorithm, didUpdate element: Int, to value: Int, actionIndex: Int) {
        graphView.updateElement(element, to: value, actionIndex: actionIndex)
    }
    
    func bucketSortingAlgorithmDidFinishSorting(_ algorithm: BucketSortingAlgorithm) {
        graphView.runAnimation()
    }
}
