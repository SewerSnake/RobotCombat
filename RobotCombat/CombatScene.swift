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
    
    private var playerRobot: String!
    
    private var enemySprite: SKSpriteNode!
    
    private let info: SKLabelNode = SKLabelNode()
    
    //private var player: GameObject!
    
    //private var enemy: GameObject!
    
    override func didMove(to view: SKView) {
        makePlayerSprite()
        makeEnemySprite()
        makeUI()
    }
    
    func makePlayerSprite() {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        playerRobot = userDefaults.string(forKey: "playerRobot")!
        
        playerSprite = SKSpriteNode(imageNamed: playerRobot)
        
        playerSprite.position = CGPoint(x: 0, y: -self.size.height / 3)
        
        scaleImage(playerSprite, playerRobot)
        
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
    
    func makeUI() {
        
        info.color = UIColor.white
        info.fontSize = 28
        info.fontName = "American Typewriter"
        info.position = CGPoint(x: 0, y: -self.size.height / 2)
        info.text = "TEST"
        addChild(info)
        
        let attackOne: SKLabelNode = SKLabelNode()
        info.color = UIColor.white
        info.fontSize = 30
        info.fontName = "American Typewriter"
        info.position = CGPoint(x: -self.size.width / 3, y: -self.size.height / 3)
        info.text = "ATTACK 1"
        attackOne.name = "attackOne"
        addChild(attackOne)
        
        let attackThree: SKLabelNode = SKLabelNode()
        info.color = UIColor.white
        info.fontSize = 30
        info.fontName = "American Typewriter"
        info.position = CGPoint(x: self.size.width / 3, y: -self.size.height / 3)
        info.text = "ATTACK 3"
        attackOne.name = "attackThree"
        addChild(attackThree)
        //var attackTwo: SKLabelNode
        //var attackThree: SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("TOUCH!")
        
        for touch in touches {
            let location = touch.location(in: self)
            let node = atPoint(location)
            
            if node.name == "attackOne" {
                executeAttackPlayer(1)
                info.text = "1"
            } else if node.name == "attackTwo" {
                executeAttackPlayer(2)
                info.text = "2"
            } else if node.name == "attackThree" {
                executeAttackPlayer(3)
                info.text = "3"
            }
        }
    }
    
    func executeAttackPlayer(_ attackIndex: Int) {
        
    }
    
}
