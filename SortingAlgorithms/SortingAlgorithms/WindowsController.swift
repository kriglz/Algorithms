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
    
    lazy var toolbarItemIdentifiers = [insertSortToolbarItemID, medianSortToolbarItemID, NSToolbarItem.Identifier.flexibleSpace]
    
    private var insertSortView: InsertSortingView?
    
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
        self.contentViewController?.view.addSubview(contentView)
        
        toolbar.delegate = self
        toolbar.autosavesConfiguration = true
        toolbar.displayMode = .default
        
        self.window?.toolbar = self.toolbar
    }
    
    // MARK: - Actions

    @objc private func showInsertSortingViewController() {
        guard let contentViewController = self.contentViewController else { return }
        
        if insertSortView == nil {
            insertSortView = InsertSortingView(sortingArray: sortingArray)
        }
        
        guard let insertSortView = self.insertSortView else { return }
        
        contentViewController.view.subviews.removeAll()
        contentViewController.view.addSubview(insertSortView)
        insertSortView.constraints(edgesTo: contentViewController.view)
    }
    
    @objc private func openMedianSortingViewController() {
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
