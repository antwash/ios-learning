//  Extensions.swift
//  Podcast
//  Created by Anthony Washington on 6/9/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit
import AVKit

extension String {
    func replaceHTML() -> String {
        let text = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return text.replacingOccurrences(of: "<[^>]+>", with:
            "", options: .regularExpression, range: nil)
    }
}

extension CMTime {
    
    func toDisplayString() -> String {
        if CMTimeGetSeconds(self).isNaN {
            return "--:--"
        }
        
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds % (60 * 60) / 60
        let hours = totalSeconds / 60 / 60
        let timeFormatString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        return timeFormatString
    }
    
}

extension UIView {
    func anchors(top: NSLayoutYAxisAnchor?, topPad: CGFloat,
                 bottom: NSLayoutYAxisAnchor?, bottomPad: CGFloat,
                 left: NSLayoutXAxisAnchor?, leftPad: CGFloat,
                 right: NSLayoutXAxisAnchor?, rightPad: CGFloat,
                 height: CGFloat, width: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top,
                                      constant: topPad).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom,
                                         constant: -bottomPad).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left,
                                       constant: leftPad).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right,
                                        constant: -rightPad).isActive = true
        }
        
        if height > 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if width > 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
