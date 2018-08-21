//
//  HeapSortingAlgorithm.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/21/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

/// Heap sorting algorithm object for specified array.
class HeapSortingAlgorithm: NSObject {

    // MARK: - Properties
    
//    weak var delegate: QuicksortSortingAlgorithmDelegate?
    
    private var sortingArray: [Int] = []
//    private var actionIndex = 0
    private let algorithms = Algorithms()
    
    // MARK: - Initialization
    
    /// Returns a heap sorting algorithm object for specified array.
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
    /// - Returns: Sorted array by heap sorting algorithm.
    func sort() -> [Int] {
        let count = sortingArray.count - 1
        sort(count: count)
        
//        delegate?.quicksortSortingAlgorithmDidFinishSorting(self)
//        resetAlgorithm()
                
        return sortingArray
    }
    
    private func sort(count: Int) {
        buildAHeap(count: count)
        
        var index = count - 1
        while index >= 0 {
            sortingArray.swapAt(0, index)
            heapify(index: 0, maxIndex: index)
            index -= 1
        }
    }
    
    private func buildAHeap(count: Int) {
        var index = count / 2 - 1
        while index >= 0 {
            heapify(index: index, maxIndex: count)
            index -= 1
        }
    }
    
    private func heapify(index: Int, maxIndex: Int) {
        let leftIndex = 2 * index + 1
        let rightIndex = 2 * index + 2
        
        var largestIndex = 0
        
        // Finds largest element.
        if leftIndex < maxIndex, algorithms.compare(numberA: sortingArray[leftIndex], numberB: sortingArray[index]) > 0 {
            largestIndex = leftIndex
        } else {
            largestIndex = index
        }
        
        if rightIndex < maxIndex, algorithms.compare(numberA: sortingArray[rightIndex], numberB: sortingArray[largestIndex]) > 0 {
            largestIndex = rightIndex
        }
        
        // If largest is not already the parent then swaps and propagates.
        if largestIndex != index {
            sortingArray.swapAt(index, largestIndex)
            
            heapify(index: largestIndex, maxIndex: maxIndex)
        }
    }
}
