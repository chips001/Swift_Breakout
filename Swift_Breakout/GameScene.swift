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
    
    var escapeProtocol: EscapeProtocol?
    
    var isLoop: Bool = false
    var isRebone: Bool = false
    var isDead: Bool = false
    var showString = SKLabelNode()
    var deadzone = SKSpriteNode()
    
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
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.collisionBitMask = Category().wall
    }
    
    private func settingLife() {
        
        self.showString.text = ("Life:\(String(describing: LifeAndScoreManager.sharedManager.ballLife))    Score:\(String(describing: LifeAndScoreManager.sharedManager.score))")
        self.showString.position = CGPoint(x: self.size.width/2, y: self.size.height - self.showString.frame.height - 20)
    }
    
    private func settingDeadzone() {
        
        self.deadzone.position = CGPoint(x: self.size.width/2.0, y: 50.0)
        self.deadzone.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: 20))
        self.deadzone.physicsBody?.isDynamic = false
        self.deadzone.physicsBody?.collisionBitMask = Category().dead
        self.deadzone.physicsBody?.contactTestBitMask = Category().ball
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
        if let player = BarStatusManager.sharedManager.player, let ball = BallStatusManager.sharedManager.ball{
            self.addChild(showString)
            self.addChild(deadzone)
            self.addChild(player)
            self.addChild(ball)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !self.isLoop {
            self.movingBall()
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if self.isLoop {
            for touch in touches {
                let location = touch.location(in: self)
                BarStatusManager.sharedManager.player?.position.x = location.x
            }
        }
    }

    class func getLifeAndScore() -> (life: Int, score: Int) {
        return (life: LifeAndScoreManager.sharedManager.ballLife, score: LifeAndScoreManager.sharedManager.score)
    }
    
    func movingBall() {
        
        self.isLoop = true
        let rnd = CGFloat(arc4random() % 4)
        let ballVal = CGVector(dx: ((arc4random() % 2 == 0) ? -200 - rnd: 200 + rnd), dy: 200 + rnd)
        BallStatusManager.sharedManager.ball?.physicsBody?.velocity = ballVal
    }
    
    func accelerate() {
        BallStatusManager.sharedManager.ball?.physicsBody?.velocity.dx *= 1.01
        BallStatusManager.sharedManager.ball?.physicsBody?.velocity.dy *= 1.01
    }
    
    func rebone() {
        self.isRebone = false
        LifeAndScoreManager.sharedManager.ballLife = LifeAndScoreManager.sharedManager.ballLife - 1
        self.isLoop = false
        BallStatusManager.sharedManager.ball?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if let x = BarStatusManager.sharedManager.x, let y = BarStatusManager.sharedManager.y {
            BarStatusManager.sharedManager.player?.position = CGPoint(x: x, y: y)
        }
        
        if let bx = BallStatusManager.sharedManager.bx, let by = BallStatusManager.sharedManager.by {
            BallStatusManager.sharedManager.ball?.position = CGPoint(x: bx, y: by)
        }
    }
    
    func restart() {
        self.escapeProtocol?.escape(scene: self)
    }
    
    func didBiginContact(contact: SKPhysicsContact) {
        var first: SKPhysicsBody
        var second: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            first = contact.bodyA
            second = contact.bodyB
        } else {
            first = contact.bodyB
            second = contact.bodyA
        }
        
        if first.categoryBitMask == Category().ball {
            switch second.collisionBitMask {
                
            case Category().block:
                self.accelerate()
                
                LifeAndScoreManager.sharedManager.score = LifeAndScoreManager.sharedManager.score + 10 + (10 * LifeAndScoreManager.sharedManager.scoreMagnification)
                LifeAndScoreManager.sharedManager.scoreMagnification = LifeAndScoreManager.sharedManager.scoreMagnification + 1
                
                var life: Int = second.node?.userData?.value(forKey: "life") as! Int
                life = life - 1
                second.node?.userData?.setValue(life, forKey: "life")
                second.node?.alpha *= 0.5
                
                if (second.node?.userData?.value(forKey: "life") as! Int) < 1 {
                    second.node?.removeFromParent()
                }
            case Category().dead:
                if LifeAndScoreManager.sharedManager.ballLife > 1 {
                    self.isRebone = true
                } else {
                    self.isDead = true
                }
            case Category().player:
                LifeAndScoreManager.sharedManager.scoreMagnification = 0
            default:
                break
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.showString.text = "Life:\(LifeAndScoreManager.sharedManager.ballLife)    Score:\(LifeAndScoreManager.sharedManager.score)"
        
        if self.isRebone {
            self.rebone()
        }
        
        if self.isDead == true || self.childNode(withName: "block") == nil {
            self.restart()
        }
    }
    

}
