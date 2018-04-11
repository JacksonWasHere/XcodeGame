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
    
    let rows = 1
    let perRow = 4
    let width = 500
    let height = 300
    
    override func didMove(to view: SKView) {
        scene?.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        paddle = self.childNode(withName: "paddle") as! SKSpriteNode
        
        for i in 0..<rows {
            for j in 0..<perRow {
                let spacingX = width/perRow
                let spacingY = height/rows
                spawnBrick(x: CGFloat(spacingX * (j))-245, y: CGFloat(spacingY * i)+552)
            }
        }
    }
    
    func spawnBrick(x:CGFloat,y:CGFloat) {
        let scene:SKScene = SKScene(fileNamed: "Block")!
        let brock = scene.childNode(withName: "brock")!
        
        brock.position = CGPoint(x: x, y: y)
        brock.move(toParent: self)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
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
