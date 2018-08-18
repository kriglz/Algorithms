//: Playground - noun: a place where people can play

import UIKit

var sortingArray = [15, 09, 08, 01, 04, 11, 07, 12, 13, 06, 05, 03, 16, 02, 10, 14]

/// Compares two numbers.
func compare(numberA: Int, numberB: Int) -> Int {
    if numberA > numberB {
        return 1
    }
    return 0
}

/// Sorts by partitioning around pivot number.
func partition(leftIndex: Int, rightIndex: Int, pivotIndex: Int) -> Int {
    let pivot = sortingArray[pivotIndex]
    sortingArray.swapAt(pivotIndex, rightIndex)

    var storeIndex = leftIndex

    for index in leftIndex..<rightIndex {
        if compare(numberA: sortingArray[index], numberB: pivot) <= 0 {
            sortingArray.swapAt(index, storeIndex)
            storeIndex += 1
        }
    }

    sortingArray.swapAt(rightIndex, storeIndex)
    return storeIndex
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

/// Return random pivot index of specific range.
func selectPivotIndex(leftIndex: Int, rightIndex: Int) -> Int {
    let range: Range = leftIndex..<rightIndex
    return range.random
}

/// 
func selectKthIndex(kIndex: Int, leftIndex: Int, rightIndex: Int) {
    guard rightIndex >= leftIndex else { return }

    let randomPivotIndex = selectPivotIndex(leftIndex: leftIndex, rightIndex: rightIndex)
    print(sortingArray)

    let pivotIndex = partition(leftIndex: leftIndex, rightIndex: rightIndex, pivotIndex: randomPivotIndex)
    
    print(sortingArray)
    print(leftIndex, rightIndex, "range")
    print(randomPivotIndex, "randomPivotIndex")
    print(pivotIndex, "pivotIndex")
    print(kIndex, "kIndex\n")
    
    if leftIndex + kIndex - 1 == pivotIndex { return }
    
    if leftIndex + kIndex - 1 < pivotIndex {
        print("left")
        selectKthIndex(kIndex: kIndex, leftIndex: leftIndex, rightIndex: pivotIndex - 1)
    } else {
        selectKthIndex(kIndex: kIndex - (pivotIndex - leftIndex + 1), leftIndex: pivotIndex + 1, rightIndex: rightIndex)
    }
}

/// Performs median sort.
func medianSort(leftIndex: Int, rightIndex: Int) {
    guard rightIndex > leftIndex else { return }

    let mid = (rightIndex - leftIndex + 1) / 2
    selectKthIndex(kIndex: mid + 1, leftIndex: leftIndex, rightIndex: rightIndex)
    
    medianSort(leftIndex: leftIndex, rightIndex: leftIndex + mid - 1)
    medianSort(leftIndex: leftIndex + mid + 1, rightIndex: rightIndex)
}

let leftIndex = 0
let rigthIndex = sortingArray.count - 1
medianSort(leftIndex: leftIndex, rightIndex: rigthIndex)
print("final", sortingArray)


