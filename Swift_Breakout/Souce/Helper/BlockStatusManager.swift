//
//  BlockStatusManager.swift
//  Swift_Breakout
//
//  Created by 一木 英希 on 2018/02/06.
//  Copyright © 2018年 一木 英希. All rights reserved.
//

import SpriteKit
import GameplayKit

class BlockStatusManager: NSObject {
    
    static let sharedManager = BlockStatusManager()
    
    let row: Int = 10
    let col: Int = 10
    let width: CGFloat = 30.0
    let height: CGFloat = 20.0
    let margin: CGFloat = 1.0
    var x: CGFloat?
    var y: CGFloat?
    
    private override init() {
        super.init()
    }
    
    func createBlock(frame: CGRect, row: Int, col: Int) -> SKSpriteNode {
        
        let block = SKSpriteNode(color: UIColor.blue, size:CGSize(width: self.width, height: self.height))
        let blockPosition = CGPoint(x: CGFloat(row) * (frame.size.width/CGFloat(self.row + 1)), y:frame.size.height - CGFloat(col) * (self.height + self.margin) - 50)
        block.name = "block"
        block.position = blockPosition
        block.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.width, height: self.height))
        block.userData = ["life": Int(arc4random() % 3 + 1)]
        block.alpha *= block.userData?.value(forKey: "life") as! CGFloat / 5
        block.physicsBody?.isDynamic = false
        block.physicsBody?.collisionBitMask = CategoryManager.sharedManager.block
        block.physicsBody?.contactTestBitMask = CategoryManager.sharedManager.block
        
        return block
    }
}
