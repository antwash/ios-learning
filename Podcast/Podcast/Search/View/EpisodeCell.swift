//  EpisodeCell.swift
//  Podcast
//  Created by Anthony Washington on 6/10/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit
import SDWebImage

class EpisodeCell: UITableViewCell {

    var episode : Episode! {
        didSet {
            
            let dateFormat = DateFormatter()
                dateFormat.dateFormat = "MMM dd, yyyy"

            episodeTitle.text = episode.title
            episodeDescription.text = episode.description.replaceHTML()
            publishDate.text = dateFormat.string(from: episode.pubDate)
            
            if episode.imageURL.isEmpty {
                episodeArtwork.image = #imageLiteral(resourceName: "appicon")
            } else {
                let url = URL(string: episode.imageURL)
                episodeArtwork.sd_setIndicatorStyle(.gray)
                episodeArtwork.sd_setShowActivityIndicatorView(true)
                episodeArtwork.sd_setImage(with: url, completed: nil)
            }
        }
    }
    
    let episodeArtwork : UIImageView = {
        let e = UIImageView()
            e.clipsToBounds = true
            e.layer.cornerRadius = 10
            e.contentMode = .scaleAspectFill
        return e
    }()
    
    let publishDate : UILabel = {
        let p = UILabel()
            p.textColor = .purple
            p.font = UIFont.boldSystemFont(ofSize: 15)
        return p
    }()
    
    let episodeTitle : UILabel = {
        let e = UILabel()
            e.numberOfLines = 2
            e.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return e
    }()
    
    let episodeDescription : UILabel = {
        let e = UILabel()
            e.numberOfLines = 2
            e.textColor = .lightGray
            e.font = UIFont.systemFont(ofSize: 15)
        return e
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(episodeArtwork)
        addSubview(publishDate)
        addSubview(episodeTitle)
        addSubview(episodeDescription)
        
        episodeArtwork.anchors(top: topAnchor, topPad: 16, bottom: nil,
                               bottomPad: 0, left: leftAnchor, leftPad: 8,
                               right: nil, rightPad: 0, height: 100, width: 100)
        publishDate.anchors(top: topAnchor, topPad: 20, bottom: nil, bottomPad: 0,
                            left: episodeArtwork.rightAnchor, leftPad: 8,
                            right: rightAnchor, rightPad: 16, height: 0, width: 0)
        episodeTitle.anchors(top: publishDate.bottomAnchor, topPad: 2, bottom: nil,
                             bottomPad: 0, left: episodeArtwork.rightAnchor, leftPad: 8,
                             right: rightAnchor, rightPad: 16, height: 0, width: 0)
        episodeDescription.anchors(top: episodeTitle.bottomAnchor, topPad: 4,
                                   bottom: nil, bottomPad: 0, left: episodeTitle.leftAnchor,
                                   leftPad: 0, right: episodeTitle.rightAnchor, rightPad: 0,
                                   height: 0, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
