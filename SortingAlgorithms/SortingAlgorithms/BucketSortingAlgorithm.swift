//
//  BucketSortingAlgorithm.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/21/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

/// Bucket sorting algorithm object for specified array.
class BucketSortingAlgorithm: NSObject {

    // MARK: - Properties
    
    private var sortingArray: [Int] = []
    private let algorithms = Algorithms()
    
    // MARK: - Initialization
    
    /// Returns a bucket sorting algorithm object for specified array.
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
    /// - Returns: Sorted array by bucket sorting algorithm.
    func sort() -> [Int] {
        let maxIndex = sortingArray.count - 1
        sort(maxIndex: maxIndex)
        return sortingArray
    }
    
    /// Sorts the specified array of integers.
    ///
    /// - Parameters:
    ///     - maxIndex: Upper bound index of the range.
    private func sort(maxIndex: Int) {
        
        // Initialized array of `Buckets` of size `maxIndex + 1`.
        var buckets: [Bucket] = []
        buckets.reserveCapacity(maxIndex + 1)
        for _ in 0...maxIndex {
            buckets.append(Bucket())
        }
        
        // Fills `buckets` with `sortingArray` elements.
        for index in 0...maxIndex {
            let hashValue = hash(of: sortingArray[index])
            
            let entry = Entry()
            entry.element = sortingArray[index]
            
            if buckets[hashValue].entry != nil {
                entry.nextEntry = buckets[hashValue].entry
            }
            
            buckets[hashValue].entry = entry
            buckets[hashValue].size += 1
        }
        
        extract(buckets: buckets, maxIndex: maxIndex)
    }
    
    /// Hash value of specified integer number.
    ///
    /// - Parameters:
    ///     - value: Integer number which hash value needs to be calculated.
    /// - Returns: `value / 3`.
    private func hash(of value: Int) -> Int {
        return value / 3
    }
    
    /// Overrites `sortingArray` elements based on the bucket elements.
    ///
    /// - Parameters:
    ///     - buckets: An array of `Buckets`, each individual bucket stores `sortingArray` elements based on hash value.
    ///     - maxIndex: Upper bound index of the range.
    private func extract(buckets: [Bucket], maxIndex: Int) {
        var sortingArrayIndex = 0
        
        for bucketIndex in 0...maxIndex {
            // Continue if bucket has no elements.
            if buckets[bucketIndex].size == 0 {
                continue
            }
            
            // Bucket has one elements. Continue after overwriting `sortingArray` with that element.
            if let bucketHead = buckets[bucketIndex].entry, buckets[bucketIndex].size == 1 {
                sortingArray[sortingArrayIndex] = bucketHead.element
                sortingArrayIndex += 1
                buckets[bucketIndex].entry = nil
                buckets[bucketIndex].size = 0
                continue
            }
            
            // Bucket has more than one element.
            // Sorts the bucket elements by Insertion sort.
            let lowerIndex = sortingArrayIndex

            if let bucketHead = buckets[bucketIndex].entry {
                sortingArray[sortingArrayIndex] = bucketHead.element
                sortingArrayIndex += 1
                buckets[bucketIndex].entry = bucketHead.nextEntry
                buckets[bucketIndex].size -= 1
            }
            
            while let bucketHead = buckets[bucketIndex].entry {
                var index = sortingArrayIndex - 1
                
                while index >= lowerIndex, algorithms.compare(numberA: sortingArray[index], numberB: bucketHead.element) > 0 {
                    sortingArray[index + 1] = sortingArray[index]
                    index -= 1
                }
                
                sortingArray[index + 1] = bucketHead.element
                buckets[bucketIndex].entry = bucketHead.nextEntry
                sortingArrayIndex += 1
            }
            
            buckets[bucketIndex].size = 0
        }
    }
}

/// Bucket object, which is used to store elements from sorting array based on hash value.
///
/// Stores size of bucket entry objects and entry object itself.
class Bucket: NSObject {

    /// Object `Entry` number in the bucket.
    var size = 0
    
    /// Object `Entry` which is stored in the bucket.
    var entry: Entry? = nil
}

/// Entry object which is used to store integer element in a recursive way.
///
/// Stores element as `Int` and neighbour element as `Entry`.
class Entry: NSObject {
    
    /// Integer element.
    var element: Int = 0
    
    /// Next neighbor `Entry` object of the `element`.
    var nextEntry: Entry? = nil
}
