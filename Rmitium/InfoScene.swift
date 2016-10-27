//
//  InfoScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 10/26/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

// Info overlay for the home screen which uses an image for the text

import AudioToolbox
import SpriteKit
import AVFoundation

class InfoScene: SKScene {
    var first, second: SKSpriteNode!
    var isFirstTouch: Bool = false
    var current = CGPoint(x: 0, y: 0)
    var cam: SKCameraNode!
    var panRecognizer: UIPanGestureRecognizer!
    
    
    // Adding the image to the scene
    override func didMoveToView(view: SKView) {
        first = SKSpriteNode(imageNamed: "about2")
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
        
        // Home button
        let home = SKSpriteNode(imageNamed: "home")
        home.name = UtilitiesPortal.homeButtonName
        home.zPosition = 0.1
        home.alpha = 1
        home.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        home.position = CGPoint(x:UtilitiesPortal.borderSize/2,
                                y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(home)
        
        // Recognising the scroll gesture
        panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(InfoScene.move(_:)))
        self.view?.addGestureRecognizer(panRecognizer)
    }
    
    // Moves the image based on the scroll gesture
    func move(sender: UISwipeGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            current = sender.locationInView(self.view)
        }
        else {
            let stop = sender.locationInView(self.view)
            let distance = -(stop.y - current.y)/10
            if first.position.y+distance < UtilitiesPortal.screenHeight-first.size.height {
                return
            }
            else if first.position.y+distance > 0 {
                return
            }

            first.position = CGPointMake(first.position.x, first.position.y + distance)
            
            if sender.state == UIGestureRecognizerState.Ended {
                current = CGPoint(x: 0, y: 0)
            }
        }
    }
    
    // User lifts the finger off the button
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
    // User first touches a button
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        if node.name == UtilitiesPortal.homeButtonName {
            cleanScene()
            let secondScene = GameScene(size: self.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
            //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
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
        self.view?.removeGestureRecognizer(panRecognizer)
        print("Clean Info Scene")
    }
}
