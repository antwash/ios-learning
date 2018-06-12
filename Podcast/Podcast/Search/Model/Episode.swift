//  Episode.swift
//  Podcast
//  Created by Anthony Washington on 6/10/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import FeedKit

struct Episode {
    
    let title : String
    let pubDate : Date
    let imageURL : String
    let description : String
    
    init(feedItem: RSSFeedItem, parentImage: String) {
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.description ?? ""
        self.imageURL = feedItem.iTunes?.iTunesImage?.attributes?.href ?? parentImage
    }
}
