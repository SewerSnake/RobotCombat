//
//  Robot.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-09.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation

class Robot {
    
    private var name: String
    private var hp: Int
    private var baseHp: Int
    private var attack: Int
    
    // Instantiates the four properties. baseHp
    // allows the player robot to regain full
    // HP after destroying an enemy robot.
    init(name: String, hp: Int, attack: Int) {
        self.name = name
        self.hp = hp
        self.baseHp = hp
        self.attack = attack
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getHp() -> Int {
        return self.hp
    }
    
    func getAttack() -> Int {
        return self.attack
    }
    
    // Reduces the robot's HP
    // by the damage taken.
    // Ensures that it cannot
    // go below zero.
    func takeDamage(_ damage: Int) {
        self.hp -= damage
        
        if self.hp < 0 {
            self.hp = 0
        }
    }
    
    // If the robot's hp is
    // zero, it's considered to
    // be destroyed. true is then
    // returned. Otherwise, false
    func isDestroyed() -> Bool {
        return self.hp == 0 ? true : false
    }
    
    // Sets the robots current HP equal
    // to its maximal value.
    func repair() {
        self.hp = self.baseHp
    }
    
}
