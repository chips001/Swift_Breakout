//
//  BarStatusManager.swift
//  Swift_Breakout
//
//  Created by 一木 英希 on 2018/02/06.
//  Copyright © 2018年 一木 英希. All rights reserved.
//

import SpriteKit
import GameplayKit

class BarStatusManager: NSObject {
    
    static let sharedManager = BarStatusManager()
    
    let width: CGFloat = 100.0
    let height: CGFloat = 20.0
    var player: SKSpriteNode?
    var x: CGFloat?
    var y: CGFloat?
    
    private override init() {
        super.init()
    }
    
    func createPlayer(frame: CGRect) {
        
        self.x = frame.midX
        self.y = frame.minY + 100.0
        
        if let x = self.x , let y = self.y {
            self.player = SKSpriteNode(color: UIColor.white, size: CGSize(width: self.width, height: self.height))
            self.player?.position = CGPoint(x: x, y: y)
            self.player?.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.width, height: self.height))
            self.player?.physicsBody?.isDynamic = false
            self.player?.physicsBody?.collisionBitMask = Category().player
        }
    }
}
