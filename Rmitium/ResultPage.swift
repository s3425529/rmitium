//
//  resultPage.swift
//  Rmitium
//
//  Created by Max on 12/09/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import SpriteKit

class ResultPage: SKScene{
    var facebook, twitter, redo, share: SKSpriteNode!
    var awardText:String!
    private let scale = UtilitiesPortal.screenHeight*0.20
    override func didMoveToView(view: SKView) {
        
        // facebook button
        facebook = SKSpriteNode(imageNamed: "facebookbutton")
        facebook.setScale(0.5)
        facebook.name = "facebook"
        facebook.alpha = 0.9
        //redo.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        facebook.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*2,
            y: UtilitiesPortal.screenHeight * 0.9)
        addChild(facebook)
        
        
        // twitter button
        twitter = SKSpriteNode(imageNamed: "twitterbutton")
        twitter.name = "twitter"
        twitter.setScale(0.5)
        twitter.alpha = 0.9
        //redo.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        twitter.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*2,
            y: UtilitiesPortal.screenHeight * 0.7)
        addChild(twitter)
        
        // redo button
        redo = SKSpriteNode(imageNamed: "retrybutton")
        redo.name = "retry"
        
        redo.alpha = 0.9
       // redo.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        redo.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*2,
            y: UtilitiesPortal.screenHeight * 0.5)
        addChild(redo)
        
        // next button
        share = SKSpriteNode(imageNamed: "nextbutton")
        share.name = "next"
        
        share.alpha = 0.9
       // share.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        share.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*2,
            y: UtilitiesPortal.screenHeight * 0.3)
        addChild(share)
        
        /*
        let award = SKSpriteNode(imageNamed: "medal")
        award.name = "award"
        award.zPosition = 10
        award.position = CGPoint(x:UtilitiesPortal.screenWidth/2,
            y: UtilitiesPortal.screenHeight/2)
        award.zPosition = 0.5
        award.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
        addChild(award)
        
        let score = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        awardText = String(UtilitiesPortal.score)
        score.text = awardText
        score.position = CGPoint(x:UtilitiesPortal.screenWidth/2,
            y: UtilitiesPortal.screenHeight/2)
        score.zPosition = 1
        addChild(score)
        */
        
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let location = touch!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        
        //share button selected
        if node.name == UtilitiesPortal.shareButtonName {
            print("share")
            let shareContent = awardText
            displayShareSheet(shareContent)
            UtilitiesPortal.score = 0
            return
        }
        
        //redo button selected
        if node.name == UtilitiesPortal.redoButtonName {
            print("redo")
            UtilitiesPortal.score = 0
            backLevel1()
            return
        }
        //back button selected
        if node.name == UtilitiesPortal.backButtonName {
            print("back")
            UtilitiesPortal.score = 0
            backHomePage()
            return
        }
        if node.name == UtilitiesPortal.homeButtonName {
            backHomePage()
            
            return
        }
        
        
    }
    
    // Share the score to any social media!
    func displayShareSheet(shareContent:String) {
        
        let myShare = "My best is \(shareContent)"
        let controller = self.view?.window?.rootViewController as! GameViewController
        
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [myShare], applicationActivities: nil)
        
        controller.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    //back to the home page,
    func backHomePage(){
        let secondScene = GameScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
        UtilitiesPortal.score = 0
    }
    
    func backLevel1(){
        let secondScene = LevelOneScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
        //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
        UtilitiesPortal.score = 0
        
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    
}