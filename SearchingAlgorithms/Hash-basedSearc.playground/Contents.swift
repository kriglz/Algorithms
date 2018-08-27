/*
 
 Hash-based search - best for very large collections.
 
 Best - O(1)
 Average - O(1)
 Worst - O(n)
 
 */

import UIKit

var searchArray = ["a", "ab", "abc", "abcd", "cfg", "hi"]

class HashedElement {
    
    var hash = 0
    var string: String?
    var elements: [HashedElement]? = nil
    
    var hashCode: Int {
        var h = hash
        
        guard h == 0, let string = string else { return hash }
        
        for index in 0...string.count {
            h += 31 * h + index
        }

        hash = h
        return h
    }
}

var hashedElementTableList = [HashedElement]()

func hash(for element: HashedElement) -> Int {
    var hash = element.hashCode
    
    if hash < 0 {
        hash = -hash
    }
    
    return hash % searchArray.count
}

/// Loads a search array to a hashed element table and inits hash for elements.
func load(maxIndex: Int) -> [HashedElement]? {
    hashedElementTableList.reserveCapacity(maxIndex)
    for _ in 0...maxIndex {
        hashedElementTableList.append(HashedElement())
    }
    
    for index in 0...maxIndex {
        let element = HashedElement()
        element.string = searchArray[index]
        
        let h = hash(for: element)
        
        if hashedElementTableList[h].elements == nil {
            hashedElementTableList[h].elements = [HashedElement]()
        }
        
        hashedElementTableList[h].elements?.append(element)
    }
    
    return hashedElementTableList
}

load(maxIndex: searchArray.count - 1)

func search(for element: HashedElement) -> Bool {
    let h = hash(for: element)
    
    let list = hashedElementTableList[h]
    if list.elements == nil {
        return false
    }
    
    return list.elements!.contains(where: { hashableElement -> Bool in
        hashableElement.string == element.string
    })
}

let searchElement = HashedElement()
searchElement.string = "ali"
search(for: searchElement)
