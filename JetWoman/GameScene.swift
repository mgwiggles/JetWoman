//
//  GameScene.swift
//  JetWoman
//
//  Created by Mitch Guzman on 7/2/17.
//  Copyright © 2017 Mitch Guzman. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let jetWomanCategory = 2
    let spikesCategory = 3
    var score = 0
    
    let characters = ["A", "B","C", "D", "E", "1", "2", "3", "4"]
    let keyCodes = [0,11,8,14,18,19,20,21]
    
    var currentCharacter : String?
    var currentKeyCode : Int?
    
    private var label : SKLabelNode?
    private var jetWoman : SKSpriteNode?
    private var startButton : SKSpriteNode?
    private var scoreLabel : SKLabelNode?
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.jetWoman = self.childNode(withName: "jetwoman") as? SKSpriteNode
        
        self.startButton = self.childNode(withName: "startButton") as? SKSpriteNode
        
        self.scoreLabel = self.childNode(withName: "scoreLabel") as? SKLabelNode
        
    }
    
    func startGame() {
        if let jetWoman = self.jetWoman {
            jetWoman.position = CGPoint(x: 0, y: 100)
            jetWoman.physicsBody?.pinned = false
            
        }
    }
    
    func chooseNextKey() {
        
        let count = UInt32(characters.count)
        let randomIndex = Int(arc4random_uniform(count))
        
        currentCharacter = characters[randomIndex]
        currentKeyCode = keyCodes[randomIndex]
        
        if let label = self.label {
            label.text = currentCharacter
            label.alpha = 1.0
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        let point = event.location(in: self)
        
        let nodesAtPoint = nodes(at: point)
        
        for node in nodesAtPoint {
            if node.name == "startButton" {
                if let jetWoman = self.jetWoman {
                    
                    jetWoman.position = CGPoint(x: 0, y: 100)
                    
                    jetWoman.physicsBody?.pinned = false
                    
                    node.removeFromParent()
                    
                    score = 0
                    
                    scoreLabel?.text = "Score: \(score)"
                    
                    startGame()
                    
                    chooseNextKey()
                }
            }
        }
    }
    
    override func keyDown(with event: NSEvent) {
        
        if let theKeyCode = currentKeyCode {
            
            
            switch event.keyCode {
            case UInt16(theKeyCode):
                if let jetWoman = self.jetWoman {
                    jetWoman.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500))
                    
                    score += 1
                    
                    scoreLabel?.text = "Score: \(score)"
                    chooseNextKey()
                }
            default:
                print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if bodyA.categoryBitMask == spikesCategory || bodyB.categoryBitMask == spikesCategory {
            
            if let startButton = self.startButton {
                if startButton.parent != self {
                    addChild(startButton)
                }
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
