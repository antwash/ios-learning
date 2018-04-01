//  CMTimeExtension.swift
//  Podcasts-Clone
//  Created by Anthony Washington on 4/1/18.
//  Copyright © 2018 Anthony Washington. All rights reserved.

import AVKit

extension CMTime {
    
    func formatTime() -> String {
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let hours = totalSeconds / 3600
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
