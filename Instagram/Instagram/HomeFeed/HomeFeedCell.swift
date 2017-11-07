//  HomeFeedCell.swift
//  Instagram
//  Created by Anthony Washington on 11/6/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit

class HomeFeedCell : UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let post = post else { return }
            image.loadImage(url: post.image_url)
        }
    }
    let image: CustomImageView = {
        let i = CustomImageView()
            i.clipsToBounds = true
            i.contentMode = .scaleAspectFill
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(image)
        image.anchors(top: topAnchor, toppad: 0, bottom: bottomAnchor,
                     bottompad: 0, left: leftAnchor, leftpad: 0, right: rightAnchor,
                     rightpad: 0, height: 0, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
