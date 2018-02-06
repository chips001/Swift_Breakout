//
//  GameViewController.swift
//  Swift_Breakout
//
//  Created by 一木 英希 on 2018/01/24.
//  Copyright © 2018年 一木 英希. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, SKSceneDelegate {

    var skView: SKView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.skView = self.view as? SKView
        if let skView = self.skView {
            skView.ignoresSiblingOrder = true
        }
    }
    
    func startGame() {
        
        if let skView = self.skView {
            let sence = GameScene(size: skView.bounds.size)
            sence.delegate = self
            skView.presentScene(sence)
        }
    }
    
    func gameover() {
        
        if let skView = self.skView {
            let sence = GameScene(size: skView.bounds.size)
            sence.delegate = self
            skView.presentScene(sence)
        }
    }
    
    func escape(scene: SKScene) {
        
        if scene.isKind(of: GameOver.self) {
            startGame()
        } else if scene.isKind(of: GameScene.self) {
            gameover()
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
