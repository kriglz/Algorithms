//
//  QuicksortSortingAlgorithm.swift
//  ComputationalGeometry
//
//  Created by Kristina Gelzinyte on 10/9/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

class QuicksortSortingAlgorithm {
    
    private(set) var sortingArray: [CGPoint]
    
    init(sortingArray: [CGPoint]) {
        self.sortingArray = sortingArray
    }
    
    @discardableResult func select(mediumIndex: Int, leftIndex: Int, rightIndex: Int) -> CGPoint {
        var left = leftIndex
        var right = rightIndex
        var medium = mediumIndex
        
        while true {
            if left == right {
                return sortingArray[left]
            }
            
            let randomPivotIndex = mediumOfThree(leftIndex: left, rightIndex: right)
            let pivotIndex = partition(leftIndex: left, rightIndex: right, pivotIndex: randomPivotIndex)
            
            if left + medium - 1 == pivotIndex {
                return sortingArray[pivotIndex]
            }
            
            // Continue the loop narrowing the range as appropriate
            if left + medium - 1 < pivotIndex {
                // Left side of the pivot.
                right = pivotIndex - 1
            } else {
                // Right side of the pivot.
                medium -= pivotIndex - left + 1
                left = pivotIndex + 1
            }
        }
    }
    
    func partition(leftIndex: Int, rightIndex: Int, pivotIndex: Int) -> Int {
        let pivot = sortingArray[pivotIndex]
        
        // Move pivot index number to the end of the range.
        sortingArray.swapAt(pivotIndex, rightIndex)

        var storeIndex = leftIndex
        
        for index in leftIndex..<rightIndex {
            if compare(i: sortingArray[index], j: pivot) <= 0 {
                
                if index != storeIndex {
                    sortingArray.swapAt(index, storeIndex)
                }
                storeIndex += 1
            }
        }
        
        if rightIndex != storeIndex {
            sortingArray.swapAt(rightIndex, storeIndex)
        }
        
        return storeIndex   
    }
    
    func mediumOfThree(leftIndex: Int, rightIndex: Int) -> Int {
        var randomElements: [Int] = []
        for _ in 0..<3 {
            randomElements.append(randomIndex(leftIndex: leftIndex, rightIndex: rightIndex))
        }
        randomElements.sort()
        return randomElements[1]
    }
    
    func randomIndex(leftIndex: Int, rightIndex: Int) -> Int {
        return Int.random(in: leftIndex..<rightIndex)
    }
    
    func compare(i: (CGPoint), j: (CGPoint)) -> Int {
        if i.x > j.x {
            return 1
        }
        
        return 0
    }
}
