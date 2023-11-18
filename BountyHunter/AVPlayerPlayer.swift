//
//  AVPlayerPlayer.swift
//  AudioYvideo
//
//  Created by Ángel González on 18/11/23.
//

import Foundation
import AVFoundation
import AVKit

class AVPlayerPlayer : AVPlayerViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let laURL = URL (string: "http://janzelaznog.com/DDAM/iOS/BountyHunter/the-bounty-hunter.mp4") {
            self.player = AVPlayer(url: laURL)
        }
    }
}

