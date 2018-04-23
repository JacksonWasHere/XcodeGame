//
//  GameScene.swift
//  BrEaaaK BroKK
//
//  Created by Mobile on 4/11/18.
//  Copyright © 2018 Mobile. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var paddle:SKSpriteNode!
    var ball:SKSpriteNode!
    var bottom:SKNode!
    
    let rows = 4
    let perRow = 5
    let width = 500
    let height = 300
    
    let ballCat:UInt32 = 1
    let paddleCat:UInt32 = 2
    let brickCat:UInt32 = 4
    let bottomCat:UInt32 = 8
    
    var playerDead = false
    var didWin = false
    var score = 0
    
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate=self
        
        scene?.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.linearDamping=0
        self.physicsBody?.friction=0
        self.physicsBody?.angularDamping=0
        self.physicsBody?.restitution=1
        self.physicsBody?.isDynamic=false
        
        bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: -self.frame.width/2, y: -self.frame.height/2+1), to: CGPoint(x: self.frame.width/2, y: -self.frame.height/2+1))
        bottom.physicsBody?.categoryBitMask = bottomCat
        bottom.physicsBody?.contactTestBitMask = ballCat
        self.addChild(bottom)
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        ball.physicsBody?.categoryBitMask = ballCat
        ball.physicsBody?.contactTestBitMask = paddleCat | brickCat | bottomCat
        
        paddle = self.childNode(withName: "paddle") as! SKSpriteNode
        paddle.physicsBody?.categoryBitMask = paddleCat
        paddle.physicsBody?.contactTestBitMask = ballCat
        
        for i in 0..<rows {
            for j in 0..<perRow {
                let spacingX = width/(perRow-1)
                let spacingY = height/(rows)
                spawnBrick(x: CGFloat(spacingX * (j))-245, y: -CGFloat(spacingY * i)+552)
            }
        }
    }
    
    func spawnBrick(x:CGFloat,y:CGFloat) {
        let scene:SKScene = SKScene(fileNamed: "Block")!
        let brock = scene.childNode(withName: "brock")!
        
        brock.physicsBody?.categoryBitMask = brickCat
        brock.physicsBody?.contactTestBitMask = ballCat
        
        brock.position = CGPoint(x: x, y: y)
        brock.move(toParent: self)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == ballCat || contact.bodyB.categoryBitMask == ballCat {
            
            let ballObj = contact.bodyA.contactTestBitMask==ballCat ? contact.bodyA : contact.bodyB
            
            if contact.bodyA.categoryBitMask == brickCat || contact.bodyB.categoryBitMask == brickCat {
                let brockObj = contact.bodyA.categoryBitMask==ballCat ? contact.bodyB : contact.bodyA
                brockObj.node?.removeFromParent()
            }
            
            else if contact.bodyA.categoryBitMask == bottomCat || contact.bodyB.categoryBitMask == bottomCat {
                let bottomBlock = contact.bodyA.categoryBitMask==ballCat ? contact.bodyB : contact.bodyA
                self.view?.presentScene(SKScene(fileNamed: "deadScene"))
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        paddle.position.x = pos.x
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
