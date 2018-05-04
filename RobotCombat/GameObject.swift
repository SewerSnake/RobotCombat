//
//  GameObject.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-18.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation
import SpriteKit

class GameObject {
    
    let sprite: SKSpriteNode
    var robot: Robot
    
    private var pitStop: PitStop = PitStop()
    
    // A GameObject has a property which
    // contains a Robot, retrieved from
    // an object of class PitStop. 
    init(sprite: SKSpriteNode, botName: String) {
        self.sprite = sprite
        robot = pitStop.getRobot(botName)
    }
    
}
