//  PlayerView.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/28/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit
import SDWebImage

class PlayerView: UIView {
    
    var episode: Episode! {
        didSet {
            let url = URL(string: episode.imageURL)
            
            title.text = episode.title
            podCastImage.sd_setImage(with: url, completed: nil)
        }
    }
    
    let dismiss : UIButton = {
        let d = UIButton(type: .system)
            d.setTitle("Dismiss", for: .normal)
            d.addTarget(self, action: #selector(removePlayer), for: .touchUpInside)
        return d
    }()
    
    let podCastImage : UIImageView = {
        let p = UIImageView()
        return p
    }()
    
    let title : UILabel = {
        let t = UILabel()
            t.text = "Podcast Label"
            t.textAlignment = .center
            t.numberOfLines = 0
        return t
    }()
    
    let timeSlider : UISlider = {
        let t = UISlider()
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        dismiss.heightAnchor.constraint(equalToConstant: 44).isActive = true
        timeSlider.heightAnchor.constraint(equalToConstant: 36).isActive = true
        podCastImage.heightAnchor.constraint(equalTo: podCastImage.widthAnchor,
                                             multiplier: 1.0).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [dismiss,
                                                       podCastImage,
                                                       timeSlider,
                                                       title])
            stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.anchor(top: safeAreaLayoutGuide.topAnchor, topPad: 0, bottom: bottomAnchor,
                         bottomPad: 24, left: leftAnchor, leftPad: 24,
                         right: rightAnchor, rightPad: 24, height: 0, width: 0)
    }
    
    @objc func removePlayer() { self.removeFromSuperview() }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
