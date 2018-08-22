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
    
    private func sort(maxIndex: Int) {
        var buckets: [Bucket] = []
        buckets.reserveCapacity(maxIndex + 1)
        
        for _ in 0...maxIndex {
            buckets.append(Bucket())
        }
        
        for index in 0...maxIndex {
            let hashValue = hash(of: sortingArray[index])
            
            let entry = Entry()
            entry.element = sortingArray[index]
            
            if buckets[hashValue].head != nil {
                entry.next = buckets[hashValue].head
            }
            
            buckets[hashValue].head = entry
            buckets[hashValue].size += 1
        }
        
        extract(buckets: buckets, maxIndex: maxIndex)
    }
    
    private func hash(of value: Int) -> Int {
        return value / 3
    }
    
    private func extract(buckets: [Bucket], maxIndex: Int) {
        var sortingArrayIndex = 0
        
        for bucketIndex in 0...maxIndex {
            // Continue if bucket has no elements.
            if buckets[bucketIndex].size == 0 {
                continue
            }
            
            // Bucket has one elements. Continue after overwriting `sortingArray` with that element.
            if let bucketHead = buckets[bucketIndex].head, buckets[bucketIndex].size == 1 {
                sortingArray[sortingArrayIndex] = bucketHead.element
                sortingArrayIndex += 1
                buckets[bucketIndex].head = nil
                buckets[bucketIndex].size = 0
                continue
            }
            
            // Bucket has more than one element. Sort the bucket elements by Insertion sort.
            let lowerIndex = sortingArrayIndex

            if let bucketHead = buckets[bucketIndex].head {
                sortingArray[sortingArrayIndex] = bucketHead.element
                sortingArrayIndex += 1
                buckets[bucketIndex].head = bucketHead.next
                buckets[bucketIndex].size -= 1
            }
            
            while let bucketHead = buckets[bucketIndex].head {
                var index = sortingArrayIndex - 1
                
                while index >= lowerIndex, algorithms.compare(numberA: sortingArray[index], numberB: bucketHead.element) > 0 {
                    sortingArray[index + 1] = sortingArray[index]
                    index -= 1
                }
                
                sortingArray[index + 1] = bucketHead.element
                buckets[bucketIndex].head = bucketHead.next
                sortingArrayIndex += 1
            }
            
            buckets[bucketIndex].size = 0
        }
    }
}

class Bucket: NSObject {

    var size = 0
    var head: Entry? = nil
}

class Entry: NSObject {
    
    var element: Int = 0
    var next: Entry? = nil
}
