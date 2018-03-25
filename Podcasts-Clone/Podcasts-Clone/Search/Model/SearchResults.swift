//  SearchResults.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/24/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import Foundation

struct SearchResults : Decodable {
    let resultCount: Int
    let results: [Podcast]
}
