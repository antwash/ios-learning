//  ProfileImageCell.swift
//  Instagram
//  Created by Anthony Washington on 11/5/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit

class ProfileImageCell : UICollectionViewCell {

    var post: Post? {
        didSet {
            guard let post = post else { return }
            photo.loadImage(url: post.image_url)
        }
    }
    let photo: CustomImageView = {
        let p = CustomImageView()
            p.clipsToBounds = true
            p.contentMode = .scaleAspectFill
        return p
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photo)
        photo.anchors(top: topAnchor, toppad: 0, bottom: bottomAnchor,
                      bottompad: 0, left: leftAnchor, leftpad: 0, right: rightAnchor,
                      rightpad: 0, height: 0, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
