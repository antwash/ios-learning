//  PodcastCell.swift
//  Podcast
//  Created by Anthony Washington on 6/9/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit
import SDWebImage

class PodcastCell: UITableViewCell {
    
    var podcast : Podcast? {
        didSet {
            
            guard let podcast = podcast else { return }
            podcastName.text = podcast.trackName ?? ""
            podcastArtistName.text = podcast.artistName ?? ""
            
            let count = podcast.trackCount ?? 0
            let episode = (count > 1 || count == 0) ? "episodes" : "episode"
            podcastEpisodeCount.text = "\(count) \(episode)"

            if let link = podcast.artworkUrl600, !link.isEmpty {
                let url = URL(string: link)
                podcastArtWork.sd_setIndicatorStyle(.gray)
                podcastArtWork.sd_setShowActivityIndicatorView(true)
                podcastArtWork.sd_setImage(with: url, completed: nil)
            } else {
                podcastArtWork.image = #imageLiteral(resourceName: "appicon")
            }
        }
    }
    
    let podcastName : UILabel = {
        let p = UILabel()
            p.numberOfLines = 2
            p.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return p
    }()
    
    let podcastArtistName : UILabel = {
        let p = UILabel()
            p.font = UIFont.systemFont(ofSize: 16)
        return p
    }()
    
    let podcastEpisodeCount : UILabel = {
        let p = UILabel()
            p.textColor = .darkGray
            p.font = UIFont.systemFont(ofSize: 14)
        return p
    }()
    
    let podcastArtWork : UIImageView = {
        let p = UIImageView()
            p.clipsToBounds = true
            p.contentMode = .scaleAspectFill
        return p
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [podcastName,
                                                       podcastArtistName,
                                                       podcastEpisodeCount])
            stackView.spacing = 5
            stackView.axis = .vertical
            stackView.distribution = .fillProportionally
        
        addSubview(podcastArtWork)
        addSubview(stackView)
        
        podcastArtWork.anchors(top: topAnchor, topPad: 16, bottom: nil,
                               bottomPad: 0, left: leftAnchor, leftPad: 16,
                               right: nil, rightPad: 0, height: 100, width: 100)
        stackView.anchors(top: topAnchor, topPad: 24, bottom: nil,
                          bottomPad: 0, left: podcastArtWork.rightAnchor,
                          leftPad: 8, right: rightAnchor, rightPad: 8,
                          height: 0, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
