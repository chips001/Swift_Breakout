//
//  GameOver.swift
//  Swift_Breakout
//
//  Created by 一木 英希 on 2018/02/06.
//  Copyright © 2018年 一木 英希. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {
    
    var escapeProtocol: EscapeProtocol?

    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        let board = SKNode()
        self.backgroundColor = UIColor.black
        let gameover = SKLabelNode()
        gameover.text = "GameOver"
        gameover.fontSize = 50
        gameover.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        board.addChild(gameover)
        
        let values = LifeAndScoreManager.sharedManager.getData()
        self.criateLifeAndScore(board: board, gameover: gameover, life: UInt(values.life), score: UInt(values.score))
        
    }
    
    func criateLifeAndScore(board: SKNode, gameover: SKLabelNode, life: UInt, score: UInt) {
        
        let lifeAndScore = SKLabelNode()
        lifeAndScore.text = "Score: \(life) Life: \(score)"
        lifeAndScore.fontSize = 20
        lifeAndScore.position.x = gameover.position.x
        lifeAndScore.position.y = gameover.position.y - 40
        board.addChild(lifeAndScore)
        
        self.criateFinalScore(board: board, lifeAndScore: lifeAndScore, life: life, score: score)
    }
    
    func criateFinalScore(board: SKNode, lifeAndScore: SKLabelNode, life: UInt, score: UInt) {
        
        let finalScore = SKLabelNode()
        finalScore.text = "FinalScore = Life * Score"
        finalScore.position.x = lifeAndScore.position.x
        finalScore.position.y = lifeAndScore.position.y - 40
        board.addChild(finalScore)
        
        self.createScore(board: board, finalScore: finalScore, life: life, score: score)
    }
    
    func createScore(board: SKNode, finalScore: SKLabelNode, life: UInt, score: UInt) {
        
        let scoreLabel = SKLabelNode()
        scoreLabel.text = "\(life * score)"
        scoreLabel.position.x = finalScore.position.x
        scoreLabel.position.y = finalScore.position.y - 100
        board.addChild(scoreLabel)
        
        self.beforeScore(board: board, scoreLabel: scoreLabel, life: life, score: score)
    }
    
    func beforeScore(board: SKNode, scoreLabel: SKLabelNode, life: UInt, score: UInt) {
        
        let ud = UserDefaults()
        let beforeScore = ud.integer(forKey: "high_score")
        let afterScore = Int(life * score)
        if beforeScore < afterScore {
            ud.set(afterScore, forKey: "high_score")
        }
        
        let highScoreLabel = SKLabelNode()
        let highScore = ud.integer(forKey: "high_score")
        highScoreLabel.text = "HighScore: \(highScore)"
        highScoreLabel.position.x = scoreLabel.position.x
        highScoreLabel.position.y = scoreLabel.position.y - 100
        board.addChild(highScoreLabel)
    }
    
    func createReady(board: SKNode, highScoreLabel: SKLabelNode, life: UInt, score: UInt) {
        let ready = SKLabelNode()
        ready.text = "Tap to ready"
        ready.position.x = highScoreLabel.position.x
        ready.position.y = highScoreLabel.position.y - 100
        self.addChild(ready)
        
        self.addChild(board)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.escapeProtocol?.escape(scene: self)
    }
}
