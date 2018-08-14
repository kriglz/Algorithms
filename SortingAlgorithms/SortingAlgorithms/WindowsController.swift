//
//  WindowsController.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/14/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

class WindowsController: NSWindowController {
    
    // MARK: - Properties
    
    let toolbar = NSToolbar()
    
    lazy var toolbarItemIdentifiers = [insertSortToolbarItemID, medianSortToolbarItemID, NSToolbarItem.Identifier.flexibleSpace]
    
    private let insertSortToolbarItemID = NSToolbarItem.Identifier("insert sort")
    private lazy var insertSortToolbarItem: NSToolbarItem = {
        let item = NSToolbarItem(itemIdentifier: insertSortToolbarItemID)
        
        item.label = "Insert"
        item.target = self
        item.action = #selector(openInsertSortingViewController)

        item.image = NSImage(named: NSImage.Name(rawValue: "icon"))
        
        return item
    }()
    
    private let medianSortToolbarItemID = NSToolbarItem.Identifier("Median sort")
    private lazy var medianSortToolbarItem: NSToolbarItem = {
        let item = NSToolbarItem(itemIdentifier: medianSortToolbarItemID)
        
        item.label = "Median"
        item.target = self
        item.action = #selector(openMedianSortingViewController)
        
        item.image = NSImage(named: NSImage.Name(rawValue: "icon"))
        
        return item
    }()
    
    // MARK: - Lifecycle funcions
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        toolbar.delegate = self
        toolbar.autosavesConfiguration = true
        toolbar.displayMode = .default
        
        self.window?.toolbar = self.toolbar
    }
    
    // MARK: - Actions

    @objc private func openInsertSortingViewController() {
        print("insert")
    }
    
    @objc private func openMedianSortingViewController() {
        print("median")
    }
}

extension WindowsController: NSToolbarDelegate {
    
    // MARK: NSToolbar Delegate
    
    override func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        return true
    }
    
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

extension NSToolbar {
    
    func item(for identifier: NSToolbarItem.Identifier) -> NSToolbarItem? {
        for item in self.items {
            if item.itemIdentifier == identifier {
                return item
            }
        }
        return nil
    }
}
