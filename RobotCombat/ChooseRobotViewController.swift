//
//  ChooseRobotViewController.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-09.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class ChooseRobotViewController: UIViewController {
    
    private var chosenRobot: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        chosenRobot = "Sewer Snake"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
   
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "combatSegue" {
            let combatHandler: CombatViewController = segue.destination as! CombatViewController
            
            combatHandler.playerChoice = self.chosenRobot
        }
    }
   
}
