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
    
    private var audioPlayer: AVAudioPlayer?
    
    private let error = "Cannot play mp3 file"
    
    static let sharedHelper = BackgroundMusic()
    
    // Plays the mp3 file indefinately.
    func playBackgroundMusic() {
        let path: String? = Bundle.main.path(forResource: audioFile, ofType: "mp3")
        
        guard let url = Bundle.main.url(forAuxiliaryExecutable: path!) else {
            print(error)
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            audioPlayer!.numberOfLoops = -1
            
            audioPlayer!.volume = 0.2
            
            audioPlayer!.prepareToPlay()
            
            audioPlayer!.play()
        } catch {
            print(error)
            return
        }
    }
    
    // Stops the background music.
    func stopMusic() {
        if audioPlayer != nil {
            audioPlayer!.stop()
        }
    }
}
