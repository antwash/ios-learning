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

extension Collection where Iterator.Element == JSON{
    
    func decode<T: JSONDecodable>() throws -> [T] {
        return try map({try T(json: $0)})
    }
}


class HomeDataSource: Datasource, JSONDecodable {
    
    var users: [User] = []
    var tweets: [Tweet] = []

    required init(json: JSON) throws {
        guard let user_array = json["users"].array, let tweet_array = json["tweets"].array else {
            throw  NSError(domain: "com.letsbuildthatapp", code: 411,
                           userInfo: [NSLocalizedDescriptionKey:
                            "Parsing JSON not in valid JSON format."])
        }

        // use generic fuction
        self.users = try user_array.decode()
        self.tweets = try tweet_array.decode()
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

