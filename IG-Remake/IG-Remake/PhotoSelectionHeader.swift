//
//  PhotoSelectionHeader.swift
//  IG-Remake
//
//  Created by Anthony Washington on 7/11/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit

class PhotoSelectionHeader: UICollectionViewCell {
    
    let image: UIImageView = {
        let i = UIImageView()
            i.clipsToBounds = true
            i.contentMode = .scaleAspectFill
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(image)
        image.anchors(top: topAnchor, topPad: 0, bottom: bottomAnchor,
                      bottomPad: 0, left: leftAnchor, leftPad: 0,
                      right: rightAnchor, rightPad: 0, height: 0, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
