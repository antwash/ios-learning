//
//  HomeDataSource.swift
//  Twitter-Clone
//
//  Created by Anthony Washington on 7/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import LBTAComponents

class HomeDataSource: Datasource {
    
    let users: [User] = {
        let user1 = User(name: "Anthony Washington", userName: "@antdwash",
                         bioText: "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps!", profileImage: #imageLiteral(resourceName: "profile_image"))
        let user2 = User(name: "Ray Wenderlich", userName: "@ayewash",
                         bioText: "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps! iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps! iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps!", profileImage: #imageLiteral(resourceName: "ray_profile_image"))
        
        return [user1, user2]
    }()
    
    let tweets: [Tweet] = {
        let user = User(name: "Anthony Washington", userName: "@antdwash",
                         bioText: "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps!", profileImage: #imageLiteral(resourceName: "profile_image"))
        
        let tweet1 = Tweet(user: user, message: "Testing")
        let tweet2 = Tweet(user: user, message: "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps! iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps! iPhone, iPad, iOS ")
        
        return [tweet1, tweet2]
    }()
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 1 { return tweets.count }
        return users.count
    }
    
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 1 {
            return tweets[indexPath.item]
        }
        return users[indexPath.item]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self, TweetCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
}

