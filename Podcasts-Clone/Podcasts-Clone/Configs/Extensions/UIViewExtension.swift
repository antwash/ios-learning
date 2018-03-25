//  UIViewExtension.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/25/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, topPad: CGFloat,
                bottom: NSLayoutYAxisAnchor?, bottomPad: CGFloat,
                left: NSLayoutXAxisAnchor?, leftPad: CGFloat,
                right: NSLayoutXAxisAnchor?, rightPad: CGFloat,
                height: CGFloat, width: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top { self.topAnchor.constraint(equalTo:
            top, constant: topPad).isActive = true }
        
        if let bottom = bottom { self.bottomAnchor.constraint(equalTo:
            bottom, constant: -bottomPad).isActive = true }
        
        if let left = left { self.leftAnchor.constraint(equalTo:
            left, constant: leftPad).isActive = true }
        
        if let right = right { self.rightAnchor.constraint(equalTo:
            right, constant: -rightPad).isActive = true }
        
        if height > 0 { self.heightAnchor.constraint(equalToConstant:
            height).isActive = true }
        if width > 0 { self.widthAnchor.constraint(equalToConstant:
            width).isActive = true }
    }
}
