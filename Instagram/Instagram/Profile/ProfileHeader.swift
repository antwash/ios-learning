//  ProfileHeader.swift
//  Instagram
//  Created by Anthony Washington on 11/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.

import UIKit

class ProfileHeader: UICollectionViewCell {
    
    var user: User? {
        didSet {
            setProfileImage()
            setUserStatsLabels()
        }
    }
    
    let userName: UILabel = {
        let u = UILabel()
            u.font = UIFont.boldSystemFont(ofSize: 14)
        return u
    }()
    
    let profile_image: CustomImageView = {
        let p = CustomImageView()
            p.backgroundColor = .white
        return p
    }()
    
    let post: UILabel = {
        let p = UILabel()
            p.numberOfLines = 0
            p.textAlignment = .center
        return p
    }()
    
    let followers: UILabel = {
        let f = UILabel()
            f.numberOfLines = 0
            f.textAlignment = .center
        return f
    }()
    
    let following: UILabel = {
        let f = UILabel()
            f.numberOfLines = 0
            f.textAlignment = .center
        return f
    }()
    
    let edit: UIButton = {
        let e = UIButton(type: .system)
            e.layer.borderWidth = 1
            e.layer.cornerRadius = 3
            e.setTitleColor(.black, for: .normal)
            e.setTitle("Edit Profile", for: .normal)
            e.layer.borderColor = UIColor.lightGray.cgColor
            e.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return e
    }()
    
    let grid: UIButton = {
        let g = UIButton(type: .system)
            g.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return g
    }()
    
    let list: UIButton = {
        let l = UIButton(type: .system)
            l.setImage(#imageLiteral(resourceName: "list"), for: .normal)
            l.tintColor = UIColor(white: 0, alpha: 0.2)
        return l
    }()
    
    let bookmark: UIButton = {
        let b = UIButton(type: .system)
            b.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
            b.tintColor = UIColor(white: 0, alpha: 0.2)
        return b
    }()
    
    fileprivate func setProfileImage() {
        guard let image = user?.image_url else { return }
        profile_image.loadImage(url: image)
    }
    
    fileprivate func setUserStatsLabels() {
        userName.text = user?.username ?? ""
        
        let postAttribute = NSMutableAttributedString(string: "11\n", attributes:
            [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            postAttribute.append(NSAttributedString(string: "posts", attributes:
            [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13),
             NSAttributedStringKey.foregroundColor: UIColor.lightGray]))
        
        let followersAttribute = NSMutableAttributedString(string: "11\n", attributes:
            [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            followersAttribute.append(NSAttributedString(string: "followers", attributes:
            [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13),
             NSAttributedStringKey.foregroundColor: UIColor.lightGray]))
        
        let followingAttribute = NSMutableAttributedString(string: "11\n", attributes:
            [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            followingAttribute.append(NSAttributedString(string: "following", attributes:
            [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13),
             NSAttributedStringKey.foregroundColor: UIColor.lightGray]))
        
        post.attributedText = postAttribute
        followers.attributedText = followersAttribute
        following.attributedText = followingAttribute
    }
    
    fileprivate func configureToolBar() {
        let topDivider = UIView()
            topDivider.backgroundColor = .lightGray
        
        let bottomDivider = UIView()
            bottomDivider.backgroundColor = .lightGray
        
        let stackView = UIStackView(arrangedSubviews: [grid, list, bookmark])
            stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDivider)
        addSubview(bottomDivider)
        
        stackView.anchors(top: nil, toppad: 0, bottom: bottomAnchor, bottompad: 0,
                          left: leftAnchor, leftpad: 0, right: rightAnchor, rightpad: 0,
                          height: 50, width: 0)
        topDivider.anchors(top: stackView.topAnchor, toppad: 0, bottom: nil, bottompad: 0,
                           left: leftAnchor, leftpad: 0, right: rightAnchor, rightpad: 0,
                           height: 0.5, width: 0)
        bottomDivider.anchors(top: stackView.bottomAnchor, toppad: 0, bottom: nil, bottompad: 0,
                              left: leftAnchor, leftpad: 0, right: rightAnchor, rightpad: 0,
                              height: 0.5, width: 0)
    }
    
    fileprivate func configureUserStats() {
        let stackView = UIStackView(arrangedSubviews: [post, followers, following])
            stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(edit)
        
        stackView.anchors(top: topAnchor, toppad: 12, bottom: nil, bottompad: 0,
                          left: profile_image.rightAnchor, leftpad: 12, right: rightAnchor,
                          rightpad: 12, height: 50, width: 0)
        edit.anchors(top: post.bottomAnchor, toppad: 2, bottom: nil, bottompad: 0,
                     left: post.leftAnchor, leftpad: 0, right: following.rightAnchor,
                     rightpad: 0, height: 25, width: 0)
    }
    
    fileprivate func configureProfile() {
        addSubview(profile_image)
        addSubview(userName)
        
        profile_image.anchors(top: topAnchor, toppad: 12, bottom: nil, bottompad: 0,
                              left: leftAnchor, leftpad: 12, right: nil, rightpad: 0,
                              height: 80, width: 80)
        profile_image.clipsToBounds = true
        profile_image.layer.cornerRadius = 80 / 2
        
        userName.anchors(top: profile_image.bottomAnchor, toppad: 8, bottom: grid.topAnchor,
                         bottompad: 8, left: leftAnchor, leftpad: 16, right: rightAnchor,
                         rightpad: 12, height: 0, width: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureToolBar()
        configureProfile()
        configureUserStats()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
