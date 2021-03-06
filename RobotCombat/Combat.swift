//
//  Combat.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-14.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class Combat {
    
    private var damage: Int!
    
    private var robot: String!
    
    enum SewerSnake: Int {
        case FlameThrower = 30
        case ForkRush = 45
        case DenyingPlow = 20
    }
    
    enum LastRites: Int {
        case DestructiveBar = 55
        case Backhand = 35
        case SpinningDoom = 50
    }
    
    enum OriginalSin: Int {
        case AbsoluteWedge = 15
        case Burnout = 40
        case BoxRush = 30
    }
    
    enum Spectre: Int {
        case BodySlam = 35
        case Crunch = 50
        case Haul = 45
    }
    
    // The attack of the enemy robot
    // is decided randomly. The damage the AI
    // does to the player is calculated by
    // accessing the corresponding enum for
    // the AI's robot.
    func calcDamageAI(_ enemyRobot: String) -> Int {
        self.robot = enemyRobot
        
        let attack: UInt32 = arc4random_uniform(3) + 1
        
        calculate(attack)
        
        return damage
    }
    
    // The attack number and robot name are provided by the SKScene.
    // The damage the player does to the AI is calculated by
    // accessing the corresponding enum for the player's robot.
    func calcDamagePlayer(_ playerRobot: String, _ attackNumber: Int) -> Int {
        self.robot = playerRobot
        
        calculate(UInt32(attackNumber))
        
        return damage
    }
    
    // Calculates how much the damage
    // the attack of the robot does
    // to its enemy.
    func calculate(_ attack: UInt32) {
        switch robot {
            
        case "Sewer Snake":
            
            if attack == 1 {
                damage = SewerSnake.FlameThrower.rawValue
            } else if attack == 2 {
                damage = SewerSnake.ForkRush.rawValue
            } else {
                damage = SewerSnake.DenyingPlow.rawValue
            }
            
        case "Last Rites":
            
            if attack == 1 {
                damage = LastRites.DestructiveBar.rawValue
            } else if attack == 2 {
                damage = LastRites.Backhand.rawValue
            } else {
                damage = LastRites.SpinningDoom.rawValue
            }
            
        case "Original Sin":
            
            if attack == 1 {
                damage = OriginalSin.AbsoluteWedge.rawValue
            } else if attack == 2 {
                damage = OriginalSin.Burnout.rawValue
            } else {
                damage = OriginalSin.BoxRush.rawValue
            }
            
        case "Spectre":
            
            if attack == 1 {
                damage = Spectre.BodySlam.rawValue
            } else if attack == 2 {
                damage = Spectre.Crunch.rawValue
            } else {
                damage = Spectre.Haul.rawValue
            }
            
        default:
            damage = 0
        }
    }
    
}
