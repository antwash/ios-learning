//
//  Cell.swift
//  Twitter-Clone
//
//  Created by Anthony Washington on 7/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import LBTAComponents
let twitter = UIColor(r: 61, g: 167, b: 244)

// header cell
class UserHeader: DatasourceCell {
    let label: UILabel = {
        let l = UILabel()
            l.text = "WHO TO FOLLOW"
            l.font = UIFont.systemFont(ofSize: 16)
        return l
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(label)
        label.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor,
                     right: rightAnchor, topConstant: 0, leftConstant: 12,
                     bottomConstant: 0, rightConstant: 0, widthConstant: 0,
                     heightConstant: 0)
    }
}

//footer cell
class UserFooter: DatasourceCell {
    let label: UILabel = {
        let l = UILabel()
            l.text = "Show me more"
            l.font = UIFont.systemFont(ofSize: 15)
            l.textColor = twitter
        return l
    }()
    override func setupViews() {
        super.setupViews()
        
        addSubview(label)
        label.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor,
                     right: rightAnchor, topConstant: 0, leftConstant: 12,
                     bottomConstant: 0, rightConstant: 0, widthConstant: 0,
                     heightConstant: 0)
    }
}


// tweet cells
class UserCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet{
           // nameLabel.text = datasourceItem as? String
        }
    }
    
    let nameLabel: UILabel = {
        let l = UILabel()
            l.text = "Anthony Washington"
            l.font = UIFont.boldSystemFont(ofSize: 16)
        return l
    }()
    
    let userName: UILabel = {
        let u = UILabel()
            u.text = "@antdwash"
            u.textColor = UIColor(r: 130, g: 130, b: 130)
            u.font = UIFont.systemFont(ofSize: 14)
        return u
    }()
    
    let profileImage: UIImageView = {
        let p = UIImageView()
            p.layer.cornerRadius = 5
            p.layer.masksToBounds = true
            p.image = #imageLiteral(resourceName: "profile_image")
        return p
    }()
    
    let bioText: UITextView = {
        let b = UITextView()
            b.text = "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps!"
            b.font = UIFont.systemFont(ofSize: 15)
            b.isEditable = false
            b.backgroundColor = .clear
        return b
    }()
    
    let followButton: UIButton = {
        let button = UIButton()
            button.layer.cornerRadius = 5
            button.layer.borderColor = twitter.cgColor
            button.layer.borderWidth = 1
            button.setTitle("Follow", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.setTitleColor(twitter, for: .normal)
            button.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(profileImage)
        addSubview(nameLabel)
        addSubview(userName)
        addSubview(bioText)
        addSubview(followButton)
        
        profileImage.anchor(topAnchor, left: leftAnchor, bottom: nil,
                            right: nil, topConstant: 12, leftConstant: 12,
                            bottomConstant: 0, rightConstant: 0, widthConstant: 50,
                            heightConstant: 50)
        nameLabel.anchor(profileImage.topAnchor, left: profileImage.rightAnchor,
                         bottom: nil, right: followButton.leftAnchor, topConstant: 0, leftConstant: 8,
                         bottomConstant: 0, rightConstant: 12, widthConstant: 0,
                         heightConstant: 20)
        userName.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil,
                        right: nameLabel.rightAnchor, topConstant: 0, leftConstant: 0,
                        bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        bioText.anchor(userName.bottomAnchor, left: userName.leftAnchor, bottom: bottomAnchor,
                       right: rightAnchor, topConstant: -3, leftConstant: -4, bottomConstant: 0,
                       rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        followButton.anchor(topAnchor, left: nil, bottom: nil, right: rightAnchor, topConstant: 12,
                            leftConstant: 0, bottomConstant: 0, rightConstant: 12, widthConstant: 120,
                            heightConstant: 34)
    }
}
