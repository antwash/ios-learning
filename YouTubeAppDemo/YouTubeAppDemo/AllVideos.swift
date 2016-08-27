//
//  AllVideos.swift
//  YouTubeAppDemo
//
//  Created by Anthony Washington on 8/27/16.
//  Copyright © 2016 Anthony Washington. All rights reserved.
//
import Alamofire
import Foundation


protocol VideoModelDelegate { func dataReady() }


class AllVideos{
    
    var delegate: VideoModelDelegate?
    var allvideos: [SingleVideo] = []
    let API_KEY = "AIzaSyBJ4ql3dpQSGHT1u2V5LuWepVmKkL6nstM"


    func getVideoFeed(){
        
        // Use Youtube api to get videos
        Alamofire.request(.GET, "https://www.googleapis.com/youtube/v3/search",
            parameters: ["part":"snippet", "q":"starlito", "type":"video", "maxResults":"50", "key":API_KEY],
            encoding: ParameterEncoding.URL, headers: nil).responseJSON { ( response ) in
                
               if let JSON = response.result.value{
                
                for video in JSON["items"] as! NSArray{
                    let title = video.valueForKeyPath("snippet.title") as! String
                    let videoId = video.valueForKeyPath("id.videoId") as! String
                    let thumbnail = video.valueForKeyPath("snippet.thumbnails.high.url") as! String
                    self.allvideos.append(SingleVideo(title: title, videoURL: videoId, imageThumbnail: thumbnail))
                }
                
                // tell the delegate data is ready implement method
                if self.delegate != nil { self.delegate!.dataReady() }
            }
        }
    }
    
    //returns all videos
    func getAllVideo() -> [SingleVideo] { return self.allvideos }
    
    
    
}