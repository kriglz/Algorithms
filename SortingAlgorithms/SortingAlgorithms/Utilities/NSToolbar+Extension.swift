//
//  NSToolbar+Extension.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/16/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import Cocoa

extension NSToolbar {
    
    /// Returns an item for toolbar item idenfifier.
    func item(for identifier: NSToolbarItem.Identifier) -> NSToolbarItem? {
        for item in self.items {
            if item.itemIdentifier == identifier {
                return item
            }
        }
        return nil
    }
}
