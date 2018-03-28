//  EpisodeCell.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/27/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit

class EpisodeCell: UITableViewCell {

    var feedEpisode: Episode? {
        didSet {
            guard let feed = feedEpisode else { return }

            let url = URL(string: feed.imageURL)
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM dd, yyyy"

            episodeDate.text = dateFormatter.string(from: feed.pubDate)
            episodeTitle.text = feed.title
            episodeDescription.text = feed.description
            episodeImage.sd_setImage(with: url, completed: nil)
        }
    }

    let episodeImage: UIImageView = {
        let e = UIImageView()
        return e
    }()

    let episodeDate: UILabel = {
        let e = UILabel()
            e.textColor = .purple
            e.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return e
    }()

    let episodeTitle: UILabel = {
        let e = UILabel()
            e.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            e.numberOfLines = 2
        return e
    }()

    let episodeDescription: UILabel = {
        let e = UILabel()
            e.numberOfLines = 2
            e.textColor = .lightGray
            e.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        return e
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let stackView = UIStackView(arrangedSubviews: [episodeDate,
                                                       episodeTitle,
                                                       episodeDescription])
            stackView.axis = .vertical
            stackView.spacing = 5

        addSubview(episodeImage)
        addSubview(stackView)

        episodeImage.anchor(top: topAnchor, topPad: 16, bottom: nil,
                            bottomPad: 0, left: leftAnchor, leftPad: 8,
                            right: nil, rightPad: 0, height: 100, width: 100)
        stackView.anchor(top: nil, topPad: 0, bottom: nil, bottomPad: 0,
                         left: episodeImage.rightAnchor, leftPad: 8, right: rightAnchor,
                         rightPad: 8, height: 0, width: 0)
        stackView.centerYAnchor.constraint(equalTo: episodeImage.centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
