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
            sortByInsertion()
        case .median:
            sortByMedian()
        case .quicksort:
            sortByQuicksort()
        default:
            return
        }
    }
    
    // MARK: - Sorting algorithms
    
    private func sortByInsertion() {
        let insertionSortingAlgorithm = InsertionSortingAlgorithm(for: unsortedSortingArray)
        insertionSortingAlgorithm.delegate = self
        let sortedArray = insertionSortingAlgorithm.sort()
        NSLog("Insertion Sort Algorithm sorted array \(sortedArray)")
    }
    
    private func sortByMedian() {
        let mediumSortingAlgorithm = MedianSortingAlgorithm(for: unsortedSortingArray)
        mediumSortingAlgorithm.delegate = self
        let sortedArray = mediumSortingAlgorithm.sort()
        NSLog("Medium Sort Algorithm sorted array \(sortedArray)")
    }
    
    private func sortByQuicksort() {
        let quicksortSortingAlgorithm = QuicksortSortingAlgorithm(for: unsortedSortingArray)
        quicksortSortingAlgorithm.delegate = self
        let sortedArray = quicksortSortingAlgorithm.sort()
        NSLog("QUICKSORT Sort Algorithm sorted array \(sortedArray)")
    }
}
