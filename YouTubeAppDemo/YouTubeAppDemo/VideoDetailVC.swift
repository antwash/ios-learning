//
//  VideoVC.swift
//  YouTubeAppDemo
//
//  Created by Anthony Washington on 8/22/16.
//  Copyright © 2016 Anthony Washington. All rights reserved.
//

import UIKit

class VideoDetailVC: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var _titleLabel: UILabel!
    @IBOutlet weak var webViewHeight: NSLayoutConstraint!
    
    // MARK: - Properties
    var selectedVideo: SingleVideo!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        if let viewVideo = self.selectedVideo {
           // self._titleLabel.text = viewVideo.title
            
            let width = self.view.frame.size.width
            let height = (width / 320) * 180
            
            self.webViewHeight.constant = height
            let html = "<iframe width=\"\(width)\" height=\"\(height)\" src=\"https://www.youtube.com/embed/\(viewVideo.videoURL)\" frameborder=\"0\" allowfullscreen></iframe>"
            
            self.webView.loadHTMLString(html, baseURL: nil)
        }
    }
}


