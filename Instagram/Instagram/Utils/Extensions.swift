//  Extensions.swift
//  Instagram
//  Created by Anthony Washington on 10/30/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit
import Firebase

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(displayP3Red: red / 255, green: green / 255, blue: blue / 255, alpha: 1.0)
    }
}

extension Date {
    static func timeAgo(dateObj: Date) -> String {
        let seconds = Int(Date().timeIntervalSince(dateObj))
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
    
        let quotient: Int
        let unit: String
        
        if (seconds < minute) {
            quotient = seconds
            unit = "second"
        } else if (seconds < hour) {
            quotient = seconds / minute
            unit = "min"
        } else if (seconds < day) {
            quotient = seconds / hour
            unit = "hour"
        } else if (seconds < week) {
            quotient = seconds / day
            unit = "day"
        } else if (seconds < month) {
            quotient = seconds / week
            unit = "week"
        } else {
            quotient = seconds / month
            unit = "month"
        }
        
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
    }
}

extension UIView {
    func anchors(top: NSLayoutYAxisAnchor?, toppad: CGFloat, bottom: NSLayoutYAxisAnchor?, bottompad: CGFloat,
                 left: NSLayoutXAxisAnchor?, leftpad: CGFloat, right: NSLayoutXAxisAnchor?, rightpad: CGFloat,
                 height: CGFloat, width: CGFloat) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top { self.topAnchor.constraint(equalTo: top, constant: toppad).isActive = true }
        if let bottom = bottom { self.bottomAnchor.constraint(equalTo: bottom, constant: -bottompad).isActive = true }
        if let left = left { self.leftAnchor.constraint(equalTo: left, constant: leftpad).isActive = true }
        if let right = right { self.rightAnchor.constraint(equalTo: right, constant: -rightpad).isActive = true }
        if height > 0 { self.heightAnchor.constraint(equalToConstant: height).isActive = true }
        if width > 0 { self.widthAnchor.constraint(equalToConstant: width).isActive = true }
    }
}

extension Database {
    static func fetchUserWithId(uid: String, completion: @escaping (User?, Error?) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of:
            .value, with: { (snapshot) in
                guard let values = snapshot.value as? [String: String] else { return }
                let user = User(uid: uid, dic: values)
                completion(user, nil)
        }) { (error) in
            print("Failed to get user:", error)
            completion(nil, error)
        }
    }
}
