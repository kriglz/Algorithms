//
//  WindowsController.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/14/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

class WindowsController: NSWindowController {
    
    let sortingArray = [15, 09, 08, 01, 04, 11, 07, 12, 13, 06, 05, 03, 16, 02, 10, 14]
//    let sortingArray = [15, 02, 11, 09, 1]

    // MARK: - Properties
    
    let toolbar = NSToolbar()
    
    lazy var toolbarItemIdentifiers = [insertSortToolbarItemID, medianSortToolbarItemID]
    
    private var sortingView: SortingView?
    
    private let insertSortToolbarItemID = NSToolbarItem.Identifier("insert sort")
    private lazy var insertSortToolbarItem: NSToolbarItem = {
        let item = NSToolbarItem(itemIdentifier: insertSortToolbarItemID)
        
        item.label = "Insert"
        item.target = self
        item.action = #selector(showInsertSortingViewController)
        
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
        
        guard let insertSortView = self.sortingView else { return }
        
        contentViewController.view.subviews.removeAll()
        contentViewController.view.addSubview(insertSortView)
        insertSortView.constraints(edgesTo: contentViewController.view)
    }
    
    // MARK: - Actions

    @objc private func showInsertSortingViewController() {
        setupGraphView(sortingAlgorithm: .insert)
    }
    
    @objc private func openMedianSortingViewController() {
        setupGraphView(sortingAlgorithm: .median)        
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
        case insertSortToolbarItemID:
            return insertSortToolbarItem
        case medianSortToolbarItemID:
            return medianSortToolbarItem
        default:
            return nil
        }
    }
}
