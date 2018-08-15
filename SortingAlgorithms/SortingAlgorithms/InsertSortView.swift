//
//  InsertSortView.swift
//  SortingAlgorithms
//
//  Created by Kristina Gelzinyte on 8/14/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import AppKit

class InsertSortView: NSView {
    
    // MARK: - Properties
    
    var sortingArray: [Int] = []
    
    let nodeWidth = 20
    
    // MARK: - Lifecycle functions
    
    convenience init(sortingArray: [Int]) {
        self.init(frame: .zero)

        self.sortingArray = sortingArray
        
        setupSortingView()

        let sortButton = NSButton(title: "SORT", target: self, action: #selector(sortArrayAction(_:)))
        sortButton.frame.origin = CGPoint(x: 500, y: 30)
        addSubview(sortButton)
    }
    
    // MARK: - Setup sorting view
    
    private func setupSortingView() {
        for (index, number) in sortingArray.enumerated() {
            
            let rect = NSRect(x: Double(index * nodeWidth) * 1.2 + 30.0,
                              y: 30.0,
                              width: Double(nodeWidth),
                              height: 10 * Double(number))
            
            let node = Node(frame: rect)
            node.id = index
            
            node.wantsLayer = true
            node.layer?.backgroundColor = NSColor.white.cgColor
            node.layer?.borderColor = NSColor.blue.cgColor
            
            self.addSubview(node)
        }
    }
    
    // MARK: - Actions

    @objc private func sortArrayAction(_ sende: NSButton) {
        sortArray(animated: true)
    }
    
    // MARK: - Sorting
    
    private func sortArray(animated: Bool = false) {
        for index in 1..<sortingArray.count {
            var previousIndex = index - 1
            
            while (previousIndex >= 0 && compare(numberA: sortingArray[previousIndex], numberB: sortingArray[previousIndex + 1]) > 0) {
                sortingArray.swapAt(previousIndex, previousIndex + 1)

                if animated {
                    animateSwapingElements(previousIndex, j: previousIndex + 1)
                }
                
                previousIndex -= 1
            }
        }
    }
    
    private func compare(numberA: Int, numberB: Int) -> Int {
        if numberA > numberB {
            return 1
        }
        return 0
    }
    
    private func animateSwapingElements(_ i: Int, j: Int) {
        let iElement = self.subviews.first { view -> Bool in
            if let node = view as? Node, node.id == i {
                return true
            }
            return false
        }
        
        let jElement = self.subviews.first { view -> Bool in
            if let node = view as? Node, node.id == j {
                return true
            }
            return false
        }
        
        guard let iNode = iElement, let jNode = jElement else { return }
        let delta = iNode.frame.origin.x - jNode.frame.origin.x // negative value
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.5
        
            iNode.frame.origin.x -= delta
            jNode.frame.origin.x += delta
            
        }, completionHandler: nil)
    }
}

class Node: NSView {
    
    var id: Int?
}
