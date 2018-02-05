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
    var player: SKSpriteNode?
    var x: CGFloat?
    var y: CGFloat?
    
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
                block.alpha *= block.userData?.value(forKey: "life") as! CGFloat / 5
                block.physicsBody?.isDynamic = false
                block.physicsBody?.collisionBitMask = Category().block
                block.physicsBody?.contactTestBitMask = Category().block
                self.addChild(block)
            }
        }
    }
    
    private func settingPlayer() {
        
        self.x = self.frame.midX
        guard let x = self.x else { return }
        self.y = self.frame.midY + 100.0
        guard let y = self.y else { return }
        
        self.player = SKSpriteNode(color: UIColor.white, size: CGSize(width: BarStatus().width, height: BarStatus().height))
        self.player?.position = CGPoint(x: x, y: y)
        self.player?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: BarStatus().width, height: BarStatus().height))
        self.player?.physicsBody?.isDynamic = false
        self.player?.physicsBody?.collisionBitMask = Category().player
    }
    
    private func settingBall() {
//        guard let x = self.x else { return }
//        guard let y = self.y else { return }
        
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
