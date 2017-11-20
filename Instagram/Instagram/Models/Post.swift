//  Post.swift
//  Instagram
//  Created by Anthony Washington on 11/5/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import Foundation

struct Post {
    let user: User
    let caption: String
    let image_url: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        self.image_url = dictionary["image_url"] as? String ?? ""
    }
}
