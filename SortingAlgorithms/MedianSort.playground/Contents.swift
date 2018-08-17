//: Playground - noun: a place where people can play

import UIKit

var sortingArray = [15, 09, 08, 01, 04, 11, 07, 12, 13, 06, 05, 03, 16, 02, 10, 14]

//let rightIndex = sortingArray.count - 1
//let leftIndex = 0

func compare(numberA: Int, numberB: Int) -> Int {
    if numberA > numberB {
        return 1
    }
    return 0
}

func partition(leftIndex: Int, rightIndex: Int, pivotIndex: Int) {
    let pivot = sortingArray[pivotIndex]
    sortingArray.swapAt(pivotIndex, rightIndex)

    var storeIndex = leftIndex

    for index in leftIndex..<rightIndex {
        if compare(numberA: sortingArray[index], numberB: pivot) <= 0 {
            sortingArray.swapAt(index, storeIndex)
            storeIndex += 1

            print(sortingArray)
        }
    }

    sortingArray.swapAt(rightIndex, storeIndex)
}

extension Range {
    /// Returns random `Int` number of specific range.
    var random: Int {
        get {
            let mini = UInt32(lowerBound as! Int)
            let maxi = UInt32(upperBound as! Int)
            
            return Int(mini + arc4random_uniform(maxi - mini))
        }
    }
}

func selectPivotIndex(leftIndex: Int, rightIndex: Int) -> Int {
    let range: Range = leftIndex..<rightIndex
    return range.random
}

func selectKthIndex(kIndex: Int, leftIndex: Int, rightIndex: Int) -> Int {
    let pivotIndex = selectPivotIndex(leftIndex: leftIndex, rightIndex: rightIndex)
    
    partition(leftIndex: leftIndex, rightIndex: rightIndex, pivotIndex: pivotIndex)
    
    if leftIndex + kIndex + 1 < pivotIndex {
        return pivotIndex
    }
    
    if leftIndex + kIndex - 1 < pivotIndex {
        return selectKthIndex(kIndex: kIndex, leftIndex: leftIndex, rightIndex: pivotIndex - 1)
    } else {
        return selectKthIndex(kIndex: kIndex - (pivotIndex - leftIndex + 1), leftIndex: pivotIndex + 1, rightIndex: rightIndex)
    }
}




