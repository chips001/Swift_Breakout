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
    
    var score: Int = 0
    var ballLife: Int = 0
    
    private override init() {
        super.init()
    }
    
    func getData() -> (life: Int, score: Int) {
        
        return (life: ballLife, score: score)
    }
}
