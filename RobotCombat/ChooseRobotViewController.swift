//
//  ChooseRobotViewController.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-09.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit

class ChooseRobotViewController: UIViewController {
    
    @IBOutlet weak var robotImage: UIImageView!
    
    @IBOutlet weak var robotName: UILabel!
    
    @IBOutlet weak var robotHP: UILabel!
    
    @IBOutlet weak var robotATK: UILabel!
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    private var chosenRobot: String!
    
    private let defaultBot: String = "Sewer Snake"

    override func viewDidLoad() {
        super.viewDidLoad()
        robotImage.image = UIImage(named: defaultBot)
        chosenRobot = defaultBot
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func previous(_ sender: Any) {
        
    }
    
    @IBAction func next(_ sender: Any) {
        
    }
    
   
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "combatSegue" {
            let combatHandler: CombatViewController = segue.destination as! CombatViewController
            
            combatHandler.playerChoice = self.chosenRobot
        }
    }
   
}
