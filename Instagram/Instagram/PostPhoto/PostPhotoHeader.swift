//  PostPhotoHeader.swift
//  Instagram
//  Created by Anthony Washington on 11/4/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit

class PostPhotoHeader: UICollectionViewCell {
    
    let photo: UIImageView = {
        let p = UIImageView()
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
