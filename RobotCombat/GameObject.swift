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
    var direction: Float
    var speed: Float
    var robot: Robot
    
    private var pitStop: PitStop = PitStop()
    
    
    init(sprite: SKSpriteNode, botName: String) {
        self.sprite = sprite
        direction = 0.0
        speed = 0.0
        robot = pitStop.getRobot(botName)
    }
    
    init(sprite: SKSpriteNode, direction: Float, speed: Float, botName: String) {
        self.sprite = sprite
        self.direction = direction
        self.speed = speed
        robot = pitStop.getRobot(botName)
    }
    
    func tick(dt: Float) {
        let pos = sprite.position
        
        let newPos = CGPoint(x: CGFloat(Float(pos.x) + cosf(direction) * speed * dt), y: CGFloat(Float(pos.y) + sinf(direction) * speed * dt))
        
        sprite.position = newPos
    }
    
}
