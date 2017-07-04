//
//  TweetCell.swift
//  Twitter-Clone
//
//  Created by Anthony Washington on 7/4/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import LBTAComponents

class TweetCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let tweet = datasourceItem as? Tweet else { return }
            
            let name = "\(tweet.user.name)  "
            let username = "\(tweet.user.userName) \n"
            let attributedText = NSMutableAttributedString(string: name,
                                                           attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)])
            attributedText.append(NSAttributedString(string: username, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.gray]))
            
            // add spacing between username/name and tweet body
            let paragrahStyle = NSMutableParagraphStyle()
                paragrahStyle.lineSpacing = 3
            let range = NSMakeRange(0, attributedText.string.characters.count)
            
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragrahStyle, range: range)
            attributedText.append(NSAttributedString(string: tweet.message, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
            message.attributedText = attributedText
        }
    }
    
    let message: UITextView = {
        let m = UITextView()
        return m
    }()
    
    let profileImage: UIImageView = {
        let p = UIImageView()
        p.layer.cornerRadius = 5
        p.layer.masksToBounds = true
        p.image = #imageLiteral(resourceName: "profile_image")
        return p
    }()
    
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        separatorLineView.isHidden = false
        separatorLineView.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        
        addSubview(profileImage)
        addSubview(message)
        
        profileImage.anchor(topAnchor, left: leftAnchor, bottom: nil,
                            right: nil, topConstant: 12, leftConstant: 12,
                            bottomConstant: 0, rightConstant: 0, widthConstant: 50,
                            heightConstant: 50)
        message.anchor(topAnchor, left: profileImage.rightAnchor, bottom: bottomAnchor,
                       right: rightAnchor, topConstant: 4, leftConstant: 4,
                       bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
