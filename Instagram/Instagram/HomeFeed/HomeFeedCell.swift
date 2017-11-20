//  HomeFeedCell.swift
//  Instagram
//  Created by Anthony Washington on 11/6/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit

class HomeFeedCell : UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let post = post else { return }
            userName.text = post.user.username
            image.loadImage(url: post.image_url)
            userProfileImage.loadImage(url: post.user.image_url)
            
            let attributedText = NSMutableAttributedString(string:
                post.user.username + " ", attributes: [
                    NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string:
                post.caption, attributes: [NSAttributedStringKey.font:
                    UIFont.systemFont(ofSize: 14)]))
            
            attributedText.append(NSAttributedString(string:
                "\n\n", attributes: [NSAttributedStringKey.font:
                    UIFont.systemFont(ofSize: 4)]))
            
            attributedText.append(NSAttributedString(string:
                "1 week ago", attributes: [NSAttributedStringKey.font:
                    UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor:
                        UIColor.gray]))
            
            caption.attributedText = attributedText
        }
    }
    
    let userProfileImage: CustomImageView = {
        let u = CustomImageView()
            u.clipsToBounds = true
            u.contentMode = .scaleToFill
        return u
    }()
    
    let userName: UILabel = {
        let u = UILabel()
            u.font = UIFont.boldSystemFont(ofSize: 14)
        return u
    }()
    
    let options: UIButton = {
        let o = UIButton(type: .system)
            o.setTitle("•••", for: .normal)
            o.setTitleColor(.black, for: .normal)
        return o
    }()
    
    let image: CustomImageView = {
        let i = CustomImageView()
            i.clipsToBounds = true
            i.contentMode = .scaleAspectFill
        return i
    }()
    
    let like: UIButton = {
        let l = UIButton(type: .system)
            l.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        return l
    }()
    
    let comment: UIButton = {
        let c = UIButton(type: .system)
            c.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        return c
    }()
    
    let share: UIButton = {
        let s = UIButton(type: .system)
            s.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        return s
    }()
    
    let bookmark: UIButton = {
        let b = UIButton(type: .system)
            b.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        return b
    }()
    
    let caption: UILabel = {
        let c = UILabel()
            c.numberOfLines = 0
        return c
    }()
    
    fileprivate func setupUserImage() {
        addSubview(userProfileImage)
        addSubview(userName)
        addSubview(options)
        addSubview(image)
        
        userProfileImage.anchors(top: topAnchor, toppad: 8, bottom: nil, bottompad: 0,
                                 left: leftAnchor, leftpad: 8, right: nil, rightpad: 0,
                                 height: 40, width: 40)
        userProfileImage.layer.cornerRadius = 40 / 2
        options.anchors(top: topAnchor, toppad: 8, bottom: image.topAnchor, bottompad: 8,
                        left: nil, leftpad: 0, right: rightAnchor, rightpad: 0, height: 0,
                        width: 44)
        userName.anchors(top: topAnchor, toppad: 8, bottom: image.topAnchor, bottompad: 8,
                         left: userProfileImage.rightAnchor, leftpad: 8, right: options.leftAnchor,
                         rightpad: 8, height: 0, width: 0)
        image.anchors(top: userProfileImage.bottomAnchor, toppad: 4, bottom: nil,
                      bottompad: 0, left: leftAnchor, leftpad: 0, right: rightAnchor,
                      rightpad: 0, height: 0, width: 0)
        image.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
    }
    
    fileprivate func setUpBottomActions() {
        let stackView = UIStackView(arrangedSubviews: [like, comment, share])
            stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(bookmark)
        addSubview(caption)
        
        stackView.anchors(top: image.bottomAnchor, toppad: 0, bottom: nil, bottompad: 0,
                          left: leftAnchor, leftpad: 4, right: nil, rightpad: 0, height: 40,
                          width: 120)
        
        bookmark.anchors(top: image.bottomAnchor, toppad: 0, bottom: nil, bottompad: 0,
                         left: nil, leftpad: 0, right: rightAnchor, rightpad: 0,
                         height: 40, width: 40)
        
        caption.anchors(top: like.bottomAnchor, toppad: 4, bottom: bottomAnchor,
                        bottompad: 0, left: leftAnchor, leftpad: 8, right: rightAnchor,
                        rightpad: 8, height: 0, width: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUserImage()
        setUpBottomActions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
