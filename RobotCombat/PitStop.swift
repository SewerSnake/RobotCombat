//
//  PitStop.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-10.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class PitStop {
    
    private var robots: [String] = ["Sewer Snake","Last Rites","Original Sin","Spectre"]
    
    private var battleLog: [Bool] = [false, false, false, false]
    
    // Retrieves an object of class Robot
    // for the given robot name. The robot
    // "Sewer Snake" is returned as a default
    // value.
    func getRobot(_ theBot: String) -> Robot {
        
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
    
    // Retrieves the name of a random robot.
    // Used for deciding the enemy robot.
    // Ensures that the enemy doesn't have
    // the same robot as the player.
    func getRandomRobot(_ robotName: String) -> String {
        var randomBotIndex: Int
        
        repeat {
            randomBotIndex = Int(arc4random_uniform(4))
        } while robots[randomBotIndex] == robotName || battleLog[randomBotIndex] == true
        
        battleLog[randomBotIndex] = true
        
        switch randomBotIndex {
            
        case 0:
            return "Sewer Snake"
        case 1:
            return "Last Rites"
        case 2:
            return "Original Sin"
        case 3:
            return "Spectre"
        default:
            return "Sewer Snake"
        }
    }
    
    // Returns the attack names of the
    // given robot.
    func getAttacksForRobot(_ theBot: String) -> [String] {
        switch theBot {
            
        case "Sewer Snake":
            return ["Flamethrower","Fork Rush","Denying Plow"]
        case "Last Rites":
            return ["Destructive Bar","Backhand","Spinning Doom"]
        case "Original Sin":
            return ["Absolute Wedge","Burnout","Box Rush"]
        case "Spectre":
            return ["Body Slam","Crunch","Haul"]
        default:
            return ["Flamethrower","Fork Rush","Denying Plow"]
        }
    }
    
}
