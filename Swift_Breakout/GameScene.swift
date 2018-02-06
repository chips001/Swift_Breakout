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
        self.settingPlayer()
        self.settingBall()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        LifeAndScoreManager.sharedManager.score = self.scoreDefault
        self.scoreMagnification = self.scoreMagnificationDefault
        LifeAndScoreManager.sharedManager.ballLife = self.ballLifeDefault
        
        self.showString = SKLabelNode()
        if let showString = self.showString {
            showString.text = ("Life:\(String(describing: LifeAndScoreManager.sharedManager.ballLife)) Score:\(String(describing: LifeAndScoreManager.sharedManager.score))")
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
        
        for i in 1...BlockStatusManager.sharedManager.row{
            for j in 1...BlockStatusManager.sharedManager.col{
                let block = BlockStatusManager.sharedManager.createBlock(frame: self.frame, row: i, col: j)
                self.addChild(block)
            }
        }
    }
    
    private func settingPlayer() {
        
        BarStatusManager.sharedManager.createPlayer(frame: self.frame)
    }
    
    private func settingBall() {
        
        BallStatusManager.sharedManager.createBall()
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        if let showString = self.showString, let deadzone = self.deadzone, let player = BarStatusManager.sharedManager.player, let ball = BallStatusManager.sharedManager.ball{
            self.addChild(showString)
            self.addChild(deadzone)
            self.addChild(player)
            self.addChild(ball)
        }
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
