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
    
    private var unsortedSortingArray: [Int] = []
    private(set) var graphView: GraphView!
    
    private let algorithms = Algorithms()
    private var sortingAlgorithm: SortingAlgorithm!
    
    // MARK: - Lifecycle functions
    
    convenience init(sortingArray: [Int], sortingAlgorithm: SortingAlgorithm) {
        self.init(frame: .zero)

        self.unsortedSortingArray = sortingArray
        self.sortingAlgorithm = sortingAlgorithm
        
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
        switch sortingAlgorithm {
        case .insert:
            sortByInsert(animated: true)
        case .median:
            sortByMedian(animated: true)
        default:
            return
        }
    }
    
    // MARK: - Sorting algorithms
    
    private func sortByInsert(animated: Bool = false) {
        let insertSortingAlgorithm = InsertSortingAlgorithm(for: unsortedSortingArray)
        insertSortingAlgorithm.delegate = self
        let sortedArray = insertSortingAlgorithm.sort()
        NSLog("Insert Sort Algorithm sorted array \(sortedArray)")
    }
    
    private func sortByMedian(animated: Bool = false) {
        let mediumSortingAlgorithm = MedianSortingAlgorithm(for: unsortedSortingArray)
        mediumSortingAlgorithm.delegate = self
        let sortedArray = mediumSortingAlgorithm.sort()
        NSLog("Medium Sort Algorithm sorted array \(sortedArray)")
    }
}
