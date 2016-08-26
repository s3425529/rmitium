//
//  result.swift
//  Rmitium
//
//  Created by Max on 25/08/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import SpriteKit

class Result: SKScene{
    var redo, share, back: SKSpriteNode!
    var awardText:String!
    override func didMoveToView(view: SKView) {
        
        
        let levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        levelLabel.zPosition = 0.1
        levelLabel.text = UtilitiesPortal.levelLabelTexts[0]
        levelLabel.fontSize = UtilitiesPortal.navLabelSize
        levelLabel.position = CGPointMake(frame.midX, UtilitiesPortal.screenHeight*0.92)
        self.addChild(levelLabel)
        
        // Home button
        let home = SKSpriteNode(imageNamed: "home")
        home.name = UtilitiesPortal.homeButtonName
        home.zPosition = 0.1
        home.alpha = 0.9
        home.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        home.position = CGPoint(x:UtilitiesPortal.borderSize/2,
            y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(home)
        
        // Help button
        let help = SKSpriteNode(imageNamed: "help2")
        help.zPosition = 0.1
        help.alpha = 0.9
        help.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        help.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
            y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(help)
        
        // back button
        back = SKSpriteNode(imageNamed: "next")
        back.name = UtilitiesPortal.backButtonName
        back.zPosition = 0.1
        back.alpha = 0.9
        back.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        back.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize,
            y: UtilitiesPortal.navImgSize/2)
        addChild(back)
        
        // redo button
        redo = SKSpriteNode(imageNamed: "replay")
        redo.name = UtilitiesPortal.redoButtonName
        redo.zPosition = 0.1
        redo.alpha = 0.9
        redo.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        redo.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*2,
            y: UtilitiesPortal.navImgSize/2)
        addChild(redo)
        
        // share button
        share = SKSpriteNode(imageNamed: "share")
        share.name = UtilitiesPortal.shareButtonName
        share.zPosition = 0.1
        share.alpha = 0.9
        share.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        share.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*3,
            y: UtilitiesPortal.navImgSize/2)
        addChild(share)
        
        
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