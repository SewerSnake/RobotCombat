//
//  MainMenuViewController.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-09.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    // Starts playing background music.
    // The name of the file is
    // "intro.mp3".
    override func viewDidLoad() {
        super.viewDidLoad()

        BackgroundMusic.sharedHelper.playBackgroundMusic()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
