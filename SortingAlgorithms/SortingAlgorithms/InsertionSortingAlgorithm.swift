//
//  InsertionSortingAlgorithm.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/20/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

/// Insertion sorting algorithm object for specified array.
class InsertionSortingAlgorithm: NSObject {

    // MARK: - Properties
    
    weak var delegate: InsertionSortingAlgorithmDelegate?
    
    private var sortingArray: [Int] = []
    private let algorithms = Algorithms()
    
    // MARK: - Initialization
    
    /// Returns a insertion sorting algorithm object for specified array.
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
    /// - Returns: Sorted array by insertion sorting algorithm.
    func sort() -> [Int] {
        performSorting()
        delegate?.insertionSortingAlgorithmDidFinishSorting(self)
        return sortingArray
    }
    
    /// Performs insertion sort for the specified array.
    private func performSorting() {
        var actionIndex = 0
        
        for index in 1..<sortingArray.count {
            var previousIndex = index - 1
            
            while (previousIndex >= 0 && algorithms.compare(numberA: sortingArray[previousIndex], numberB: sortingArray[previousIndex + 1]) > 0) {
                sortingArray.swapAt(previousIndex, previousIndex + 1)
                
                let elementA = sortingArray[previousIndex]
                let elementB = sortingArray[previousIndex + 1]
                let deltaIndex = 1
                delegate?.insertionSortingAlgorithm(self, didSwap: elementA, and: elementB, deltaIndex: deltaIndex, actionIndex: actionIndex)
                
                previousIndex -= 1
                actionIndex += 1
            }
        }
    }
}

/// The object that acts as the delegate of the `InsertionSortingAlgorithm`.
///
/// The delegate must adopt the InsertionSortingAlgorithmDelegate protocol.
///
/// The delegate object is responsible for managing the element swapping.
protocol InsertionSortingAlgorithmDelegate: class {
    
    /// Tells the delegate that elements were swapped.
    ///
    /// - Parameters:
    ///     - algorithm: An object performing insertion sorting algorithm.
    ///     - elementA: First element to be swapped.
    ///     - elementB: Second element to be swapped.
    ///     - deltaIndex: Index delta between elements.
    ///     - actionIndex: Index of swapping action execution.
    func insertionSortingAlgorithm(_ algorithm: InsertionSortingAlgorithm, didSwap elementA: Int, and elementB: Int, deltaIndex: Int, actionIndex: Int)
    
    /// Tells the delegate that algorithm did finish sorting.
    ///
    /// - Parameters:
    ///     - algorithm: An object performing insertion sorting algorithm.
    func insertionSortingAlgorithmDidFinishSorting(_ algorithm: InsertionSortingAlgorithm)
}
