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
    
    let divder: UIView = {
        let view = UIView()
            view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(profileImage)
        addSubview(divder)
        profileImage.anchors(top: topAnchor, topPad: 15, left: leftAnchor, leftPad: 15,
                             right: nil, rightPad: nil, height: 80, width: 80, center: nil)

        profileImage.layer.cornerRadius = 80 / 2
        profileImage.layer.masksToBounds = true
        
        divder.anchors(top: bottomAnchor, topPad: 0, left: leftAnchor, leftPad: 36,
                       right: rightAnchor, rightPad: 36, height: 1, width: nil, center: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            }
            
        }.resume()
        
    }
}
