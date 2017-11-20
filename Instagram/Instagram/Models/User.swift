//  User.swift
//  Instagram
//  Created by Anthony Washington on 11/5/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import Foundation

struct User {
    let uid: String
    let username: String
    let image_url : String
    
    init(uid: String, dic: [String: String]) {
        self.uid = uid
        self.username = dic["username"] ?? ""
        self.image_url = dic["profile_url"] ?? ""
    }
}
