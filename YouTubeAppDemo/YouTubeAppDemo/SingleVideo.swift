//  Video.swift
//  YouTubeAppDemo
//
//  Created by Anthony Washington on 8/22/16.
//  Copyright © 2016 Anthony Washington. All rights reserved.
//

import Foundation

class SingleVideo {

     // MARK: - @Properties
    private var _title: String!
    private var _videoURL: String!
    private var _imageThumbNail: String!
    

    // MARK: - @Initialize
    init(title: String, videoURL: String, imageThumbnail: String){
        self._title = title
        self._videoURL = videoURL
        self._imageThumbNail = imageThumbnail
    }
    
    // MARK: - Functions
    var title: String { return _title }
    var imageThumbNail: String{ return _imageThumbNail }
    var videoURL: String { return _videoURL}
    
    
}
