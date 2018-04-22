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
    
    private var pitStop: PitStop = PitStop()
    
    private var robots: [String]!
    
    private var currentIndex: Int!

    // Assigns the array with the names
    // of the robots in the game.
    // Loads the picture and stats of
    // the robot "Sewer Snake".
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentIndex = 0
        
        self.robots = ["Sewer Snake","Last Rites","Original Sin","Spectre"]
        
        loadImageForIndex()
        
        getStats()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Loads the corresponding image
    // for the current index.
    func loadImageForIndex() {
        robotImage.image  = UIImage(named: self.robots[currentIndex])
    }
    
    // Shows the previous robot in the array.
    // Overlaps with the end of the list.
    @IBAction func previous(_ sender: Any) {
        self.currentIndex = self.currentIndex - 1
        
        if self.currentIndex == -1 {
            self.currentIndex = self.robots.count - 1
        }
        
        loadImageForIndex()
        
        getStats()
    }
    
    // Shows the next robot in the array.
    // Overlaps with the start of the list.
    @IBAction func next(_ sender: Any) {
        self.currentIndex = self.currentIndex + 1
        
        if self.currentIndex == self.robots.count {
            self.currentIndex = 0
        }
        
        loadImageForIndex()
        
        getStats()
    }
    
    // Changes the three labels to
    // match the current robot's
    // name, HP and ATK.
    func getStats() {
        let robot = pitStop.getRobot(self.robots[currentIndex])
        
        robotName.text = robot.getName()
        
        robotHP.text = "HP: \(robot.getHp())"
        
        robotATK.text = "ATK: \(robot.getAttack())"
    }
    
   
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "combatSegue" {
            let userDefaults: UserDefaults = UserDefaults.standard
            
            userDefaults.set(self.robots[currentIndex], forKey: "playerRobot")
            
            userDefaults.synchronize()
        }
    }
   
}
