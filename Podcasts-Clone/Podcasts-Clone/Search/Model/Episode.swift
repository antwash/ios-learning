//  Episode.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/27/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import Foundation
import FeedKit

struct Episode {
    let title: String
    let pubDate: Date
    let description: String
    let imageURL: String
    let authorName: String
    let audioURL: String
    
    init(item: RSSFeedItem, image: String) {
        let imageurl = item.iTunes?.iTunesImage?.attributes?.href?.secureHttps() ?? ""
        self.authorName = item.iTunes?.iTunesAuthor ?? ""
        self.title = item.title ?? ""
        self.pubDate = item.pubDate ?? Date()
        self.description = item.description?.replaceHTML() ?? ""
        self.audioURL = item.enclosure?.attributes?.url ?? ""
        self.imageURL = (imageurl == "") ? image.secureHttps() : imageurl.secureHttps()
    }
}
