//
//  UserProfileHeader.swift
//  IG-Remake
//
//  Created by Anthony Washington on 5/2/17.
//  Copyright © 2017 Anthony Washington. All rights reserved.
//

import UIKit

class UserProfileHeader: UICollectionViewCell {
    
    var user_profile: User? {
        didSet{
            self.setImage()
        }
    }
    
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let postLabel: UILabel = {
        let text = NSMutableAttributedString(string: "0\n",
                                             attributes: [NSFontAttributeName:
                                                UIFont.boldSystemFont(ofSize: 14)])
        text.append(NSAttributedString(string: "posts", attributes:
            [NSForegroundColorAttributeName: UIColor.lightGray,
             NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        let label = UILabel()
            label.attributedText = text
            label.textAlignment = .center
            label.numberOfLines = 0
        return label
    }()
    
    let follwersLabel: UILabel = {
        let text = NSMutableAttributedString(string: "0\n",
                                             attributes: [NSFontAttributeName:
                                                        UIFont.boldSystemFont(ofSize: 14)])
        text.append(NSAttributedString(string: "followers", attributes:
            [NSForegroundColorAttributeName: UIColor.lightGray,
             NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
    
        let label = UILabel()
            label.attributedText = text
            label.textAlignment = .center
            label.numberOfLines = 0
        
        return label
    }()
    
    let followingLabel: UILabel = {
        let text = NSMutableAttributedString(string: "0\n",
                                             attributes: [NSFontAttributeName:
                                                UIFont.boldSystemFont(ofSize: 14)])
        text.append(NSAttributedString(string: "following", attributes:
            [NSForegroundColorAttributeName: UIColor.lightGray,
             NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        let label = UILabel()
            label.attributedText = text
            label.textAlignment = .center
            label.numberOfLines = 0
        return label
    }()
    
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
            button.setTitle("Edit Profile", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            button.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
        return button
    }()
    
    let topDivder: UIView = {
        let view = UIView()
            view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return view
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
            button.setImage(#imageLiteral(resourceName: "grid_view"), for: .normal)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
            button.setImage(#imageLiteral(resourceName: "list_view"), for: .normal)
            button.tintColor = UIColor(white: 0, alpha: 0.3)
        return button
    }()
    
    let bookMarkButton: UIButton = {
        let button = UIButton(type: .system)
            button.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
            button.tintColor = UIColor(white: 0, alpha: 0.3)
        return button
    }()
    
    let bottomDivder: UIView = {
        let view = UIView()
            view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        // add profile image
        addSubview(profileImage)
        profileImage.anchors(top: topAnchor, topPad: 15, bottom: nil, bottomPad: 0,
                             left: leftAnchor, leftPad: 15, right: nil, rightPad: nil, height: 80, width: 80)
        profileImage.layer.cornerRadius = 80 / 2
        profileImage.layer.masksToBounds = true
        
        addSubview(nameLabel)
        
        nameLabel.anchors(top: profileImage.bottomAnchor, topPad: 12, bottom: nil, bottomPad: 0,
                          left: profileImage.leftAnchor, leftPad: 8, right: nil, rightPad: 0, height: 20, width: nil)
        
        
        
        setupProfileStats()
        setupBottomButtons()
    }
    
    
    
    fileprivate func setupProfileStats() {
    
        let stackView = UIStackView(arrangedSubviews: [postLabel,
                                                       follwersLabel,
                                                       followingLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
    
        addSubview(stackView)
        addSubview(editButton)
        
        stackView.anchors(top: topAnchor, topPad: 12, bottom: nil, bottomPad: 0,
                          left: profileImage.rightAnchor, leftPad: 12, right: rightAnchor,
                          rightPad: 12, height: 50, width: nil)
        
        editButton.anchors(top: stackView.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0,
                           left: stackView.leftAnchor, leftPad: 8, right: stackView.rightAnchor,
                           rightPad: 8, height: 25, width: nil)
    
    }
    
    
    //setup header bottom row
    fileprivate func setupBottomButtons(){
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton,
                                                       bookMarkButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        
        addSubview(stackView)
        addSubview(topDivder)
        addSubview(bottomDivder)
        
        stackView.anchors(top: nil, topPad: 0, bottom: bottomAnchor, bottomPad: 0,
                          left: leftAnchor, leftPad: 0, right: rightAnchor, rightPad: 0,
                          height: 50, width: nil)
        
        topDivder.anchors(top: nil, topPad: 0, bottom: stackView.topAnchor, bottomPad: 0,
                          left: leftAnchor, leftPad: 0, right: rightAnchor, rightPad: 0,
                          height: 0.5, width: nil)
        
        bottomDivder.anchors(top: bottomAnchor, topPad: 0, bottom: nil, bottomPad: 0,
                             left: leftAnchor, leftPad: 0, right: rightAnchor, rightPad: 0,
                             height: 0.5, width: nil)
        
    }
    
    // set user profile image
    fileprivate func setImage() {
        guard let u_image = user_profile?.imageURL else { return }
        guard let imag = URL(string: u_image) else { return }
        
        URLSession.shared.dataTask(with: imag)  { (data, response, error) in
            
            if let err = error {
                print("Error loading user image: ", err)
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.profileImage.image = UIImage(data: data)
                self.nameLabel.text = self.user_profile?.userName
            }
        }.resume()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
