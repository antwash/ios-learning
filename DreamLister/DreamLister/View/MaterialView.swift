//  MaterialView.swift
//  DreamLister
//
//  Created by Anthony Washington on 9/9/16.
//  Copyright © 2016 Anthony Washington. All rights reserved.
//

import UIKit

private var materialKey = false


// any view that inherit and inspectable is TRUE will use below customization
extension UIView {

    @IBInspectable var materialDesign: Bool {
        
        get { return materialKey }
        set {
            
            materialKey = newValue
            
            if materialKey {
                
                self.layer.shadowRadius = 3.0
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.masksToBounds = false
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
            
            }
            else {

                self.layer.shadowRadius = 0
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowColor = nil
            
            }
        }
    }

}
