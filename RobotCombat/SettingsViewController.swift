//
//  SettingsViewController.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-09.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var toggleMusic: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // If the background music is currently
    // playing, it's turned off.
    // Otherwise, it's turned on.
    @IBAction func musicSwitch(_ sender: Any) {
        if toggleMusic.isOn {
            BackgroundMusic.sharedHelper.playBackgroundMusic()
        } else {
            BackgroundMusic.sharedHelper.stopMusic()
        }
    }
    
}
