//  Episode.swift
//  Podcast
//  Created by Anthony Washington on 6/10/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import FeedKit

struct Episode {
    
    let title : String
    let pubDate : Date
    let author : String
    let imageURL : String
    let audioURL : String
    let description : String
    
    init(feedItem: RSSFeedItem, parentImage: String) {
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.description ?? ""
        self.author = feedItem.iTunes?.iTunesAuthor ?? ""
        self.audioURL = feedItem.enclosure?.attributes?.url ?? ""
        self.imageURL = feedItem.iTunes?.iTunesImage?.attributes?.href ?? parentImage
    }
}
