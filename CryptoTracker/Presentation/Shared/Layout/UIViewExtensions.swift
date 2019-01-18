//
//  UIViewExtensions.swift
//  CryptoTracker
//
//  Created by Guillermo Zafra on 15/01/2019.
//  Copyright © 2019 Guillermo Zafra. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult func addConstraintsWithFormat(_ format: String, views: UIView...) -> [NSLayoutConstraint] {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary)
        addConstraints(constraints)
        
        return constraints
    }
    
    func autoPinEdges(to superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
}
