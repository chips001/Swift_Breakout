//
//  LifeAndScoreManager.swift
//  Swift_Breakout
//
//  Created by 一木 英希 on 2018/02/06.
//  Copyright © 2018年 一木 英希. All rights reserved.
//

import SpriteKit
import GameplayKit

class LifeAndScoreManager: NSObject {

    static let sharedManager = LifeAndScoreManager()
    
    var score: UInt?
    var ballLife: UInt?
    
    private override init() {
        super.init()
    }
    
    func getData() -> (life: UInt, score: UInt) {
        
        if let ballLife = self.ballLife, let score = self.score {
            return (life: ballLife, score: score)
        }
        fatalError()
    }
}
