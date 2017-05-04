//
//  Extensions.swift
//  IG-Remake
//
//  Created by Anthony Washington on 4/27/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit


extension UIColor {

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}



extension UIView {
    func anchors(top: NSLayoutYAxisAnchor?, topPad: CGFloat?, bottom: NSLayoutYAxisAnchor?, bottomPad: CGFloat?,
                 left: NSLayoutXAxisAnchor?, leftPad: CGFloat?, right: NSLayoutXAxisAnchor?, rightPad: CGFloat?,
                 height: CGFloat?, width: CGFloat?){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: bottomPad!).isActive = true
        }
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: topPad!).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: leftPad!).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -rightPad!).isActive = true
        }
        
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
    
}
