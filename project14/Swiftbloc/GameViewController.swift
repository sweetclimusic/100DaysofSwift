//
//  GameViewController.swift
//  Swiftbloc
//
//  Created by Ashlee Muscroft on 04/09/2020.
//  Copyright © 2020 Ashlee Muscroft. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var gameScene: GameScene!
    override func viewDidLoad() {
        super.viewDidLoad()
        //new gamescene
        guard let skView = view as? SKView else { return }
        skView.isMultipleTouchEnabled = false
        //create and configure scene
        gameScene = GameScene(size: skView.bounds.size)
        gameScene.scaleMode = .aspectFill
        skView.presentScene(gameScene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
