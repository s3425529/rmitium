//
//  resultPage.swift
//  Rmitium
//
//  Created by Max on 12/09/2016.
//  Copyright © 2016 Spencer and Jones. All rights reserved.
//

import AVFoundation
import SpriteKit
import Social

class ResultPage: SKScene {
    var facebook, twitter, redo, finish: CustomButton!
    var i = 0
    var levelLabel: SKLabelNode!
    var homeDialogue: SKShapeNode!
    var homeView, newRecordLabel :SKSpriteNode!
    //var text: SKLabelNode!
    var text, text1: SKMultilineLabel!
    var socialData:SocialClass!
    var audioPlayer = AVAudioPlayer()
    var myTable:UITableView!
    var state = false
    var myView:SKShapeNode!
    
    override func didMoveToView(view: SKView) {
        if let clickSound = NSBundle.mainBundle().URLForResource("clickSound", withExtension: "wav") {
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: clickSound, fileTypeHint: nil)
                audioPlayer.prepareToPlay()
            }
            catch {
                fatalError("Error loading sound: \(error)")
            }
        }
        
        socialData = SocialClass()
        socialData.initClass()
        socialData.getRecord()
        addNewRecordLabel()
        setupMedal()
        setupItems()
        setupCustomerButton()
        DataHandler.saveLevelOneScore()
    }
    
    // Create medal node
    func setupMedal() {
        // Call the medalClass to get the relevant medal image and messages
        let medalDic = medalClass().assignMedal(UtilitiesPortal.levelOne)
        let medalName = medalDic.medalName
        let information1 = medalDic.information[0]
        let information2 = medalDic.information[1]
        
        // Create medalNode
        let medalNode = SKSpriteNode(imageNamed: medalName)
        newRecordLabel.hidden = !medalDic.newRecord
        medalNode.color = SKColor.blueColor()
        medalNode.name = "medal"
        medalNode.position = CGPoint(x: UtilitiesPortal.screenWidth / 3, y: UtilitiesPortal.screenHeight / 2)
        medalNode.size = CGSize(width: UtilitiesPortal.screenWidth/3*1.1, height: UtilitiesPortal.screenWidth / 3)
        medalNode.zPosition = 0.1
        
        // Make medal image to rotate
        let action = SKAction.rotateToAngle(CGFloat(M_PI/2), duration: 5)
        let action1 = SKAction.rotateToAngle(CGFloat(-M_PI/2), duration: 5)
        let sequen = SKAction.sequence([action,action1])
        let repeatAction = SKAction.repeatActionForever(sequen)
        addChild(medalNode)
        medalNode.runAction(repeatAction)
        
        // Sparkles for diamond medal only
        if medalName == "Medal1-Diamond" {
            let sparkles1 = SKSpriteNode(imageNamed: "sparkles1")
            sparkles1.position = CGPoint(x: UtilitiesPortal.screenWidth / 3, y: UtilitiesPortal.screenHeight / 2)
            sparkles1.size = CGSize(width: UtilitiesPortal.screenWidth/3*1.1, height: UtilitiesPortal.screenWidth / 3)
            sparkles1.zPosition = 0.2
            
            let action1_1 = SKAction.fadeOutWithDuration(0.6)
            let action1_2 = SKAction.fadeInWithDuration(0.6)
            let sequence1 = SKAction.sequence([action1_1, action1_2])
            let repeatAction1 = SKAction.repeatActionForever(sequence1)
            sparkles1.runAction(repeatAction1)

            let sparkles2 = SKSpriteNode(imageNamed: "sparkles2")
            sparkles2.position = CGPoint(x: UtilitiesPortal.screenWidth / 3, y: UtilitiesPortal.screenHeight / 2)
            sparkles2.size = CGSize(width: UtilitiesPortal.screenWidth/3*1.1, height: UtilitiesPortal.screenWidth / 3)
            sparkles2.zPosition = 0.2
            
            let action2_1 = SKAction.fadeInWithDuration(0.6)
            let action2_2 = SKAction.fadeOutWithDuration(0.6)
            let sequence2 = SKAction.sequence([action2_1, action2_2])
            let repeatAction2 = SKAction.repeatActionForever(sequence2)
            sparkles2.runAction(repeatAction2)
            
            addChild(sparkles1)
            addChild(sparkles2)
        }
        
        // Create scoreNode to display the current score
        let scoreNode = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        scoreNode.text = "\(UtilitiesPortal.score)"
        scoreNode.position = CGPoint(x: UtilitiesPortal.screenWidth / 3, y: UtilitiesPortal.screenHeight / 2.1)
        
        scoreNode.fontSize = UtilitiesPortal.screenHeight*0.07
        addChild(scoreNode)
        
        // Create title message e.g. 'Congratulations!' or 'Well done!'
        let p1 = CGPoint(x: UtilitiesPortal.screenWidth * 0.33, y: UtilitiesPortal.screenHeight * 0.92)
        text = SKMultilineLabel(text: information1, labelWidth: UtilitiesPortal.screenWidth*0.6, pos: p1)
        text.alignment = .Center
        text.leading =  Int(UtilitiesPortal.screenHeight*0.1)
        text.fontSize = UtilitiesPortal.screenHeight*0.05
        addChild(text)
        
        // Create encourage message node
        var p2 = CGPoint(x: UtilitiesPortal.screenWidth * 0.33, y: UtilitiesPortal.screenHeight * 0.50)
        text1 = SKMultilineLabel(text: information2, labelWidth: UtilitiesPortal.screenWidth*0.6, pos: p2)
        text1.alignment = .Center
        text1.leading =  Int(UtilitiesPortal.screenHeight*0.08)
        text1.fontSize = UtilitiesPortal.screenHeight*0.045
        
        let lines = text1.lineCount
        p2 = CGPoint(x: UtilitiesPortal.screenWidth * 0.33, y: text1.labelHeight + UtilitiesPortal.borderSize/2)
        if lines == 1 {
            p2 = CGPoint(x: UtilitiesPortal.screenWidth * 0.33, y: text1.labelHeight + UtilitiesPortal.borderSize/2 + UtilitiesPortal.screenHeight*0.08)
        }
        text1.pos = p2
        addChild(text1)
    }
    
    
    // Add home and info button
    func setupItems() {
        levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        levelLabel.zPosition = 0.1
        levelLabel.text = UtilitiesPortal.levelLabelTexts[0]
        levelLabel.fontSize = UtilitiesPortal.navLabelSize
        levelLabel.position = CGPointMake(frame.midX, UtilitiesPortal.screenHeight*0.92)
        self.addChild(levelLabel)
        
        // Home button
        let home = SKSpriteNode(imageNamed: "home")
        home.name = UtilitiesPortal.homeButtonName
        home.zPosition = 0.1
        home.alpha = 1
        home.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        home.position = CGPoint(x:UtilitiesPortal.borderSize/2,
                                y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(home)
        
        // Info button
        let info = SKSpriteNode(imageNamed: "help2")
        info.name = UtilitiesPortal.infoButonName
        info.zPosition = 0.1
        info.alpha = 1
        info.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        info.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
                                y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(info)
    }
    
    
    // Create Facebook, Twitter, redo, and finish buttons
    func setupCustomerButton() {
        facebook = CustomButton(defaultButtonImage: "facebookbutton", activeButtonImage: "facebookbutton1", buttonAction: facebookAction,scale: 0.2)
        facebook.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*3,
                                    y: UtilitiesPortal.screenHeight * 0.8)
        facebook.name = "facebook"
        facebook.frame.width
        // facebook.setScale(scale1)
        
        twitter = CustomButton(defaultButtonImage: "twitterbutton", activeButtonImage: "twitterbutton1", buttonAction: twitterAction,scale: 0.2)
        twitter.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*3,
                                   y: UtilitiesPortal.screenHeight * 0.6)
        twitter.name = "twitter"
        //twitter.setScale(scale1)
        
        redo = CustomButton(defaultButtonImage: "retrybutton", activeButtonImage: "retrybutton1", buttonAction: redoAction,scale: 0.2)
        redo.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*3,
                                y: UtilitiesPortal.screenHeight * 0.4)
        redo.name = "redo"
        //redo.setScale(scale1)
        
        finish = CustomButton(defaultButtonImage: "finishbutton", activeButtonImage: "finishbutton1", buttonAction: backHomePage, scale: 0.2)
        finish.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*3,
                                y: UtilitiesPortal.screenHeight * 0.2)
        finish.name = "finish"
        //finish.setScale(scale1)
        
        addChild(facebook)
        addChild(twitter)
        addChild(redo)
        addChild(finish)
    }
    
    
    // If Facebook is used at the fist time, the permissions alert message will display.
    // If not, the Facebook dialog box will display
    func facebookAction() {
        if socialData.facebook == true {
            activeFacebook()
        }
        else {
            facebookAlertMessage()
        }
        
    }
    
    // Display Facebook
    func activeFacebook() {
        let controller = self.view?.window?.rootViewController as! GameViewController
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookController.setInitialText(socialMessage())
           // facebookController.addImage(UIImage(named: "next"))
            controller.presentViewController(facebookController, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Facebook Unavailable", message: "Be sure to go to Settings > Facebook to set up your account", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            controller.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // If Twitter is used at the fist time, the permissions alert message will display.
    // If not, the twitter dialog box will display
    func twitterAction() {
        if socialData.twitter == true {
            activeTwitter()
        }
        else {
            twitterAlertMessage()
        }
    }
    
    // Display Twitter
    func activeTwitter() {
        let controller = self.view?.window?.rootViewController as! GameViewController
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let twitterController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterController.setInitialText(socialMessage())
            //facebookController.addImage(UIImage(named: "next"))
            controller.presentViewController(twitterController, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Twitter Unavailable", message: "Be sure to go to Settings > Twitter to set up your account", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            controller.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // A convinient function to set up social media message
    func socialMessage() -> String {
        let score = round(Double(DataHandler.getLevelOnePercentage()) * 100) / 1
        return "I got \(score)% in Level 1 of Chirality!"
    }
    
    // Retry level 1
    func redoAction() {
        backLevel1()
        return
    }

    
    // Share the score to any social media!
    func displayShareSheet(shareContent:String) {
        let myShare = "My best is \(shareContent)"
        let controller = self.view?.window?.rootViewController as! GameViewController
        
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [myShare], applicationActivities: nil)
        
        controller.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    // Back to the home page
    func backHomePage() {
        cleanScene()
        self.removeAllActions()
        self.removeAllChildren()
        UtilitiesPortal.score = 0
        UtilitiesPortal.totalQuestions = 0
        let secondScene = GameScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
        removeAllActions()
        removeFromParent()
        removeAllChildren()
    }
    
    // to go to Level 1 sence
    func backLevel1() {
        cleanScene()
        self.removeAllActions()
        self.removeAllChildren()
        LevelOneModel.reset()
        UtilitiesPortal.score = 0
        UtilitiesPortal.totalQuestions = 0
        let secondScene = LevelOneScene(size: self.size)
        secondScene.userData = NSMutableDictionary()
        secondScene.userData!.setValue(UtilitiesPortal.levelLabelTexts[0], forKey: "levelName")
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
        //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    // to go to Level 2 standard sense
    func goToLevel2() {
        cleanScene()
        self.removeAllActions()
        self.removeAllChildren()
        UtilitiesPortal.score = 0
        UtilitiesPortal.totalQuestions = 0
        let secondScene = LevelTwoScene(size: self.size)
        secondScene.userData = NSMutableDictionary()
        secondScene.userData!.setValue(UtilitiesPortal.levelLabelTexts[1], forKey: "levelName")
        secondScene.userData?.setValue("Standard", forKey: "gameMode")
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    // New record label for when a user beats their previous high score
    func addNewRecordLabel() {
        newRecordLabel = SKSpriteNode(imageNamed: "new record")
        
        let currentSize = newRecordLabel.size
        let x = UtilitiesPortal.screenWidth/4/currentSize.width
        let y = UtilitiesPortal.screenHeight/4/currentSize.height
        if x < y {
            newRecordLabel.setScale(x)
        }
        else {
            newRecordLabel.setScale(y)
        }
        
      //  newRecordLabel.size = CGSize(width: UtilitiesPortal.screenWidth/10, height: UtilitiesPortal.screenHeight/12)
        newRecordLabel.position = CGPoint(x: UtilitiesPortal.screenWidth / 2, y: UtilitiesPortal.screenHeight * 0.75)
        newRecordLabel.zPosition = 0.2
        newRecordLabel.hidden = true
        addChild(newRecordLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if DataHandler.getSettings().getEffect {
            audioPlayer.play()
        }
        let touch = touches.first
        
        // Home button selected
        let location = touch!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        
        //if medal info view is open, it will be close with a click
        if state == true{
            myView.removeAllChildren()
            myView.removeFromParent()
            state = false
        }
        if node.name == UtilitiesPortal.homeButtonName {
            backHomePage()
        }
        if node.name == UtilitiesPortal.infoButonName{
            infoTable()
            state = true
        }
    }
    
    // Alert message appears the first time using Facebook
    func facebookAlertMessage() {
        let controller = self.view?.window?.rootViewController as! GameViewController
        let alert = UIAlertController(title: "Facebook", message: "Chirality would like to access your Facebook", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Don't Allow", style: .Default, handler:nil))
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in
            self.socialData.setValue("facebook")
            self.activeFacebook()
        }))
        controller.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    // Alert message appears the first time using Twitter
    func twitterAlertMessage() {
        let controller = self.view?.window?.rootViewController as! GameViewController
        let alert = UIAlertController(title: "Twitter", message: "Chirality would like to access your Twitter", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Don't Allow", style: .Default, handler:nil))
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in
            self.socialData.setValue("twitter")
            self.activeTwitter()
        }))
        controller.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
     // Create info overlay table
    func infoTable() {
        myView = SKShapeNode()
        let x = MedalInfo(myView: myView, modeName: "level")
        x.setupItem()
        addChild(myView)
    }
    
    override func willMoveFromView(view: SKView) {
        self.removeAllActions()
        self.removeAllChildren()
        print("Remove all nodes Lvl 1 Result Scene")
    }
    
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
        print("Clean Lvl 1 Result Scene")
    }
}
