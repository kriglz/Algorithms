//
//  MedianSortingAlgorithm.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/17/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

/// Median sorting algorithm object for specified array.
class MedianSortingAlgorithm: NSObject {

    // MARK: - Properties
    
    private var sortingArray: [Int] = []
    private let algorithms = Algorithms()
    
    // MARK: - Initialization
    
    /// Returns a median sorting algorithm object for specified array.
    ///
    /// - Parameters:
    ///     - array: To be sorted array.
    convenience init(for array: [Int]) {
        self.init()
        self.sortingArray = array
    }
    
    // MARK: - Sorting functions
    
    /// Sorts the specified array of integers.
    ///
    /// - Returns: Sorted array by median sorting algorithm.
    func sort() -> [Int] {
        sort(leftIndex: 0, rightIndex: sortingArray.count - 1)
        return sortingArray
    }
    
    /// Performs partition in a specific range by using random pivot index.
    /// Recursively repeats while calculated kth value is equal to pivot index.
    ///
    /// - Parameters:
    ///     - kIndex: Calcultated mid index in specified range.
    ///     - leftIndex: Lower bound index of the range.
    ///     - rightIndex: Upper bound index of the range.
    private func performPartitionForMidKthIndex(kIndex: Int, leftIndex: Int, rightIndex: Int) {
        guard rightIndex >= leftIndex else { return }
        
        let randomPivotIndex = algorithms.randomIndex(lowerBound: leftIndex, upperBound: rightIndex)
        let pivotIndex = partition(leftIndex: leftIndex, rightIndex: rightIndex, pivotIndex: randomPivotIndex)
        
        if leftIndex + kIndex - 1 == pivotIndex { return }
        
        if leftIndex + kIndex - 1 < pivotIndex {
            // For left side range.
            performPartitionForMidKthIndex(kIndex: kIndex, leftIndex: leftIndex, rightIndex: pivotIndex - 1)
        } else {
            // For right side range.
            performPartitionForMidKthIndex(kIndex: kIndex - (pivotIndex - leftIndex + 1), leftIndex: pivotIndex + 1, rightIndex: rightIndex)
        }
    }
    
    /// Performs partition in a specific range by using pivot index.
    ///
    /// - Parameters:
    ///     - leftIndex: Lower bound index of the range.
    ///     - rightIndex: Upper bound index of the range.
    ///     - pivotIndex: Pivot index of the partitioning.
    private func partition(leftIndex: Int, rightIndex: Int, pivotIndex: Int) -> Int {
        let pivot = sortingArray[pivotIndex]
        
        // Move pivot index number to the end of the range.
        sortingArray.swapAt(pivotIndex, rightIndex)
        
        var storeIndex = leftIndex
        
        for index in leftIndex..<rightIndex {
            if algorithms.compare(numberA: sortingArray[index], numberB: pivot) <= 0 {
                
                // Swap comparable number with the stored value, if the value is bigger.
                sortingArray.swapAt(index, storeIndex)
                storeIndex += 1
            }
        }
        
        // Swap pivot number with the last stored value.
        sortingArray.swapAt(rightIndex, storeIndex)
        
        return storeIndex
    }
    
    /// Performs median sort in specific range.
    ///
    /// - Parameters:
    ///     - leftIndex: Lower bound index of the range.
    ///     - rightIndex: Upper bound index of the range.
    private func sort(leftIndex: Int, rightIndex: Int) {
        guard rightIndex > leftIndex else { return }
        
        let mid = (rightIndex - leftIndex + 1) / 2
        performPartitionForMidKthIndex(kIndex: mid + 1, leftIndex: leftIndex, rightIndex: rightIndex)
        
        sort(leftIndex: leftIndex, rightIndex: leftIndex + mid - 1)
        sort(leftIndex: leftIndex + mid + 1, rightIndex: rightIndex)
    }
}
