//
//  CombatViewController.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-10.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class CombatViewController: UIViewController {
    
    @IBOutlet weak var playerRobot: UIImageView!
    
    @IBOutlet weak var enemyRobot: UIImageView!
    
    var playerChoice: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadRobots()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Loads the images of the robots
    // into the ImageViews.
    func loadRobots() {
        playerRobot.image = UIImage(named: playerChoice)
        enemyRobot.image = UIImage(named: "Spectre")
    }
    
}
