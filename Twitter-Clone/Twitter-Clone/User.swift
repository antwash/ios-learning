//
//  User.swift
//  Twitter-Clone
//
//  Created by Anthony Washington on 7/3/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit
import SwiftyJSON
import TRON


struct User: JSONDecodable {
    let name: String
    let userName: String
    let bioText: String
    let profileImageURL: String

    init(json: JSON) {
        self.name = json["name"].stringValue
        self.userName = json["username"].stringValue
        self.bioText = json["bio"].stringValue
        self.profileImageURL = json["profileImageUrl"].stringValue
    }
}
