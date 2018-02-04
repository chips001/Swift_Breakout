//
//  GameScene.swift
//  Swift_Breakout
//
//  Created by 一木 英希 on 2018/01/24.
//  Copyright © 2018年 一木 英希. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let scoreDefault: UInt = 0
    let ballLifeDefault: UInt = 3
    let scoreMagnificationDefault: Int = 3
    var score: UInt?
    var ballLife: UInt?
    var scoreMagnification: Int?
    var isLoop: Bool = false
    var isRebone: Bool = false
    var isDead: Bool = false
    var showString: SKLabelNode?
    var deadzone: SKSpriteNode?
    
    override init(size: CGSize) {
        
        super.init(size: size)
        self.backgroundColor = UIColor.black
        self.settingPhysics()
        self.settingLife()
        self.settingDeadzone()
        self.settingBlock()
    }
    
    private func settingPhysics() {
        
        self.isLoop = false
        self.isRebone = false
        self.isDead = false
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
        self.physicsWorld.gravity = CGVector.init(dx: 0.0, dy: 0.0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.collisionBitMask = Category().wall
    }
    
    private func settingLife() {
        
        self.score = self.scoreDefault
        self.scoreMagnification = self.scoreMagnificationDefault
        self.ballLife = self.ballLifeDefault
        
        self.showString = SKLabelNode()
        if let showString = self.showString {
            showString.text = ("Life:\(String(describing: self.ballLife)) Score:\(String(describing: self.score))")
            showString.position = CGPoint(x: self.size.width/2, y: self.size.height - showString.frame.height - 20)
        }
    }
    
    private func settingDeadzone() {
        
        self.deadzone = SKSpriteNode()
        if let deadzone = self.deadzone {
            deadzone.position = CGPoint(x: self.size.width/2.0, y: 50.0)
            deadzone.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: 20))
            deadzone.physicsBody?.isDynamic = false
            deadzone.physicsBody?.collisionBitMask = Category().dead
            deadzone.physicsBody?.contactTestBitMask = Category().ball
        }
    }
    
    private func settingBlock() {
        
        for i in 1...BlockStatus().row{
            for j in 1...BlockStatus().col{
                let block = SKSpriteNode(color: UIColor.blue, size:CGSize(width: BlockStatus().width, height: BlockStatus().height))
                let blockPosition = CGPoint(x: CGFloat(i) * (self.size.width/CGFloat(BlockStatus().row + 1)), y:self.size.height - CGFloat(j) * (BlockStatus().height + BlockStatus().margin) - 50)
                block.name = "block"
                block.position = blockPosition
                block.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: BlockStatus().width, height: BlockStatus().height))
                block.userData = ["life": Int(arc4random() % 3 + 1)]
                
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func didMove(to view: SKView) {
    }

    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
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
    }
}
