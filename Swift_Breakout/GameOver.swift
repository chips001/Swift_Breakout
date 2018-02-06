//
//  GameOver.swift
//  Swift_Breakout
//
//  Created by 一木 英希 on 2018/02/06.
//  Copyright © 2018年 一木 英希. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {

    var escapeDelegate: SKSceneDelegate?
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        let board = SKNode()
        self.backgroundColor = UIColor.black
        let gameover = SKLabelNode()
        gameover.text = "GameOver"
        gameover.fontSize = 50
        gameover.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        board.addChild(gameover)
        
        var values = LifeAndScoreManager.sharedManager.getData()
    }
}
