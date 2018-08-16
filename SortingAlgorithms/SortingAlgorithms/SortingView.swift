//
//  SortingView.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/14/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import AppKit

class SortingView: NSView {
    
    // MARK: - Properties
    
    private var sortingArray: [Int] = []
    private var graphView: GraphView!
    
    // MARK: - Lifecycle functions
    
    convenience init(sortingArray: [Int]) {
        self.init(frame: .zero)

        self.sortingArray = sortingArray
        
        graphView = GraphView(array: sortingArray)
        self.addSubview(graphView)
        graphView.constraints(edgesTo: self)
        
        let sortButton = NSButton(title: "SORT", target: self, action: #selector(sortArrayAction(_:)))
        sortButton.frame.origin = CGPoint(x: 800, y: 30)
        addSubview(sortButton)
    }
    
    // MARK: - Actions

    @objc private func sortArrayAction(_ sender: NSButton) {
        sortArray(animated: true)
    }
    
    // MARK: - Sorting
    
    private func sortArray(animated: Bool = false) {
        var actionIndex = 0.0
        
        for index in 1..<sortingArray.count {
            var previousIndex = index - 1
            
            while (previousIndex >= 0 && compare(numberA: sortingArray[previousIndex], numberB: sortingArray[previousIndex + 1]) > 0) {
                sortingArray.swapAt(previousIndex, previousIndex + 1)

                if animated {
                    graphView.swapElements(sortingArray[previousIndex], sortingArray[previousIndex + 1], actionIndex: actionIndex)
                }
                
                previousIndex -= 1
                actionIndex += 1
            }
        }

        if animated {
            graphView.performAnimation()
        }
    }
    
    private func compare(numberA: Int, numberB: Int) -> Int {
        if numberA > numberB {
            return 1
        }
        return 0
    }
}
