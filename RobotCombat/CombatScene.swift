//
//  CombatScene.swift
//  RobotCombat
//
//  Created by Eric Groseclos on 2018-04-18.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class CombatScene: SKScene {
    
    private var combat: Combat = Combat()
    
    private var playerSprite: SKSpriteNode!
    
    private var enemySprite: SKSpriteNode!
    
    //private var player: GameObject!
    
    //private var enemy: GameObject!
    
    override func didMove(to view: SKView) {
        makePlayerSprite()
        makeEnemySprite()
    }
    
    func makePlayerSprite() {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        let robotName: String = userDefaults.string(forKey: "playerRobot")!
        
        playerSprite = SKSpriteNode(imageNamed: robotName)
        
        playerSprite.position = CGPoint(x: 0, y: -self.size.height / 3)
        
        scaleImage(playerSprite, robotName)
        
        addChild(playerSprite)
    }
    
    func makeEnemySprite() {
        let robotName: String = PitStop.getRandomRobot()
        let enemySprite = SKSpriteNode(imageNamed: robotName)
        
        enemySprite.position = CGPoint(x: 0, y: self.size.height / 3)
        
        scaleImage(enemySprite, robotName)
        
        addChild(enemySprite)
    }
    
    // Scales the image so that it fits
    // in the scene.
    func scaleImage(_ sprite: SKSpriteNode, _ name: String) {
        switch name {
        case "Original Sin":
            sprite.xScale = 1
            sprite.yScale = 1
        case "Sewer Snake":
            sprite.xScale = 0.3
            sprite.yScale = 0.3
        case "Last Rites":
            sprite.xScale = 1.7
            sprite.yScale = 1.7
        case "Spectre":
            sprite.xScale = 0.6
            sprite.yScale = 0.6
        default:
            sprite.xScale = 1
            sprite.yScale = 1
        }
    }
    
}
