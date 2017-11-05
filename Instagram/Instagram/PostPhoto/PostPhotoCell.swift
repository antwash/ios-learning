//  PostPhotoCell.swift
//  Instagram
//  Created by Anthony Washington on 11/4/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit

class PostPhotoCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
