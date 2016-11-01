//
//  InfoScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 10/26/16.
//  Copyright © 2016 Spencer and Jones. All rights reserved.
//

// Info overlay for the home screen which uses an image for the text

import AudioToolbox
import SpriteKit
import AVFoundation

class InfoScene: SKScene {
    var first, second: SKSpriteNode!
    var isFirstTouch: Bool = false
    var current: CGFloat = 0.0
    //var cam: SKCameraNode!
    //var panRecognizer: UIPanGestureRecognizer!
    var autoScroll = true
    
    weak var scrollView: CustomScrollView!
    let moveableNode = SKNode()
    
    // Adding the image to the scene
    override func didMoveToView(view: SKView) {
        first = SKSpriteNode(imageNamed: "about2")
        first.anchorPoint = CGPointZero
        first.setScale(UtilitiesPortal.screenWidth/first.size.width)
        first.position = CGPointMake(0, UtilitiesPortal.screenHeight - first.size.height)
        //first.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        //addChild(first)
        
        scrollView = CustomScrollView(frame: CGRect(x: 0, y: UtilitiesPortal.navImgSize, width: self.frame.size.width, height: self.frame.size.height - UtilitiesPortal.navImgSize), scene: self, moveableNode: moveableNode, scrollDirection: .vertical)
        scrollView.contentSize = CGSizeMake(self.frame.size.width, first.size.height)
        self.view?.superview?.addSubview(scrollView)
        addChild(moveableNode)
        
        moveableNode.addChild(first)
        
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
        autoScroll = false
        
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
        if autoScroll {
            current = scrollView.contentOffset.y
            if current < first.size.height - UtilitiesPortal.screenHeight {
                scrollView.contentOffset = CGPointMake(0, current + 1);
            }
        }
    }
    
    override func willMoveFromView(view: SKView) {
        scrollView?.removeFromSuperview()
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
