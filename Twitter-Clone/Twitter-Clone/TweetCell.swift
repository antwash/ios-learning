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
            m.backgroundColor = .clear
            m.isEditable = false
        return m
    }()
    
    let profileImage: UIImageView = {
        let p = UIImageView()
        p.layer.cornerRadius = 5
        p.layer.masksToBounds = true
        p.image = #imageLiteral(resourceName: "profile_image")
        return p
    }()
    
    
    let replyB: UIButton = {
        let b = UIButton(type: .system)
            b.setImage(#imageLiteral(resourceName: "reply").withRenderingMode(.alwaysOriginal), for: .normal)
        return b
    }()
    
    let send_messageB: UIButton = {
        let b = UIButton(type: .system)
            b.setImage(#imageLiteral(resourceName: "send_message").withRenderingMode(.alwaysOriginal), for: .normal)
        return b
    }()
    
    let likeB: UIButton = {
        let b = UIButton(type: .system)
            b.setImage(#imageLiteral(resourceName: "like").withRenderingMode(.alwaysOriginal), for: .normal)
        return b
    }()
    
    let retweetB: UIButton = {
        let b = UIButton(type: .system)
            b.setImage(#imageLiteral(resourceName: "retweet").withRenderingMode(.alwaysOriginal), for: .normal)
        return b
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
        
        setupTweetBottomButtons()
    }
    
    fileprivate func setupTweetBottomButtons() {
        // custome view -- so buttons won't look stretched
        let replyView = UIView()
        let retweetView = UIView()
        let likeView = UIView()
        let messageView = UIView()
        
        let stackView = UIStackView(arrangedSubviews: [replyView, retweetView, likeView, messageView])
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(replyB)
        addSubview(retweetB)
        addSubview(likeB)
        addSubview(send_messageB)
        
        stackView.anchor(nil, left: message.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        replyB.anchor(nil, left: replyView.leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        retweetB.anchor(nil, left: retweetView.leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        likeB.anchor(nil, left: likeView.leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
        send_messageB.anchor(nil, left: messageView.leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 20, heightConstant: 20)
    }
    
}
