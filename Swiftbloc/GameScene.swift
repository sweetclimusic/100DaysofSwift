//
//  GameScene.swift
//  Swiftbloc
//
//  Created by Ashlee Muscroft on 04/09/2020.
//  Copyright © 2020 Ashlee Muscroft. All rights reserved.
//

import SpriteKit
import GameplayKit

let TickLengthLevelOne = TimeInterval(600)

class GameScene: SKScene {
        
    var bgImageName: String = "background"
    var tickLenMills = TickLengthLevelOne
    var lastTick:Date? = nil
    //optional tick void closure
    var tick:(() -> ())?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    fileprivate func setBackgroundImageFromFile(bgImage: String = "background") {
        let background = SKSpriteNode(imageNamed: bgImage)
        //pin background and add it to sceneNode
        background.position = CGPoint(x:0, y:0)
        background.anchorPoint = anchorPoint
        addChild(background)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        //drawing of swiftbloc from Top down. rendereing is opengl with 0,0 being bottom left of the screen
        anchorPoint = CGPoint(x: 0, y: 1.0)
        setBackgroundImageFromFile(bgImage: bgImageName)
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        guard let lastTick = lastTick else {
            return
        }
        let timePassed = lastTick.timeIntervalSinceNow * -1000.00
        if timePassed > tickLenMills {
            self.lastTick = Date()
            //perform tick is functioning
            tick?()
        }
        
    }
    func startTicking () {
        lastTick = Date()
    }
    func stop () {
        lastTick = nil
    }
}
