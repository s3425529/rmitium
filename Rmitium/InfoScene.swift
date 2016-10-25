//
//  InfoScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 10/26/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import AudioToolbox
import SpriteKit
import AVFoundation

class InfoScene: SKScene {
    var first, second: SKSpriteNode!
    var isFirstTouch: Bool = false
    var current = CGPoint(x: 0, y: 0)
    var cam: SKCameraNode!
    
    override func didMoveToView(view: SKView) {
        first = SKSpriteNode(imageNamed: "background")
        first.anchorPoint = CGPointZero
        first.setScale(UtilitiesPortal.screenWidth/first.size.width)
        first.position = CGPointMake(0, UtilitiesPortal.screenHeight - first.size.height)
        //first.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        addChild(first)
        
        /*cam = SKCameraNode()
        cam.setScale(0.25)
        cam.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.camera = cam
        self.addChild(cam)*/
        
        /*second = SKSpriteNode(imageNamed: "background")
        second.anchorPoint = CGPointZero
        second.position = CGPointMake(0, -first.size.height)
        second.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        addChild(second)*/
        
        UtilitiesPortal.setBgm(UtilitiesPortal.levelOther)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(InfoScene.move(_:)))
        self.view?.addGestureRecognizer(panRecognizer)
    }
    
    func move(sender: UISwipeGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            current = sender.locationInView(self.view)
        }
        else {
            let stop = sender.locationInView(self.view)
            if first.position.y-current.y+stop.y < UtilitiesPortal.screenHeight-first.size.height {
                return
            }
            else if first.position.y-current.y+stop.y > 0 {
                return
            }

            first.position = CGPointMake(first.position.x, first.position.y + stop.y - current.y)
            
            if sender.state == UIGestureRecognizerState.Ended {
                current = CGPoint(x: 0, y: 0)
            }
        }
    }
    
    // User lifts the finger off the button
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isFirstTouch {
            isFirstTouch = false
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isFirstTouch {
            let touch = touches.first
            let location = (touch?.locationInNode(self))!
            //cam.position = CGPoint(x: current.x, y: current.y + location.y - current.y)
        }
    }
    
    // User first touches a button
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !isFirstTouch {
            //current = cam.position
            isFirstTouch = true
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        //first.position = CGPointMake(first.position.x, first.position.y + 4)
        //second.position = CGPointMake(second.position.x, second.position.y + 4)
        
        /*if first.position.y > first.size.height {
            first.position = CGPointMake(first.position.x, second.position.y - second.size.height)
        }
        else if first.position.y < -first.size.height {
            first.position = CGPointMake(first.position.x, second.position.y + second.size.height)
        }
        if second.position.y > second.size.height {
            second.position = CGPointMake(second.position.x, first.position.y - first.size.height)
        }
        else if second.position.y < -second.size.height {
            second.position = CGPointMake(second.position.x, first.position.y + first.size.height)
        }*/
        
    }
    
    override func willMoveFromView(view: SKView) {
        self.removeAllActions()
        self.removeAllChildren()
        print("Remove all nodes Info Scene")
    }
    
    // Clear scene
    func cleanScene() {
        if let s = self.view?.scene {
            NSNotificationCenter.defaultCenter().removeObserver(self)
            self.enumerateChildNodesWithName("//") { node, _ in
                node.removeAllActions()
                node.removeAllChildren()
                node.removeFromParent()
            }
            s.removeAllActions()
            s.removeAllChildren()
            s.removeFromParent()
        }
        print("Clean Info Scene")
    }
}
