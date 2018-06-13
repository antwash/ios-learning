//  AudioPlayerController.swift
//  Podcast
//  Created by Anthony Washington on 6/12/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit

class AudioPlayerController : UIViewController {
    
    let space1 = UIView()
    let space2 = UIView()
    
    var episode : Episode! {
        didSet {
            
            let url = URL(string: episode.imageURL)
            podcastImage.sd_setIndicatorStyle(.gray)
            podcastImage.sd_setShowActivityIndicatorView(true)
            podcastImage.sd_setImage(with: url, completed: nil)
            
            podcastTitleLabel.text = episode.title
            podcastArtistLabel.text = episode.author
        }
    }
    
    let dismissButton : UIButton = {
        let d = UIButton(type: .system)
            d.titleLabel?.textAlignment = .center
            d.setTitleColor(.black, for: .normal)
            d.setTitle("Dismiss", for: .normal)
            d.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            d.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return d
    }()
    
    let podcastImage : UIImageView = {
        let p = UIImageView()
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
            p.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return p
    }()
    
    let podcastArtistLabel : UILabel = {
        let p = UILabel()
            p.numberOfLines = 1
            p.textColor = .purple
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
        
        setupAnchors()
        
        let volumStackView = setupVolumeController()
        let playControlsStackView = setupPlayControls()
        let timerSliderStackView = UIStackView(arrangedSubviews: [space1, timeSlider, space2])
        let timerLabelStackView = UIStackView(arrangedSubviews: [startTimeLabel, endTimeLabel])
            timerLabelStackView.distribution = .fillEqually
        let descriptionStackView = UIStackView(arrangedSubviews: [podcastTitleLabel, podcastArtistLabel])
            descriptionStackView.axis = .vertical
        
        let stackView = UIStackView(arrangedSubviews: [
            dismissButton, podcastImage, timerSliderStackView, timerLabelStackView,
            descriptionStackView, playControlsStackView, volumStackView
        ])
            stackView.axis = .vertical
            stackView.spacing = 5
        
        view.backgroundColor = .white
        view.addSubview(stackView)

        stackView.anchors(top: view.safeAreaLayoutGuide.topAnchor, topPad: 8,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          bottomPad: 8, left: view.leftAnchor, leftPad: 24,
                          right: view.rightAnchor, rightPad: 24, height: 0, width: 0)
    }
    
    fileprivate func setupPlayControls() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            UIView(), rewind15Button, UIView(),
            playButton, UIView(), fastforward15Button, UIView()
        ])
            stackView.distribution = .equalCentering

        return stackView
    }

    fileprivate func setupVolumeController() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            muteVolumeIcon,volumeSlider, maxVolumeIcon
        ])

        return stackView
    }
    
    fileprivate func setupAnchors() {
        space1.widthAnchor.constraint(equalToConstant: 12).isActive = true
        space2.widthAnchor.constraint(equalToConstant: 12).isActive = true
        
        dismissButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        podcastImage.heightAnchor.constraint(equalTo: podcastImage.widthAnchor,
                                             multiplier: 1.0).isActive = true
        startTimeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        podcastTitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        podcastArtistLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        muteVolumeIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        muteVolumeIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        maxVolumeIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        maxVolumeIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func dismissView() { dismiss(animated: true, completion: nil) }
}
