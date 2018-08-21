//
//  QuicksortSortingAlgorithm.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/20/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

/// QUICKSORT sorting algorithm object for specified array.
class QuicksortSortingAlgorithm: NSObject {

    // MARK: - Properties
    
    weak var delegate: QuicksortSortingAlgorithmDelegate?
    
    private var sortingArray: [Int] = []
    private var actionIndex = 0
    private let algorithms = Algorithms()
    private let minSize = 4
    
    // MARK: - Initialization
    
    /// Returns a QUICKSORT sorting algorithm object for specified array.
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
    /// - Returns: Sorted array by quicksort sorting algorithm.
    func sort() -> [Int] {
        quicksort(leftIndex: 0, rightIndex: sortingArray.count - 1)
        
        delegate?.quicksortSortingAlgorithmDidFinishSorting(self)
        resetAlgorithm()

        return sortingArray
    }
    
    /// Resets stored values.
    private func resetAlgorithm() {
        actionIndex = 0
    }
    
    /// Performs quicksort in a specific range.
    ///
    /// - Parameters:
    ///     - leftIndex: Lower bound index of the range.
    ///     - rightIndex: Upper bound index of the range.
    private func quicksort(leftIndex: Int, rightIndex: Int) {
        guard leftIndex < rightIndex else { return }
        
        let randomPivotIndex = algorithms.mediumOfThree(lowerBound: leftIndex, upperBound: rightIndex)
        let pivotIndex = partition(leftIndex: leftIndex, rightIndex: rightIndex, pivotIndex: randomPivotIndex)
        
        if pivotIndex - 1 - leftIndex <= minSize, leftIndex < pivotIndex - 1 {
            insertion(leftIndex: leftIndex, rightIndex: pivotIndex - 1)
        } else {
            quicksort(leftIndex: leftIndex, rightIndex: pivotIndex - 1)
        }
        
        if rightIndex - pivotIndex - 1 <= minSize, rightIndex > pivotIndex + 1 {
            insertion(leftIndex: pivotIndex + 1, rightIndex: rightIndex)
        } else {
            quicksort(leftIndex: pivotIndex + 1, rightIndex: rightIndex)
        }
    }
    
    /// Performs partition in a specific range by using pivot index.
    ///
    /// - Parameters:
    ///     - leftIndex: Lower bound index of the range.
    ///     - rightIndex: Upper bound index of the range.
    ///     - pivotIndex: Pivot index of the partitioning.
    private func partition(leftIndex: Int, rightIndex: Int, pivotIndex: Int) -> Int {
        showActiveRange(leftIndex: leftIndex, rightIndex: rightIndex)
        
        let pivot = sortingArray[pivotIndex]
        
        // Move pivot index number to the end of the range.
        sortingArray.swapAt(pivotIndex, rightIndex)
        elementSwapAt(pivotIndex, rightIndex)
        
        var storeIndex = leftIndex
        
        for index in leftIndex..<rightIndex {
            if algorithms.compare(numberA: sortingArray[index], numberB: pivot) <= 0 {
                
                if index != storeIndex {
                    // Swap comparable number with the stored value, if the value is bigger.
                    sortingArray.swapAt(index, storeIndex)
                    elementSwapAt(index, storeIndex)
                }
                storeIndex += 1
            }
        }
        
        if rightIndex != storeIndex {
            // Swap pivot number with the last stored value.
            sortingArray.swapAt(rightIndex, storeIndex)
            elementSwapAt(rightIndex, storeIndex)
        }
        
        return storeIndex
    }
    
    /// Performs insertion sort for the specified array.
    ///
    /// - Parameters:
    ///     - leftIndex: Lower bound index of the range.
    ///     - rightIndex: Upper bound index of the range.
    private func insertion(leftIndex: Int, rightIndex: Int) {
        showActiveRange(leftIndex: leftIndex, rightIndex: rightIndex)
        
        for index in leftIndex...rightIndex {
            var previousIndex = index - 1
            
            while (previousIndex >= 0 && algorithms.compare(numberA: sortingArray[previousIndex], numberB: sortingArray[previousIndex + 1]) > 0) {
                sortingArray.swapAt(previousIndex, previousIndex + 1)
                elementSwapAt(previousIndex, previousIndex + 1)
                previousIndex -= 1
            }
        }
    }
    
    /// Tells the `QuicksortSortingAlgorithmDelegate` to swap elements at indexes.
    ///
    /// - Parameters:
    ///     - i: First element to be swaped.
    ///     - j: Second element to be swaped.
    private func elementSwapAt(_ i: Int, _ j: Int) {
        let elementA = sortingArray[i]
        let elementB = sortingArray[j]
        let deltaIndex = i.distance(to: j)
        
        delegate?.quicksortSortingAlgorithm(self, didSwap: elementA, and: elementB, deltaIndex: deltaIndex, actionIndex: actionIndex)
        
        actionIndex += 1
    }
    
    /// Tells the `QuicksortSortingAlgorithmDelegate` to highlight elements in active sorting range.
    ///
    /// - Parameters:
    ///     - leftIndex: Lower bound index of the range.
    ///     - rightIndex: Upper bound index of the range.
    private func showActiveRange(leftIndex: Int, rightIndex: Int) {
        let activeArray = Array(sortingArray[leftIndex...rightIndex])
        delegate?.quicksortSortingAlgorithm(self, sortingRangeElements: activeArray, actionIndex: actionIndex)
    }
}


/// The object that acts as the delegate of the `QuicksortSortingAlgorithm`.
///
/// The delegate must adopt the QuicksortSortingAlgorithmDelegate protocol.
///
/// The delegate object is responsible for managing the element swapping.
protocol QuicksortSortingAlgorithmDelegate: class {
    
    /// Tells the delegate that elements were swapped.
    ///
    /// - Parameters:
    ///     - algorithm: An object performing quicksort sorting algorithm.
    ///     - elementA: First element to be swapped.
    ///     - elementB: Second element to be swapped.
    ///     - deltaIndex: Index delta between elements.
    ///     - actionIndex: Index of swapping action execution.
    func quicksortSortingAlgorithm(_ algorithm: QuicksortSortingAlgorithm, didSwap elementA: Int, and elementB: Int, deltaIndex: Int, actionIndex: Int)
    
    /// Tells the delegate that specific sorting range elements became active.
    ///
    /// - Parameters:
    ///     - algorithm: An object performing quicksort sorting algorithm.
    ///     - sortingRangeElements: Active sorting range elements.
    ///     - actionIndex: Index of swapping action execution.
    func quicksortSortingAlgorithm(_ algorithm: QuicksortSortingAlgorithm, sortingRangeElements: [Int], actionIndex: Int)
    
    /// Tells the delegate that algorithm did finish sorting.
    ///
    /// - Parameters:
    ///     - algorithm: An object performing quicksort sorting algorithm.
    func quicksortSortingAlgorithmDidFinishSorting(_ algorithm: QuicksortSortingAlgorithm)
}

