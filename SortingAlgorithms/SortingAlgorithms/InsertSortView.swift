//
//  InsertSortView.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/14/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import AppKit

class InsertSortView: NSView {
    
    // MARK: - Properties
    
    var sortingArray: [Int] = []
    
    let nodeWidth = 20
    
    // MARK: - Lifecycle functions
    
    convenience init(sortingArray: [Int]) {
        self.init(frame: .zero)

        self.sortingArray = sortingArray
        
        setupSortingView()
        sortArray()
    }
    
    // MARK: - Setup sorting view
    
    private func setupSortingView() {
        for (index, number) in sortingArray.enumerated() {
            
            let rect = NSRect(x: Double(index * nodeWidth) * 1.2 + 30.0,
                              y: 30.0,
                              width: Double(nodeWidth),
                              height: 10 * Double(number))
            
            let node = Node(frame: rect)
            node.id = index
            
            node.wantsLayer = true
            node.layer?.backgroundColor = NSColor.white.cgColor
            node.layer?.borderColor = NSColor.blue.cgColor
            
            self.addSubview(node)
        }
    }
    
    // MARK: - Sorting
    
    private func sortArray(animated: Bool = false) {
        for index in 1..<sortingArray.count {
            var previousIndex = index - 1
            
            while (previousIndex >= 0 && compare(numberA: sortingArray[previousIndex], numberB: sortingArray[previousIndex + 1]) > 0) {
                sortingArray.swapAt(previousIndex, previousIndex + 1)

                if animated {
                    
                }
                
                previousIndex -= 1
            }
        }
    }
    
    private func compare(numberA: Int, numberB: Int) -> Int {
        if numberA > numberB {
            return 1
        }
        return 0
    }
    
    private func animateSwaping() {
            
    }
}

class Node: NSView {
    
    var id: Int?
}
