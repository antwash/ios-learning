//  UserSearchCell.swift
//  Instagram
//  Created by Anthony Washington on 11/21/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit

class UserSearchCell: UICollectionViewCell {
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            name.text = user.username
            profile.loadImage(url: user.image_url)
        }
    }
    
    let profile: CustomImageView = {
        let p = CustomImageView()
            p.contentMode = .scaleAspectFill
            p.clipsToBounds = true
        return p
    }()
    
    let name: UILabel = {
        let n = UILabel()
            n.text = "Username"
            n.backgroundColor = .white
        return n
    }()
    
    let divider: UIView = {
        let d = UIView()
            d.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return d
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profile)
        addSubview(name)
        addSubview(divider)
        
        profile.anchors(top: nil, toppad: 0, bottom: nil, bottompad: 0, left: leftAnchor,
                        leftpad: 8, right: nil, rightpad: 0, height: 50, width: 50)
        profile.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profile.layer.cornerRadius = 50 / 2
        
        name.anchors(top: topAnchor, toppad: 0, bottom: bottomAnchor, bottompad: 0,
                     left: profile.rightAnchor, leftpad: 8, right: rightAnchor,
                     rightpad: 8, height: 0, width: 0)
        
        divider.anchors(top: nil, toppad: 0, bottom: bottomAnchor, bottompad: 0,
                        left: name.leftAnchor, leftpad: 0, right: rightAnchor,
                        rightpad: 0, height: 0.5, width: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
