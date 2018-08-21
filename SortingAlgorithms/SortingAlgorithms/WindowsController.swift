//
//  WindowsController.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/14/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

class WindowsController: NSWindowController {
    
//    let sortingArray = [1, 2, 3, 4, 5, 6, 07, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    let sortingArray = [15, 09, 08, 01, 04, 11, 07, 12, 13, 06, 05, 03, 16, 02, 10, 14]
//    let sortingArray = [15, 02, 11, 09, 1]

    // MARK: - Properties
    
    let toolbar = NSToolbar()
    
    lazy var toolbarItemIdentifiers = [insertionSortToolbarItemID, medianSortToolbarItemID, quicksortSortToolbarItemID, heapSortToolbarItemID]
    
    private var sortingView: SortingView?
    
    private let insertionSortToolbarItemID = NSToolbarItem.Identifier("insertion sort")
    private lazy var insertionSortToolbarItem: NSToolbarItem = {
        let item = NSToolbarItem(itemIdentifier: insertionSortToolbarItemID)
        
        item.label = "Insertion"
        item.target = self
        item.action = #selector(showInsertionSortingViewController)
        
        return item
    }()
    
    private let medianSortToolbarItemID = NSToolbarItem.Identifier("Median sort")
    private lazy var medianSortToolbarItem: NSToolbarItem = {
        let item = NSToolbarItem(itemIdentifier: medianSortToolbarItemID)
        
        item.label = "Median"
        item.target = self
        item.action = #selector(openMedianSortingViewController)
                
        return item
    }()

    private let quicksortSortToolbarItemID = NSToolbarItem.Identifier("Quicksort sort")
    private lazy var quicksortSortToolbarItem: NSToolbarItem = {
        let item = NSToolbarItem(itemIdentifier: quicksortSortToolbarItemID)
        
        item.label = "QUICKSORT"
        item.target = self
        item.action = #selector(openQuicksortSortingViewController)
        
        return item
    }()
    
    private let heapSortToolbarItemID = NSToolbarItem.Identifier("Heap sort")
    private lazy var heapSortToolbarItem: NSToolbarItem = {
        let item = NSToolbarItem(itemIdentifier: heapSortToolbarItemID)
        
        item.label = "Heap"
        item.target = self
        item.action = #selector(openHeapSortingViewController)
        
        return item
    }()
    
    // MARK: - Lifecycle funcions
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        let contentView = NSView()
        contentView.wantsLayer = true
        contentView.layer?.backgroundColor = NSColor.red.cgColor
        contentViewController?.view.addSubview(contentView)
        
        toolbar.delegate = self
        toolbar.autosavesConfiguration = true
        toolbar.displayMode = .default
        
        window?.toolbar = self.toolbar
    }
    
    private func setupGraphView(sortingAlgorithm: SortingAlgorithm) {
        guard let contentViewController = self.contentViewController else { return }
        
        if sortingView != nil {
            sortingView?.removeFromSuperview()
            sortingView = nil
        }
        
        if sortingView == nil {
            sortingView = SortingView(sortingArray: sortingArray, sortingAlgorithm: sortingAlgorithm)
        }
        
        guard let insertionSortView = self.sortingView else { return }
        
        contentViewController.view.subviews.removeAll()
        contentViewController.view.addSubview(insertionSortView)
        insertionSortView.constraints(edgesTo: contentViewController.view)
    }
    
    // MARK: - Actions

    @objc private func showInsertionSortingViewController() {
        setupGraphView(sortingAlgorithm: .insert)
    }
    
    @objc private func openMedianSortingViewController() {
        setupGraphView(sortingAlgorithm: .median)        
    }
    
    @objc private func openQuicksortSortingViewController() {
        setupGraphView(sortingAlgorithm: .quicksort)
    }
    
    @objc private func openHeapSortingViewController() {
        setupGraphView(sortingAlgorithm: .heap)
    }
}

extension WindowsController: NSToolbarDelegate {
    
    // MARK: NSToolbar Delegate
    
    func toolbarItems() -> [NSToolbarItem.Identifier] {
        return toolbarItemIdentifiers
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarItemIdentifiers
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarItemIdentifiers
    }
    
    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return toolbarItemIdentifiers
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        switch itemIdentifier {
        case insertionSortToolbarItemID:
            return insertionSortToolbarItem
        case medianSortToolbarItemID:
            return medianSortToolbarItem
        case quicksortSortToolbarItemID:
            return quicksortSortToolbarItem
        case heapSortToolbarItemID:
            return heapSortToolbarItem
        default:
            return nil
        }
    }
}
