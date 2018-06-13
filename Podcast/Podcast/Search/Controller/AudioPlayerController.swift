//  AudioPlayerController.swift
//  Podcast
//  Created by Anthony Washington on 6/12/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit

class AudioPlayerController : UIViewController {
    let space1 = UIView()
    let space2 = UIView()
    let space3 = UIView()
    let space4 = UIView()
    let space5 = UIView()
    let space6 = UIView()
    let space7 = UIView()
    
    let dismissButton : UIButton = {
        let d = UIButton(type: .system)
            d.titleLabel?.textAlignment = .center
            d.setTitleColor(.black, for: .normal)
            d.setTitle("Dismiss", for: .normal)
            d.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return d
    }()
    
    let podcastImage : UIImageView = {
        let p = UIImageView()
            p.image = #imageLiteral(resourceName: "appicon")
            p.clipsToBounds = true
            p.layer.cornerRadius = 10
            p.contentMode = .scaleAspectFill
        return p
    }()
    
    let timeSlider : UISlider = {
        let t = UISlider()
        return t
    }()
    
    let startTimeLabel : UILabel = {
        let s = UILabel()
            s.text = "00:00:00"
            s.font = UIFont.systemFont(ofSize: 14)
            s.textColor = .darkGray
        return s
    }()
    
    let endTimeLabel : UILabel = {
        let e = UILabel()
            e.textAlignment = .right
            e.font = UIFont.systemFont(ofSize: 14)
            e.text = "--:--:--"
            e.textColor = .darkGray
        return e
    }()
    
    let podcastTitleLabel : UILabel = {
        let p = UILabel()
            p.numberOfLines = 2
            p.textAlignment = .center
            p.text = "My Experience in Computer Science Vs Real world"
            p.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return p
    }()
    
    let podcastArtistLabel : UILabel = {
        let p = UILabel()
            p.textColor = .purple
            p.text = "Brian Voong"
            p.textAlignment = .center
            p.font = UIFont.boldSystemFont(ofSize: 15)
        return p
    }()
    
    let rewind15Button : UIButton = {
        let r = UIButton(type: .system)
            r.tintColor = .black
            r.setImage(#imageLiteral(resourceName: "rewind15"), for: .normal)
        return r
    }()
    
    let playButton : UIButton = {
        let p = UIButton(type: .system)
            p.tintColor = .black
            p.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        return p
    }()
    
    let fastforward15Button : UIButton = {
        let f = UIButton(type: .system)
            f.tintColor = .black
            f.setImage(#imageLiteral(resourceName: "fastforward15"), for: .normal)
        return f
    }()

    let volumeSlider : UISlider = {
        let v = UISlider()
            v.maximumValue = 100
        return v
    }()
    
    let muteVolumeIcon : UIImageView = {
        let m = UIImageView()
            m.image = #imageLiteral(resourceName: "muted_volume")
        return m
    }()
    
    let maxVolumeIcon : UIImageView = {
        let m = UIImageView()
            m.image = #imageLiteral(resourceName: "max_volume")
        return m
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerStackView = setUpPlayerHeader()
        let volumStackView = setupVolumeController()
 
        let stackView = UIStackView(arrangedSubviews: [
            headerStackView, space7, volumStackView
        ])
            stackView.axis = .vertical
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        stackView.anchors(top: view.safeAreaLayoutGuide.topAnchor, topPad: 8,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          bottomPad: 8, left: view.leftAnchor, leftPad: 24,
                          right: view.rightAnchor, rightPad: 24, height: 0, width: 0)
    }
    
    fileprivate func setupHeaderAnchors() {
        space1.widthAnchor.constraint(equalToConstant: 12).isActive = true
        space2.widthAnchor.constraint(equalToConstant: 12).isActive = true
        space4.widthAnchor.constraint(equalToConstant: 20).isActive = true
        space5.widthAnchor.constraint(equalToConstant: 20).isActive = true

        podcastImage.heightAnchor.constraint(equalTo: podcastImage.widthAnchor,
                                             multiplier: 0.9).isActive = true
    }
    
    fileprivate func setUpPlayerHeader() -> UIStackView {
        setupHeaderAnchors()

        let playControlsStackView = setupPlayControls()
        let timerStackView = UIStackView(arrangedSubviews: [space1, timeSlider, space2])
        let timesStackView = UIStackView(arrangedSubviews: [startTimeLabel, space3, endTimeLabel])
        let descriptionStack = UIStackView(arrangedSubviews: [podcastTitleLabel, podcastArtistLabel])
        let descriptionStackView = UIStackView(arrangedSubviews: [space4, descriptionStack, space5])
        
        timesStackView.distribution = .fillEqually
        descriptionStack.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [
            dismissButton, podcastImage, timerStackView, timesStackView,
            descriptionStackView, playControlsStackView
        ])
            stackView.axis = .vertical
            stackView.spacing = 15

        return stackView
    }
    
    fileprivate func setupPlayControls() -> UIStackView {

        rewind15Button.heightAnchor.constraint(equalTo: rewind15Button.widthAnchor,
                                               multiplier: 0.7).isActive = true
        let stackView = UIStackView(arrangedSubviews: [
            rewind15Button, playButton, fastforward15Button
        ])
            stackView.spacing = 5
            stackView.distribution = .fillEqually
        
        return stackView
    }
    
    fileprivate func setupVolumeController() -> UIStackView {
        muteVolumeIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        muteVolumeIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        maxVolumeIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        maxVolumeIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [
            muteVolumeIcon,volumeSlider, maxVolumeIcon
        ])
            stackView.spacing = 2
        
        return stackView
    }
}
