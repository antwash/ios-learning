//  Podcast.swift
//  Podcast
//  Created by Anthony Washington on 6/9/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

struct Podcast : Decodable {
    
    var feedUrl: String?
    var trackCount: Int?
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
}
