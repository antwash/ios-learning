//
//  HomeDataSource.swift
//  Twitter-Clone
//
//  Created by Anthony Washington on 7/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import LBTAComponents
import TRON
import SwiftyJSON

class HomeDataSource: Datasource, JSONDecodable {
    
    var users: [User] = []
    var tweets: [Tweet] = []

    required init(json: JSON) throws {
        guard let user_array = json["users"].array else { return }
        guard let tweet_array = json["tweets"].array else { return }
        
        // use swfit maping feature to create users/tweets from json
        self.users = user_array.map({User(json: $0)})
        self.tweets = tweet_array.map({Tweet(json: $0)})
    }
    
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

