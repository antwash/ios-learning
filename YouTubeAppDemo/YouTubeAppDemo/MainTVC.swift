//
//  MainTVC.swift
//  YouTubeAppDemo
//
//  Created by Anthony Washington on 8/22/16.
//  Copyright © 2016 Anthony Washington. All rights reserved.
//

import UIKit

class MainTVC: UITableViewController, VideoModelDelegate {
    
    let allVideos: AllVideos = AllVideos()
    private var videos: [SingleVideo] = []
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allVideos.delegate = self
        allVideos.getVideoFeed()
    }

    
    // MARK: - AllVideo model delegate methods
    func dataReady() {
        self.videos = self.allVideos.getAllVideo()
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view delegate methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (self.view.frame.size.width / 320 ) * 180
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
       if let cell = tableView.dequeueReusableCellWithIdentifier("videoCell", forIndexPath: indexPath) as? VideoCell{
            
            let video = videos[indexPath.row]
        
                cell.updateUI(video)
            return cell
        }
       else{ return UITableViewCell() }
    }
}
