//
//  content.swift
//  Swift_Breakout
//
//  Created by 一木 英希 on 2018/01/24.
//  Copyright © 2018年 一木 英希. All rights reserved.
//

import UIKit
import SpriteKit

struct BlockStatus {
    let row: Int = 10
    let col: Int = 10
    let width: CGFloat = 30.0
    let height: CGFloat = 20.0
    let margin: CGFloat = 1.0
    var x: CGFloat?
    var y: CGFloat?
}

struct BarStatus {
    let width: CGFloat = 20.0
    let height: CGFloat = 20.0
//    var player: SKSpriteNode?
//    var x: CGFloat?
//    var y: CGFloat?
}

struct BallStatus {
    let width: CGFloat = 8.0
    let height: CGFloat = 8.0
    var ball: SKShapeNode?
    var bx: CGFloat?
    var by: CGFloat?
}

struct Category {
    let block: UInt32 = 1 << 0
    let ball: UInt32 = 1 << 1
    let wall: UInt32 = 1 << 2
    let player: UInt32 = 1 << 3
    let dead: UInt32 = 1 << 4
}
