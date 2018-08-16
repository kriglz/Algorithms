//
//  InsertSortingView.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/14/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import AppKit

class InsertSortingView: NSView {
    
    // MARK: - Properties
    
    private var sortingArray: [Int] = []
    private var graphView: GraphView!
    
    private let algorithms = Algorithms()
    
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

    @objc func sortArrayAction(_ sender: NSButton) {
        sortByInsertArray(animated: true)
    }
    
    // MARK: - Sorting
    
    private func sortByInsertArray(animated: Bool = false) {
        var actionIndex = 0.0
        
        for index in 1..<sortingArray.count {
            var previousIndex = index - 1
            
            while (previousIndex >= 0 && algorithms.compare(numberA: sortingArray[previousIndex], numberB: sortingArray[previousIndex + 1]) > 0) {
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
}
