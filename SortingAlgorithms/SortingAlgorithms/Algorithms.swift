//
//  Algorithms.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/16/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

class Algorithms {

    var sortingArray = [15, 09, 08, 01, 04, 11, 07, 12, 13, 06, 05, 03, 16, 02, 10, 14]
    
    /// Compares numbers A and B
    ///
    /// Returns 1 if A > B
    ///
    /// Returns 0 if A < B or A = B
    ///
    /// - Parameters:
    ///     - numberA: First comparable number
    ///     - numberB: Second comparable number
    func compare(numberA: Int, numberB: Int) -> Int {
        if numberA > numberB {
            return 1
        }
        return 0
    }
    
    /// Return random pivot index of specified range.
    ///
    /// - Parameters:
    ///     - lowerBound: Lower bound of the range.
    ///     - upperBound: Upper bound of the range.
    func randomIndex(lowerBound: Int, upperBound: Int) -> Int {
        let range: Range = lowerBound..<upperBound
        return range.random
    }
    
    /// Performs partition in a specific range by using random pivot index.
    /// Recursively repeats while calculated kth value is equal to pivot index.
    ///
    /// - Parameters:
    ///     - kIndex: Calcultated mid index in specified range.
    ///     - leftIndex: Lower bound index of the range.
    ///     - rightIndex: Upper bound index of the range.
    func performPartitionForMidKthIndex(kIndex: Int, leftIndex: Int, rightIndex: Int) {
        guard rightIndex >= leftIndex else { return }
        
        let randomPivotIndex = randomIndex(lowerBound: leftIndex, upperBound: rightIndex)
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
    func partition(leftIndex: Int, rightIndex: Int, pivotIndex: Int) -> Int {
        let pivot = sortingArray[pivotIndex]
        
        // Move pivot index number to the end of the range.
        sortingArray.swapAt(pivotIndex, rightIndex)
        
        var storeIndex = leftIndex
        
        for index in leftIndex..<rightIndex {
            if compare(numberA: sortingArray[index], numberB: pivot) <= 0 {
                
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
    func medianSort(leftIndex: Int, rightIndex: Int) {
        guard rightIndex > leftIndex else { return }
        
        let mid = (rightIndex - leftIndex + 1) / 2
        performPartitionForMidKthIndex(kIndex: mid + 1, leftIndex: leftIndex, rightIndex: rightIndex)
        
        medianSort(leftIndex: leftIndex, rightIndex: leftIndex + mid - 1)
        medianSort(leftIndex: leftIndex + mid + 1, rightIndex: rightIndex)
    }
}

enum SortingAlgorithm {
    case insert
    case median
}
