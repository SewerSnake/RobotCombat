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
    
    @IBOutlet weak var musicLabel: UILabel!
    
    // Sets a background image and changes
    // the UILabel to bold font. Its color
    // becomes white.
    override func viewDidLoad() {
        super.viewDidLoad()
        musicLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        musicLabel.textColor = UIColor.white
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "arena")!)
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
