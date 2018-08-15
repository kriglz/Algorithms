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
    
    // MARK: - Lifecycle functions
    
    convenience init(sortingArray: [Int]) {
        self.init(frame: .zero)

        self.sortingArray = sortingArray
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.brown.cgColor
        
        let node = NSView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        addSubview(node)
        
        sortArray()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Sorting
    
    private func sortArray() {
        for index in 1..<sortingArray.count {
            var previousIndex = index - 1
            
            while (previousIndex >= 0 && compare(numberA: sortingArray[previousIndex], numberB: sortingArray[previousIndex + 1]) > 0) {
                sortingArray.swapAt(previousIndex, previousIndex + 1)
                
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
    
    private func animateSorting() {
            
    }
}
