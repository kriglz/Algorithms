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
    
    private var unsortedSortingArray: [Int] = []
    private var graphView: GraphView!
    private let algorithms = Algorithms()
    
    // MARK: - Lifecycle functions
    
    convenience init(sortingArray: [Int]) {
        self.init(frame: .zero)

        self.unsortedSortingArray = sortingArray

        graphView = GraphView(array: unsortedSortingArray)
        self.addSubview(graphView, positioned: .below, relativeTo: nil)
        graphView.constraints(edgesTo: self)

        let sortButton = NSButton(title: "SORT", target: self, action: #selector(sortArrayAction(_:)))
        sortButton.frame.origin = CGPoint(x: 800, y: 30)
        addSubview(sortButton)
        
        let resetButton = NSButton(title: "RESET", target: self, action: #selector(resetAction(_:)))
        resetButton.frame.origin = CGPoint(x: 800, y: 80)
        addSubview(resetButton)
    }
    
    // MARK: - Actions

    @objc private func resetAction(_ sender: NSButton) {
        guard let graphView = self.graphView else { return }
        graphView.reset()
        graphView.setupGraph()
    }
    
    @objc private func sortArrayAction(_ sender: NSButton) {
        sortByInsertArray(animated: true)
    }
    
    // MARK: - Sorting
    
    private func sortByInsertArray(animated: Bool = false) {
        var actionIndex = 0.0
        var sortingArray = unsortedSortingArray
        
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
