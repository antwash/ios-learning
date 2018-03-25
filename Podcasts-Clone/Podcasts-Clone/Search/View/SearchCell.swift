//  SearchCell.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/24/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit

class SearchCell: UITableViewCell {
    
    var podcast: Podcast? {
        didSet {
            guard let podcast = podcast else { return }
            trackName.text = podcast.trackName
            artistName.text = podcast.artistName
        }
    }
    
    let trackName: UILabel = {
        let t = UILabel()
            t.font = UIFont.boldSystemFont(ofSize: 17)
            t.numberOfLines = 0
        return t
    }()
    
    let artistName: UILabel = {
        let a = UILabel()
            a.font = UIFont.systemFont(ofSize: 16)
            a.numberOfLines = 0
        return a
    }()

    let episodeCount: UILabel = {
        let e = UILabel()
            e.font = UIFont.systemFont(ofSize: 14)
            e.textColor = .darkGray
            e.text = "50 episodes"
        return e
    }()
    
    let podcastImage: UIImageView = {
        let p = UIImageView()
            p.image = #imageLiteral(resourceName: "appicon")
        return p
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(podcastImage)
        addSubview(trackName)
        addSubview(artistName)
        addSubview(episodeCount)
        
        podcastImage.anchor(top: topAnchor, topPad: 8, bottom: nil,
                            bottomPad: 0, left: leftAnchor, leftPad: 8,
                            right: nil, rightPad: 0, height: 100, width: 100)
        trackName.anchor(top: podcastImage.topAnchor, topPad: 4, bottom: nil,
                         bottomPad: 0, left: podcastImage.rightAnchor, leftPad: 8,
                         right: rightAnchor, rightPad: 8, height: 0, width: 0)
        artistName.anchor(top: trackName.bottomAnchor, topPad: 4, bottom: nil,
                          bottomPad: 0, left: trackName.leftAnchor, leftPad: 0,
                          right: rightAnchor, rightPad: 8, height: 0, width: 0)
        episodeCount.anchor(top: artistName.bottomAnchor, topPad: 4, bottom: nil,
                            bottomPad: 0, left: artistName.leftAnchor, leftPad: 0,
                            right: rightAnchor, rightPad: 8, height: 0, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
