//
//  BackgroundMusic.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-10.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation
import AVFoundation

class BackgroundMusic {
    
    private let audioFile: String = "intro"
    
    static let sharedHelper = BackgroundMusic()
    
    var audioPlayer: AVAudioPlayer?
    
    // Plays the mp3 file indefinately.
    func playBackgroundMusic() {
        let path: String? = Bundle.main.path(forResource: audioFile, ofType: "mp3")
        
        guard let url = Bundle.main.url(forAuxiliaryExecutable: path!) else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            audioPlayer!.numberOfLoops = -1
            
            audioPlayer!.prepareToPlay()
            
            audioPlayer!.play()
        } catch {
            print("Cannot play mp3 file")
        }
    }
    
    // Stops the background music.
    func stopMusic() {
        if audioPlayer != nil {
            audioPlayer!.stop()
        }
    }
}
