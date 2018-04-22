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
    
    private var gameOver: Bool = false
    
    private var beatenRobots: Int = 0
    
    private var player: GameObject!
    
    private var enemy: GameObject!
    
    override func didMove(to view: SKView) {
        makePlayer()
        makeEnemy()
        makeUI()
    }
    
    func makePlayer() {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        playerRobot = userDefaults.string(forKey: "playerRobot")!
        
        playerSprite = SKSpriteNode(imageNamed: playerRobot)
        
        playerSprite.position = CGPoint(x: 0, y: -self.size.height / 4)
        
        scaleImage(playerSprite, playerRobot)
        
        addChild(playerSprite)
        
        player = GameObject(sprite: playerSprite, direction: 0.0, speed: 0.0, botName: playerRobot)
    }
    
    func makeEnemy() {
        let robotName: String = PitStop.getRandomRobot()
        let enemySprite = SKSpriteNode(imageNamed: robotName)
        
        enemySprite.position = CGPoint(x: 0, y: self.size.height / 4)
        
        scaleImage(enemySprite, robotName)
        
        addChild(enemySprite)
        
        enemy = GameObject(sprite: enemySprite, direction: 0.0, speed: 0.0, botName: robotName)
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
        let attacks: [String] = PitStop.getAttacksForRobot(playerRobot)
        
        info.color = UIColor.white
        info.fontSize = 26
        info.fontName = "American Typewriter"
        info.position = CGPoint(x: 0, y: -self.size.height / 2.1)
        info.text = "Sewer Snake used Fork Rush! Original Sin took 49 damage."
        addChild(info)
        
        let attackOne: SKLabelNode = SKLabelNode()
        attackOne.color = UIColor.white
        attackOne.fontSize = 30
        attackOne.fontName = "American Typewriter"
        attackOne.position = CGPoint(x: -self.size.width / 3, y: -self.size.height / 2.4)
        attackOne.text = attacks[0]
        attackOne.name = "attackOne"
        addChild(attackOne)
        
        let attackTwo: SKLabelNode = SKLabelNode()
        attackTwo.color = UIColor.white
        attackTwo.fontSize = 30
        attackTwo.fontName = "American Typewriter"
        attackTwo.position = CGPoint(x: 0, y: -self.size.height / 2.4)
        attackTwo.text = attacks[1]
        attackTwo.name = "attackTwo"
        addChild(attackTwo)
        
        let attackThree: SKLabelNode = SKLabelNode()
        attackThree.color = UIColor.white
        attackThree.fontSize = 30
        attackThree.fontName = "American Typewriter"
        attackThree.position = CGPoint(x: self.size.width / 3, y: -self.size.height / 2.4)
        attackThree.text = attacks[2]
        attackThree.name = "attackThree"
        addChild(attackThree)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameOver == false {
            
            let firstMove: UInt32 = arc4random_uniform(2)
            var attackIndex: Int = 0
            
            for touch in touches {
                let location = touch.location(in: self)
                let node = atPoint(location)
                
                if node.name == "attackOne" {
                    info.text = "1"
                    attackIndex = 1
                } else if node.name == "attackTwo" {
                    info.text = "2"
                    attackIndex = 2
                } else if node.name == "attackThree" {
                    info.text = "3"
                    attackIndex = 3
                }
            }
            
            if firstMove == 0 {
                executeAttackPlayer(attackIndex)
            } else {
                executeAttackEnemy(attackIndex)
            }
        }
    }
    
    func executeAttackPlayer(_ attackIndex: Int) {
        print("Player attacks!")
    }
    
    func executeAttackEnemy(_ attackIndex: Int) {
        print("Enemy attacks!")
    }
    
}
