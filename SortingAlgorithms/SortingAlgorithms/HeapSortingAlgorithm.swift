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
    
    weak var delegate: HeapSortingAlgorithmDelegate?
    
    private var sortingArray: [Int] = []
    private var actionIndex = 0
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
        let maxIndex = sortingArray.count - 1
        sort(maxIndex: maxIndex)
        
        delegate?.heapSortingAlgorithmDidFinishSorting(self)
        resetAlgorithm()
        
        return sortingArray
    }
    
    /// Resets stored values.
    private func resetAlgorithm() {
        actionIndex = 0
    }
    
    /// Perform a heap sort in a specific range.
    ///
    /// - Parameters:
    ///     - maxIndex: Upper bound index of the range.
    private func sort(maxIndex: Int) {
        buildAHeap(maxIndex: maxIndex)
        
        var index = maxIndex - 1
        while index >= 0 {
            sortingArray.swapAt(0, index)
            elementSwapAt(0, index)
            
            heapify(index: 0, maxIndex: index)
            
            index -= 1
        }
    }
    
    /// Builds a heap in a specific range.
    ///
    /// - Parameters:
    ///     - maxIndex: Upper bound index of the range.
    private func buildAHeap(maxIndex: Int) {
        var index = maxIndex / 2 - 1
        while index >= 0 {
            heapify(index: index, maxIndex: maxIndex)
            index -= 1
        }
    }
    
    /// Perform a heap in a specific range.
    ///
    /// - Parameters:
    ///     - index: An index of the pivot element.
    ///     - maxIndex: Upper bound index of the range.
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
            elementSwapAt(index, largestIndex)
            
            heapify(index: largestIndex, maxIndex: maxIndex)
        }
    }
    
    /// Tells the `HeapSortingAlgorithmDelegate` to swap elements at indexes.
    ///
    /// - Parameters:
    ///     - i: First element to be swaped.
    ///     - j: Second element to be swaped.
    private func elementSwapAt(_ i: Int, _ j: Int) {
        let elementA = sortingArray[i]
        let elementB = sortingArray[j]
        let deltaIndex = i.distance(to: j)
        
        delegate?.heapSortingAlgorithm(self, didSwap: elementA, and: elementB, deltaIndex: deltaIndex, actionIndex: actionIndex)
        
        actionIndex += 1
    }
}


/// The object that acts as the delegate of the `HeapSortingAlgorithmDelegate`.
///
/// The delegate must adopt the HeapSortingAlgorithmDelegateDelegate protocol.
///
/// The delegate object is responsible for managing the element swapping.
protocol HeapSortingAlgorithmDelegate: class {
    
    /// Tells the delegate that elements were swapped.
    ///
    /// - Parameters:
    ///     - algorithm: An object performing quicksort sorting algorithm.
    ///     - elementA: First element to be swapped.
    ///     - elementB: Second element to be swapped.
    ///     - deltaIndex: Index delta between elements.
    ///     - actionIndex: Index of swapping action execution.
    func heapSortingAlgorithm(_ algorithm: HeapSortingAlgorithm, didSwap elementA: Int, and elementB: Int, deltaIndex: Int, actionIndex: Int)
    
    /// Tells the delegate that algorithm did finish sorting.
    ///
    /// - Parameters:
    ///     - algorithm: An object performing quicksort sorting algorithm.
    func heapSortingAlgorithmDidFinishSorting(_ algorithm: HeapSortingAlgorithm)
}
