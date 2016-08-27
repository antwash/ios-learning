//
//  VideoCell.swift
//  YouTubeAppDemo
//
//  Created by Anthony Washington on 8/22/16.
//  Copyright © 2016 Anthony Washington. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet weak var _label: UILabel!
    @IBOutlet weak var _image: UIImageView!
    
    // MARK: - Functions
    func updateUI(aVideo: SingleVideo){
        _label.text = aVideo.title
        
        //(TODO): Download image
        if let url = NSURL(string: aVideo.imageThumbNail){

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { 
                
                let request = NSURLRequest(URL: url)
                let session = NSURLSession.sharedSession()
                let dataJob = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                    
                    // update UI on main thread
                    dispatch_async(dispatch_get_main_queue(), {  self._image.image = UIImage(data: data!) })
                })
                dataJob.resume()
            })
            
        }
    }// updateUI
    
    
}
