//  EpisodeCell.swift
//  Podcast
//  Created by Anthony Washington on 6/10/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit
import SDWebImage

class EpisodeCell: UITableViewCell {
    
    var imageURL : String? {
        didSet {
            
            if let link = imageURL, !link.isEmpty {
                let url = URL(string: link)
                episodeArtwork.sd_setIndicatorStyle(.gray)
                episodeArtwork.sd_setShowActivityIndicatorView(true)
                episodeArtwork.sd_setImage(with: url, completed: nil)
            } else { episodeArtwork.image = #imageLiteral(resourceName: "appicon") }
        }
    }
    
    var episode : Episode? {
        didSet {
            episodeTitle.text = episode?.title
        }
    }
    
    let episodeArtwork : UIImageView = {
        let e = UIImageView()
            e.clipsToBounds = true
            e.contentMode = .scaleAspectFill
        return e
    }()
    
    let publishDate : UILabel = {
        let p = UILabel()
            p.textColor = .purple
        return p
    }()
    
    let episodeTitle : UILabel = {
        let e = UILabel()
            e.numberOfLines = 2
            e.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return e
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(episodeArtwork)
        addSubview(episodeTitle)
        
        episodeArtwork.anchors(top: topAnchor, topPad: 16, bottom: nil,
                               bottomPad: 0, left: leftAnchor, leftPad: 8,
                               right: nil, rightPad: 0, height: 100, width: 100)
        episodeTitle.anchors(top: topAnchor, topPad: 24, bottom: nil, bottomPad: 0,
                             left: episodeArtwork.rightAnchor, leftPad: 8,
                             right: rightAnchor, rightPad: 16, height: 0, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
