//
//  Content.swift
//  Swift_Breakout
//
//  Created by 一木 英希 on 2018/01/24.
//  Copyright © 2018年 一木 英希. All rights reserved.
//

import UIKit
import SpriteKit

struct Category {
    let block:  UInt32 = 1 << 0
    let ball:   UInt32 = 1 << 1
    let wall:   UInt32 = 1 << 2
    let player: UInt32 = 1 << 3
    let dead:   UInt32 = 1 << 4
}
