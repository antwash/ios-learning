//  PlayerView.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 3/28/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import UIKit
import SDWebImage
import AVKit

class PlayerView: UIView {
    
    var episode: Episode! {
        didSet {
            let url = URL(string: episode.imageURL)

            title.text = episode.title
            author.text = episode.authorName
            podCastImage.sd_setImage(with: url, completed: nil)

            startPlayingAudio()
        }
    }
    
    lazy var podCastImage : UIImageView = {
        let p = UIImageView()
            p.layer.cornerRadius = 5
            p.clipsToBounds = true
            p.transform = smallerAnimation
        return p
    }()

    let dismiss : UIButton = {
        let d = UIButton(type: .system)
            d.setTitle("Dismiss", for: .normal)
            d.addTarget(self, action: #selector(removePlayer), for: .touchUpInside)
        return d
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
            t.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
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
            e.text = "--:--:--"
            e.textColor = .darkGray
        return e
    }()
    
    let fastForwardButton : UIButton = {
        let f = UIButton(type: .system)
            f.tintColor = .black
            f.setImage(#imageLiteral(resourceName: "fastforward15"), for: .normal)
            f.addTarget(self, action: #selector(performFastForward), for: .touchUpInside)
        return f
    }()
    
    let playPauseButton : UIButton = {
        let p = UIButton(type: .system)
            p.tintColor = .black
            p.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            p.addTarget(self, action: #selector(playPauseController), for: .touchUpInside)
        return p
    }()
    
    let rewindButton : UIButton = {
        let r = UIButton(type: .system)
            r.tintColor = .black
            r.setImage(#imageLiteral(resourceName: "rewind15"), for: .normal)
            r.addTarget(self, action: #selector(performRewind), for: .touchUpInside)
        return r
    }()
    
    let muteImage : UIImageView = {
        let m = UIImageView()
            m.image = #imageLiteral(resourceName: "muted_volume")
        return m
    }()
    
    let volumeSlider : UISlider = {
        let v = UISlider()
            v.value = 1
            v.addTarget(self, action: #selector(volumeChanged), for: .valueChanged)
        return v
    }()
    
    let maxImage : UIImageView = {
        let m = UIImageView()
            m.image = #imageLiteral(resourceName: "max_volume")
        return m
    }()
    
    let audioPlayer : AVPlayer = {
        let a = AVPlayer()
            a.volume = 1
            a.automaticallyWaitsToMinimizeStalling = false
        return a
    }()

    override func didMoveToSuperview() {
        // observer for audio start
        let times = [NSValue(time: CMTimeMake(1, 3))]
        audioPlayer.addBoundaryTimeObserver(forTimes: times, queue: .main) {
            [weak self] in
            self?.playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            self?.performImageAnimation(transform:
                self?.largerAnimation ?? CGAffineTransform())
        }
        
        // observer for audio time tracker
        audioPlayer.addPeriodicTimeObserver(forInterval:
            CMTimeMake(1, 2), queue: .main) {
                [weak self] (time) in
                let currentTime = CMTimeGetSeconds(time)
                let endTime = self?.audioPlayer.currentItem?.duration
                self?.runTime.text = time.formatTime()
                self?.endTime.text = endTime?.formatTime()
                self?.timeSlider.value = Float(currentTime /
                    CMTimeGetSeconds(endTime ?? CMTimeMake(0, 0)))
        }
    }

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
        playPauseButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        fastForwardButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        /* added blanks UIViews for spacing between controls
           could use controlsStackView.distribution = .fillEqually
           and remove the UIViews but our items are different widths.
        */
        let controlsStackView = UIStackView(arrangedSubviews: [UIView(),
                                                               rewindButton,
                                                               UIView(), playPauseButton,
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
    
    fileprivate func startPlayingAudio() {
        guard let url = URL(string: episode.audioURL) else { return }
        let playerItem = AVPlayerItem(url: url)
        audioPlayer.replaceCurrentItem(with: playerItem)
        audioPlayer.play()
    }

    fileprivate let largerAnimation = CGAffineTransform.identity
    fileprivate let smallerAnimation = CGAffineTransform(scaleX: 0.7, y: 0.7)
    fileprivate func performImageAnimation(transform: CGAffineTransform ) {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping:
            0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.podCastImage.transform = transform
        }, completion: nil)
    }
    
    @objc func playPauseController() {
        if audioPlayer.timeControlStatus == .playing {
            audioPlayer.pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            performImageAnimation(transform: smallerAnimation)
        } else if audioPlayer.timeControlStatus == .paused {
            audioPlayer.play()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            performImageAnimation(transform: largerAnimation)
        }
    }
    
    fileprivate func goToTime(time: Int64) {
        let time = CMTimeMake(time, 1)
        let goToTime = CMTimeAdd(audioPlayer.currentTime(), time)
        audioPlayer.seek(to: goToTime)
    }
    
    @objc func performRewind() { goToTime(time: -15) }
    @objc func performFastForward() { goToTime(time: 15)}

    @objc func timeChanged() {
        guard let endTime = audioPlayer.currentItem?.duration else { return }
        let percent = timeSlider.value
        let endTimeSeconds = CMTimeGetSeconds(endTime)
        
        let goToTimeSeconds = Float64(percent) * endTimeSeconds
        let goToTime = CMTimeMakeWithSeconds(goToTimeSeconds, Int32(NSEC_PER_SEC))
        audioPlayer.seek(to: goToTime)
    }
    
    @objc func volumeChanged() {
        audioPlayer.volume = volumeSlider.value
    }
    
    @objc func removePlayer() { self.removeFromSuperview() }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
