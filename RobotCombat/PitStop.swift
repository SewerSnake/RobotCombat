//
//  PitStop.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-10.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class PitStop {
    
    // Retrieves an object of class Robot
    // for the given robot name. The robot
    // "Sewer Snake" is returned as a default
    // value.
    static func getRobot(_ theBot: String) -> Robot {
        
        switch theBot {
            
        case "Sewer Snake":
            return Robot(name: theBot, hp: 100, attack: 25)
        case "Last Rites":
            return Robot(name: theBot, hp: 85, attack: 35)
        case "Original Sin":
            return Robot(name: theBot, hp: 120, attack: 20)
        case "Spectre":
            return Robot(name: theBot, hp: 90, attack: 30)
        default:
            return Robot(name: theBot, hp: 100, attack: 25)
        }
    }
    
    // Retrieves an object of class Robot.
    // The robot is decided at random. Used
    // for deciding the AI's robot.
    static func getRandomRobot() -> Robot {
        
        let randomBot: Int = Int(arc4random_uniform(4)) + 1
        
        switch randomBot {
            
        case 1:
            return Robot(name: "Sewer Snake", hp: 100, attack: 25)
        case 2:
            return Robot(name: "Last Rites", hp: 85, attack: 35)
        case 3:
            return Robot(name: "Original Sin", hp: 120, attack: 20)
        case 4:
            return Robot(name: "Spectre", hp: 90, attack: 30)
        default:
            return Robot(name: "Sewer Snake", hp: 100, attack: 25)
        }
    }
    
}
