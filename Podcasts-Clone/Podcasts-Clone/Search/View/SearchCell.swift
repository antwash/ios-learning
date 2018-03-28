//  SearchCell.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/24/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit
import SDWebImage

class SearchCell: UITableViewCell {

    var podcast: Podcast? {
        didSet {
            guard let podcast = podcast else { return }
            trackName.text = podcast.trackName
            artistName.text = podcast.artistName
            episodeCount.text = "\(podcast.trackCount ?? 0) Episodes"

            let url = URL(string: podcast.artworkUrl600)
            podcastImage.sd_setImage(with: url, completed: nil)
        }
    }
    
    let trackName: UILabel = {
        let t = UILabel()
            t.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            t.numberOfLines = 2
        return t
    }()
    
    let artistName: UILabel = {
        let a = UILabel()
            a.font = UIFont.systemFont(ofSize: 16)
        return a
    }()

    let episodeCount: UILabel = {
        let e = UILabel()
            e.font = UIFont.systemFont(ofSize: 14)
            e.textColor = .darkGray
        return e
    }()
    
    let podcastImage: UIImageView = {
        let p = UIImageView()
        return p
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [trackName,
                                                       artistName,
                                                       episodeCount])
            stackView.spacing = 5
            stackView.axis = .vertical
        
        addSubview(podcastImage)
        addSubview(stackView)
        
        podcastImage.anchor(top: topAnchor, topPad: 16, bottom: nil,
                            bottomPad: 0, left: leftAnchor, leftPad: 8,
                            right: nil, rightPad: 0, height: 100, width: 100)
        stackView.anchor(top: nil, topPad: 0, bottom: nil,
                         bottomPad: 0, left: podcastImage.rightAnchor, leftPad: 8,
                         right: rightAnchor, rightPad: 8, height: 0, width: 0)
        stackView.centerYAnchor.constraint(equalTo: podcastImage.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
