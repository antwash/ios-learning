//  AudioPlayerController.swift
//  Podcast
//  Created by Anthony Washington on 6/12/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit
import AVKit

class AudioPlayerController : UIViewController {
    
    var episode : Episode! {
        didSet {
            
            playEpisodeAudio()
            
            let url = URL(string: episode.imageURL)
            podcastImage.transform = smallerAnimation
            podcastImage.sd_setIndicatorStyle(.gray)
            podcastImage.sd_setShowActivityIndicatorView(true)
            podcastImage.sd_setImage(with: url, completed: nil)
            
            podcastTitleLabel.text = episode.title
            podcastArtistLabel.text = episode.author
        }
    }
    
    //MARK: - LET constant properties
    
    let space1 = UIView()
    let space2 = UIView()
    
    let audioPlayer : AVPlayer = {
        let a = AVPlayer()
            a.automaticallyWaitsToMinimizeStalling = false
        return a
    }()
    
    let dismissButton : UIButton = {
        let d = UIButton(type: .system)
            d.titleLabel?.textAlignment = .center
            d.setTitleColor(.black, for: .normal)
            d.setTitle("Dismiss", for: .normal)
            d.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            d.addTarget(self, action: #selector(dissmissAction), for: .touchUpInside)
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
            p.textAlignment = .center
            p.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return p
    }()
    
    let podcastArtistLabel : UILabel = {
        let p = UILabel()
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
            p.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            p.addTarget(self, action: #selector(playPauseAction), for: .touchUpInside)
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
        addPlayerObserver()
        
        let volumeControlStackView = setupVolumeController()
        let playControlsStackView = setupPlayControls()
        let playTimerLabelStackView = setupPlayTimeLabel()
        let descriptionStackView = setupEpisodeDescription()
        let timerSliderStackView = UIStackView(arrangedSubviews: [space1, timeSlider, space2])

        let stackView = UIStackView(arrangedSubviews: [
            dismissButton, podcastImage, timerSliderStackView,
            playTimerLabelStackView, descriptionStackView, playControlsStackView,
            volumeControlStackView
        ])
            stackView.axis = .vertical
            stackView.spacing = 10
        
        view.backgroundColor = .white
        view.addSubview(stackView)

        stackView.anchors(top: view.safeAreaLayoutGuide.topAnchor, topPad: 8,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          bottomPad: 8, left: view.leftAnchor, leftPad: 24,
                          right: view.rightAnchor, rightPad: 24, height: 0, width: 0)
    }
    
    //MARK: - Private functions
    
    fileprivate func playEpisodeAudio() {
        guard let url = URL(string: episode.audioURL) else { return }
        let playerItem = AVPlayerItem(url: url)
        
        audioPlayer.replaceCurrentItem(with: playerItem)
        audioPlayer.play()
    }
    

    fileprivate func setupPlayTimeLabel() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            startTimeLabel, endTimeLabel
        ])
            stackView.distribution = .fillEqually
        return stackView
    }
    
    fileprivate func setupEpisodeDescription() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            podcastTitleLabel, podcastArtistLabel
        ])
            stackView.axis = .vertical
        return stackView
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
        
        podcastTitleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        podcastArtistLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        muteVolumeIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        muteVolumeIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        maxVolumeIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        maxVolumeIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    fileprivate let largerAnimation = CGAffineTransform.identity
    fileprivate let smallerAnimation = CGAffineTransform(scaleX: 0.7, y: 0.7)
    fileprivate func performAnimation(transform : CGAffineTransform) {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.podcastImage.transform = transform
        })
    }
    
    fileprivate func addPlayerObserver() {
        let times = [ NSValue(time: CMTime(value: 1, timescale: 3)) ]
        audioPlayer.addBoundaryTimeObserver(forTimes: times, queue: .main) {
            self.performAnimation(transform: self.largerAnimation)
        }
    }
    
    //MARK: - Button action functions
    
    @objc func dissmissAction() { dismiss(animated: true, completion: nil) }
    @objc func playPauseAction() {

        switch audioPlayer.timeControlStatus {
        case .paused:
            audioPlayer.play()
            playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            performAnimation(transform: largerAnimation)
            break
        default:
            audioPlayer.pause()
            playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            performAnimation(transform: smallerAnimation)
        }
    }
}
