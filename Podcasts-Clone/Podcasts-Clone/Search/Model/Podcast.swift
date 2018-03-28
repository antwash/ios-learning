//  Podcast.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/24/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import Foundation

struct Podcast : Decodable {
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String
    var trackCount: Int?
    var feedUrl: String?
}
