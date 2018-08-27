/*
 
 Binary search - best for sorted collections.
 
 Best - O(1)
 Average - O(log n)
 Worst - O(log n)

 */

import UIKit

func sortedArray(for maxIndex: Int) -> [Int] {
    var array = [Int]()
    
    for index in 0...maxIndex {
        array.append(index)
    }
    
    return array
}

var searchArray = sortedArray(for: 20)

func compare(i: Int, j: Int) -> Int {
    return i - j
}

func search(for number: Int) -> Bool {
    guard !searchArray.isEmpty else {
        return false
    }
    
    var lowIndex = 0
    var highInex = searchArray.count - 1
    
    while (lowIndex <= highInex ) {
        let midIndex = (lowIndex + highInex) / 2
        
        let difference = compare(i: number, j: searchArray[midIndex])
        
        guard difference != 0 else {
            // Number is equal to a searchArray[midIndex].
            return true
        }
        
        if difference < 0 {
            // Number is less than a searchArray[midIndex].
            highInex = midIndex - 1
            
        } else {
            // Number is greater than a searchArray[midIndex].
            lowIndex = midIndex + 1
        }
    }
    
    return false
}

search(for: 9)
search(for: 100)
search(for: 10)


