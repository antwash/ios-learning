//  SearchResults.swift
//  Podcast
//  Created by Anthony Washington on 6/10/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

struct SearchResults : Decodable {

    let resultCount : Int
    let results : [Podcast]
}
