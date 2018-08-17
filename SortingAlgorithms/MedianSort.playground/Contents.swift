//: Playground - noun: a place where people can play

import UIKit

var sortingArray = [15, 09, 08, 01, 04, 11, 07, 12, 13, 06, 05, 03, 16, 02, 10, 14]
let pivotIndex = 6

let rightIndex = sortingArray.count - 1
let leftIndex = 0

func compare(numberA: Int, numberB: Int) -> Int {
    if numberA > numberB {
        return 1
    }
    return 0
}

func partition() {
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

partition()

