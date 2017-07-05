//
//  User.swift
//  Twitter-Clone
//
//  Created by Anthony Washington on 7/3/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit
import SwiftyJSON


struct User {
    let name: String
    let userName: String
    let bioText: String
    let profileImage: UIImage
    
    init(name: String, userName: String, bioText: String, profileImage: UIImage) {
        self.name = name
        self.userName = userName
        self.bioText = bioText
        self.profileImage = profileImage
    }
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.userName = json["username"].stringValue
        self.bioText = json["bio"].stringValue
        self.profileImage = UIImage()
    }
}
