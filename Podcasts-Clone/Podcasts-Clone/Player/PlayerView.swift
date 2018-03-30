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
            author.text = episode.authorName
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
            t.textAlignment = .center
            t.numberOfLines = 0
            t.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return t
    }()
    
    let author : UILabel = {
        let a = UILabel()
            a.textAlignment = .center
            a.textColor = .purple
            a.text = "Author"
            a.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return a
    }()
    
    let timeSlider : UISlider = {
        let t = UISlider()
        return t
    }()
    
    let runTime : UILabel = {
        let r = UILabel()
            r.text = "00:00:00"
            r.font = UIFont.systemFont(ofSize: 14)
            r.textColor = .darkGray
        return r
    }()
    
    let endTime : UILabel = {
        let e = UILabel()
            e.textAlignment = .right
            e.font = UIFont.systemFont(ofSize: 14)
            e.text = "99:99:99"
            e.textColor = .darkGray
        return e
    }()
    
    let fastForwardButton : UIButton = {
        let f = UIButton()
            f.setImage(#imageLiteral(resourceName: "fastforward15"), for: .normal)
        return f
    }()
    
    let playButton : UIButton = {
        let p = UIButton()
            p.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        return p
    }()
    
    let rewindButton : UIButton = {
        let r = UIButton()
            r.setImage(#imageLiteral(resourceName: "rewind15"), for: .normal)
        return r
    }()
    
    let muteImage : UIImageView = {
        let m = UIImageView()
            m.image = #imageLiteral(resourceName: "muted_volume")
        return m
    }()
    
    let volumeSlider : UISlider = {
        let v = UISlider()
        return v
    }()
    
    let maxImage : UIImageView = {
        let m = UIImageView()
            m.image = #imageLiteral(resourceName: "max_volume")
        return m
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        dismiss.heightAnchor.constraint(equalToConstant: 44).isActive = true
        timeSlider.heightAnchor.constraint(equalToConstant: 36).isActive = true
        podCastImage.heightAnchor.constraint(equalTo: podCastImage.widthAnchor,
                                             multiplier: 1.0).isActive = true
        
        title.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        author.heightAnchor.constraint(equalToConstant: 20).isActive = true

        let controlsStackView = setPlayControlsStackView()
        let playTimeStackView = setupPlayTimeStackView()
        let volumeView = setupVolumeControlsView()

        let stackView = UIStackView(arrangedSubviews: [dismiss,
                                                       podCastImage,
                                                       timeSlider,
                                                       playTimeStackView,
                                                       title,
                                                       author,
                                                       controlsStackView,
                                                       volumeView])

            stackView.axis = .vertical
            stackView.spacing = 10
        
        addSubview(stackView)
        stackView.anchor(top: safeAreaLayoutGuide.topAnchor, topPad: 0,
                         bottom: safeAreaLayoutGuide.bottomAnchor,
                         bottomPad: 24, left: leftAnchor, leftPad: 24,
                         right: rightAnchor, rightPad: 24, height: 0, width: 0)
    }
    
    fileprivate func setupPlayTimeStackView() -> UIStackView {
        let playTimeStackView = UIStackView(arrangedSubviews: [runTime, endTime])
            playTimeStackView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        return playTimeStackView
    }
    
    fileprivate func setPlayControlsStackView() -> UIStackView {
        rewindButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        fastForwardButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        /* added blanks UIViews for spacing between controls
           could use controlsStackView.distribution = .fillEqually
           and remove the UIViews but our items are different widths.
        */
        let controlsStackView = UIStackView(arrangedSubviews: [UIView(),
                                                               rewindButton,
                                                               UIView(), playButton,
                                                               UIView(), fastForwardButton, UIView()])
            controlsStackView.distribution = .equalCentering
        return controlsStackView
    }
    
    fileprivate func setupVolumeControlsView() -> UIView {
        muteImage.widthAnchor.constraint(equalToConstant: 34).isActive = true
        maxImage.widthAnchor.constraint(equalToConstant: 34).isActive = true
        let v = UIStackView(arrangedSubviews: [muteImage, volumeSlider, maxImage])
        
        let view = UIView()
            view.addSubview(v)
            v.heightAnchor.constraint(equalToConstant: 34).isActive = true
            v.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            v.anchor(top: nil, topPad: 0, bottom: nil, bottomPad: 0, left: view.leftAnchor,
                 leftPad: 0, right: view.rightAnchor, rightPad: 0, height: 34, width: 0)
        return view
    }
    
    @objc func removePlayer() { self.removeFromSuperview() }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
