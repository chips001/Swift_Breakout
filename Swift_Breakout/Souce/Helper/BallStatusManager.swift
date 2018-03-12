//
//  BallStatusManager.swift
//  Swift_Breakout
//
//  Created by 一木 英希 on 2018/02/06.
//  Copyright © 2018年 一木 英希. All rights reserved.
//

import SpriteKit
import GameplayKit

class BallStatusManager: NSObject {
    
    static let sharedManager = BallStatusManager()
    
    let width: CGFloat = 8.0
    let height: CGFloat = 8.0
    var ball: SKSpriteNode?
    var bx: CGFloat?
    var by: CGFloat?
    
    private override init() {
        super.init()
    }
    
    func createBall() {
        
        if let x = BarStatusManager.sharedManager.x, let y = BarStatusManager.sharedManager.y {
            self.bx = x
            self.by = y + 100
            
            if let bx = self.bx, let by = self.by {
                self.ball = SKSpriteNode(color: UIColor.yellow, size: CGSize(width: width, height: height))
                self.ball?.position = CGPoint(x: bx, y: by)
                self.ball?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
                self.ball?.physicsBody?.usesPreciseCollisionDetection = true
                self.ball?.physicsBody?.collisionBitMask = CategoryManager.sharedManager.ball
                self.ball?.physicsBody?.contactTestBitMask = CategoryManager.sharedManager.block | CategoryManager.sharedManager.dead | CategoryManager.sharedManager.player
                self.ball?.physicsBody?.allowsRotation = false
                self.ball?.physicsBody?.restitution = 1
                self.ball?.physicsBody?.friction = 0
                self.ball?.physicsBody?.linearDamping = 0
            }
            
        }
    }

}
