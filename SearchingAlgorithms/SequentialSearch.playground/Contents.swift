/*
 
 Sequential search - best for small collections.
 
 Best - O(1)
 Average - O(n)
 Worst - O(n)

 */

import UIKit

var searchArray = [15, 09, 08, 01, 04, 11, 07, 12, 13, 06, 05, 03, 16, 02, 10, 14]

func compare(i: Int, j: Int) -> Bool {
    return i == j
}

func search(for number: Int) -> Bool {
    for element in searchArray {
        if element == number {
            return true
        }
    }
    
    return false
}

search(for: 9)
search(for: 100)
