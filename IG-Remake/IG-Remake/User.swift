//
//  User.swift
//  IG-Remake
//
//  Created by Anthony Washington on 5/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

class User {
    var userName: String?
    var imageURL: String?
    
    init(dictionary: [String: Any]) {
        self.userName = dictionary["user_name"] as? String ?? ""
        self.imageURL = dictionary["profile_image"] as? String ?? ""
    }
}
