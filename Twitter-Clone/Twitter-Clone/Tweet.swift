//
//  Tweet.swift
//  Twitter-Clone
//
//  Created by Anthony Washington on 7/4/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Tweet {
    let user: User
    let message: String
    
    init(user: User, message: String) {
        self.user = user
        self.message = message
    }
    
    init(json: JSON) {
        self.user = User(json: json["user"])
        self.message = json["message"].stringValue
    }
}
