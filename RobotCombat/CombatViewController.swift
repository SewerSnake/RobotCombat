//
//  CombatViewController.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-10.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class CombatViewController: UIViewController {
    
    // Loads SKScene "CombatScene" and starts it.
    // Ensures that the scene takes up the entire
    // screen of the phone.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            if let scene = SKScene(fileNamed: "CombatScene") {
                
                scene.scaleMode = .aspectFill
                
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            
            view.showsNodeCount = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Ensures that the status bar is hidden.
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
