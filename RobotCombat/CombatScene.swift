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
    
    private let userDefaults: UserDefaults = UserDefaults.standard
    
    private let playerRobotKey = "playerRobot"
    
    private let victory: String = "You won!"
    
    private let defeat: String = "Game over..."
    
    private var combat: Combat = Combat()
    
    private var pitStop: PitStop = PitStop()
    
    private let worldNode: SKNode = SKNode()
    
    private var playerSprite: SKSpriteNode!
    
    private var enemySprite: SKSpriteNode!
    
    private var playerRobot: String!
    
    private let info: SKLabelNode = SKLabelNode()
    
    private let attackOne: SKLabelNode = SKLabelNode()
    
    private let attackTwo: SKLabelNode = SKLabelNode()
    
    private let attackThree: SKLabelNode = SKLabelNode()
    
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
        playerRobot = userDefaults.string(forKey: playerRobotKey)!
        
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
        enemySprite.updateFocusIfNeeded()
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
        info.text = ""
        worldNode.addChild(info)
        addChild(worldNode)
        
        attackOne.fontSize = 30
        attackOne.fontName = "American Typewriter"
        attackOne.position = CGPoint(x: -self.size.width / 3, y: -self.size.height / 2.4)
        attackOne.text = attacks[0]
        attackOne.name = "attackOne"
        addChild(attackOne)
        
        attackTwo.fontSize = 30
        attackTwo.fontName = "American Typewriter"
        attackTwo.position = CGPoint(x: 0, y: -self.size.height / 2.4)
        attackTwo.text = attacks[1]
        attackTwo.name = "attackTwo"
        addChild(attackTwo)
        
        attackThree.fontSize = 30
        attackThree.fontName = "American Typewriter"
        attackThree.position = CGPoint(x: self.size.width / 3, y: -self.size.height / 2.4)
        attackThree.text = attacks[2]
        attackThree.name = "attackThree"
        addChild(attackThree)
        
        attackOne.run(SKAction.colorize(with: UIColor.green, colorBlendFactor: 1, duration: 1))
        attackTwo.run(SKAction.colorize(with: UIColor.green, colorBlendFactor: 1, duration: 1))
        attackThree.run(SKAction.colorize(with: UIColor.green, colorBlendFactor: 1, duration: 1))
    }
    
    // Action is only taken if the game hasn't ended and
    // the robots aren't currently fighting.
    // Registers which attack the user pressed.
    // Randomly decides which robot that will attack
    // first and starts battle.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameOver == false && !playerSprite.hasActions() && !enemySprite.hasActions() {
            
            let firstMove: UInt32 = arc4random_uniform(2)
            attackIndex = 0
            
            for touch in touches {
                let location = touch.location(in: self)
                let node = atPoint(location)
                
                if node.name == "attackOne" {
                    attackIndex = 1
                } else if node.name == "attackTwo" {
                    attackIndex = 2
                } else if node.name == "attackThree" {
                    attackIndex = 3
                }
            }
            
            if attackIndex > 0 {
                if firstMove == 0 {
                    executeAttackPlayer()
                } else {
                    executeAttackEnemy()
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    func executeAttackPlayer() {
        print("Player attacks!")
        var damage: Int = combat.calcDamagePlayer(playerRobot, attackIndex)
        
        enemy.robot.takeDamage(damage)
        attackAnimation(true)
        info.text = "\(enemy.robot.getName()) took \(damage) damage."
        pauseGame(2.0)
        
        if checkBots() {
            damage = combat.calcDamageAI(enemy.robot.getName())
            player.robot.takeDamage(damage)
            attackAnimation(false)
            info.text = "\(player.robot.getName()) took \(damage) damage."
        }
        
        if checkBots() {
            pauseGame(2.0)
        }
    }
    
    func executeAttackEnemy() {
        print("Enemy attacks!")
        var damage: Int = combat.calcDamageAI(enemy.robot.getName())
        
        player.robot.takeDamage(damage)
        attackAnimation(false)
        info.text = "\(player.robot.getName()) took \(damage) damage."
        pauseGame(2.0)
        
        if checkBots() {
            damage = combat.calcDamagePlayer(playerRobot, attackIndex)
            enemy.robot.takeDamage(damage)
            attackAnimation(true)
            info.text = "\(enemy.robot.getName()) took \(damage) damage."
        }
        
        if checkBots() {
            pauseGame(2.0)
        }
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
            
            player.sprite.removeFromParent()
            
            disableAttacks()
            
            info.text = defeat
            
            pauseGame(2.0)
            
            continueFighting = false
        }
        
        if enemy.robot.isDestroyed() {
            continueFighting = false
            
            beatenRobots = beatenRobots + 1
            
            enemy.sprite.removeFromParent()
            
            if beatenRobots != 3 {
                player.robot.repair()
                
                if gameOver == false {
                    // Wait until the enemy has stopped moving
                    // repeat {} while enemySprite.hasActions()
                    // could potentially work, but it seems to
                    // makes the app crash.
                    makeEnemy()
                }
            } else {
                gameOver = true
                
                disableAttacks()
                
                info.text = victory
                
                pauseGame(2)
            }
        }
        return continueFighting
    }
    
    // Pauses the game for the specified
    // TimeInterval. The unit is seconds.
    // DOESN'T SEEM TO WORK, THOUGH...
    func pauseGame(_ duration: TimeInterval) {
        
        let pause = SKAction.run {
            self.worldNode.isPaused = true
            self.physicsWorld.speed = 0
        }
        
        let wait = SKAction.wait(forDuration: duration)
        
        run(SKAction.sequence([pause, wait]))
        
        worldNode.isPaused = false
        physicsWorld.speed = 1
    }
    
    // Changes the colors of the attack
    // "buttons" to red, to indicate
    // that the user shouldn't press them.
    func disableAttacks() {
        attackOne.run(SKAction.colorize(with: UIColor.red, colorBlendFactor: 1, duration: 1))
        attackTwo.run(SKAction.colorize(with: UIColor.red, colorBlendFactor: 1, duration: 1))
        attackThree.run(SKAction.colorize(with: UIColor.red, colorBlendFactor: 1, duration: 1))
    }
    
    // Moves a sprite to signify that the
    // robot is fighting.
    func attackAnimation(_ isPlayersTurn: Bool) {
        let originalPos: CGPoint
        
        if isPlayersTurn {
            originalPos = self.player.sprite.position
            
            self.player.sprite.run(
                SKAction.sequence([SKAction.move(to: self.enemy.sprite.position, duration: 2),
                                   SKAction.wait(forDuration: 1),
                                   SKAction.move(to: originalPos, duration: 2)]))
        } else {
            originalPos = self.enemy.sprite.position
            
            self.enemy.sprite.run(
                SKAction.sequence([SKAction.move(to: self.player.sprite.position, duration: 2),
                                   SKAction.wait(forDuration: 1),
                                   SKAction.move(to: originalPos, duration: 2)]))
        }
    }
    
}
