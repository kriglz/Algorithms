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
    
    private var sortingAlgorithm: SortingAlgorithm!
    private var unsortedSortingArray: [Int] = []
    private var isUnsorted = true

    private(set) var graphView: GraphView!
    
    private let algorithms = Algorithms()
    
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
        
        isUnsorted = true
    }
    
    @objc private func sortArrayAction(_ sender: NSButton) {
        guard isUnsorted else { return }
        isUnsorted = false

        switch sortingAlgorithm {
        case .insertion:
            sortByInsertion()
        case .median:
            sortByMedian()
        case .quicksort:
            sortByQuicksort()
        case .heap:
            sortByHeap()
        case .bucket:
            sortByBucket()
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
    
    private func sortByHeap() {
        let heapSortingAlgorithm = HeapSortingAlgorithm(for: unsortedSortingArray)
        heapSortingAlgorithm.delegate = self
        let sortedArray = heapSortingAlgorithm.sort()
        NSLog("Heap Sort Algorithm sorted array \(sortedArray)")
    }
    
    private func sortByBucket() {
        let bucketSortingAlgorithm = BucketSortingAlgorithm(for: unsortedSortingArray)
//        bucketSortingAlgorithm.delegate = self
        let sortedArray = bucketSortingAlgorithm.sort()
        NSLog("Bucket Sort Algorithm sorted array \(unsortedSortingArray)")
        NSLog("Bucket Sort Algorithm sorted array \(sortedArray)")
    }
}
