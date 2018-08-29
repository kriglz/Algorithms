//
//  UIView+Extension.swift
//  GraphAlgorithms
//
//  Created by Kristina Gelzinyte on 8/29/18.
//  Copyright © 2018 Kristina Gelzinyte. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Applies constriants to the specified view edges.
    func constraints(edgesTo view: UIView, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant))
        constraints.append(self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant))
        constraints.append(self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant))
        constraints.append(self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant))
        
        NSLayoutConstraint.activate(constraints)
    }
}

