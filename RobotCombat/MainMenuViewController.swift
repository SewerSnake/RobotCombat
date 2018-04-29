//
//  MainMenuViewController.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-09.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    private let preferences: UserDefaults = UserDefaults.standard
    
    private let key: String = "music"

    // Starts playing background music if the user has
    // actviated it. The name of the file is "intro.mp3".
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if preferences.bool(forKey: key) {
            BackgroundMusic.sharedHelper.playBackgroundMusic()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
