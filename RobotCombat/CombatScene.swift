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
    
    private let victory: String = "You won!"
    
    private let defeat: String = "Game over..."
    
    private var combat: Combat = Combat()
    
    private var pitStop : PitStop = PitStop()
    
    private var playerSprite: SKSpriteNode!
    
    private var enemySprite: SKSpriteNode!
    
    private var playerRobot: String!
    
    private let info: SKLabelNode = SKLabelNode()
    
    private var attackIndex: Int!
    
    private var gameOver: Bool = false
    
    private var beatenRobots: Int = 0
    
    private var player: GameObject!
    
    private var enemy: GameObject!
    
    override func didMove(to view: SKView) {
        makePlayer()
        makeEnemy()
        makeUI()
    }
    
    // Creates a GameObject for the
    // player robot. A SKSprite represents
    // it graphically. It also possesses a
    // direction and a speed value. The
    // GameObject also holds a Robot property,
    // for storing its HP and ATK.
    func makePlayer() {
        let userDefaults: UserDefaults = UserDefaults.standard
        
        playerRobot = userDefaults.string(forKey: "playerRobot")!
        
        playerSprite = SKSpriteNode(imageNamed: playerRobot)
        
        playerSprite.position = CGPoint(x: 0, y: -self.size.height / 4)
        
        scaleImage(playerSprite, playerRobot)
        
        addChild(playerSprite)
        
        player = GameObject(sprite: playerSprite, direction: 0.0, speed: 0.0, botName: playerRobot)
    }
    
    // Creates a GameObject for a
    // random enemy robot. It possesses
    // the same properties as the player.
    func makeEnemy() {
        let robotName: String = pitStop.getRandomRobot(playerRobot)
        
        enemySprite = SKSpriteNode(imageNamed: robotName)
        
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
        let attacks: [String] = pitStop.getAttacksForRobot(playerRobot)
        
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
            attackIndex = 0
            
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
                executeAttackPlayer()
            } else {
                executeAttackEnemy()
            }
        }
    }
    
    func executeAttackPlayer() {
        print("Player attacks!")
        enemy.robot.takeDamage(combat.calcDamagePlayer(playerRobot, attackIndex))
        if checkBots() {
            //player.robot.takeDamage(combat.calcDamageAI(enemy.robot.getName()))
        }
        checkBots()
    }
    
    func executeAttackEnemy() {
        print("Enemy attacks!")
        //player.robot.takeDamage(combat.calcDamageAI(enemy.robot.getName()))
        if checkBots() {
            enemy.robot.takeDamage(combat.calcDamagePlayer(playerRobot, attackIndex))
        }
        checkBots()
    }
    
    // Checks the status of the robots.
    // If the player's robot is destroyed,
    // the battle ceases and the player
    // is informed that he/she has lost the
    // game.
    // If the enemy robot is destroyed,
    // the player's robot is repaired.
    // A new enemy robot is then created.
    // However, if three robots have been
    // defeated, the player is declared
    // to have won the game.
    func checkBots() -> Bool {
        var continueFighting: Bool = true
        
        if player.robot.isDestroyed() {
            gameOver = true
            info.text = defeat
            print(defeat)
            continueFighting = false
        }
        
        if enemy.robot.isDestroyed() {
            continueFighting = false
            beatenRobots = beatenRobots + 1
            player.robot.repair()
            
            if beatenRobots != 4 {
                enemy.sprite.removeFromParent()
                makeEnemy()
            } else {
                gameOver = true
                info.text = victory
                print(victory)
            }
        }
        
        return continueFighting
    }
    
}
