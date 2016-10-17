//
//  ResultPage3.swift
//  Rmitium
//
//  Created by Max on 13/09/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import AVFoundation
import SpriteKit
import Social

class ResultPage3: ResultPage {
    /*var facebook, twitter, redo, next: CustomButton!
    var homeView :SKSpriteNode!
    var homeDialogue: SKShapeNode!
    var text,text1 :SKMultilineLabel!
    var socialData:SocialClass!
    var audioPlayer = AVAudioPlayer()
    var myView:SKShapeNode!
    var state = false*/
    
    override func didMoveToView(view: SKView) {
        socialData = SocialClass()
        socialData.initClass()
        socialData.getRecord()
        setupItems()
        setupCustomerButton()
        addNewRecordLabel()
        setupMedal()
        
        if let clickSound = NSBundle.mainBundle().URLForResource("clickSound", withExtension: "wav") {
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: clickSound, fileTypeHint: nil)
                audioPlayer.prepareToPlay()
            }
            catch {
                fatalError("Error loading sound: \(error)")
            }
        }
        DataHandler.saveLevelThreeScore()
    }
    //creat level name node
    override func setupItems() {
        super.setupItems()
        levelLabel.text = UtilitiesPortal.levelLabelTexts[2]
    }
    
    // creat medal node
    override func setupMedal() {
        //medalNode.texture = SKTexture(imageNamed: "Medal5-Rust")
        let medalDic = medalClass().assignMedal(UtilitiesPortal.levelThree)
        let medalName = medalDic.medalName
        newRecordBox.hidden = !medalDic.newRecord
        let information1 = medalDic.information[0]
        let information2 = medalDic.information[1]
        let medalNode = SKSpriteNode(imageNamed: medalName)
        medalNode.color = SKColor.blueColor()
        medalNode.name = "medal"
        medalNode.position = CGPoint(x: UtilitiesPortal.screenWidth / 3, y: UtilitiesPortal.screenHeight / 2)
        medalNode.size = CGSize(width: UtilitiesPortal.screenWidth/3*1.1, height: UtilitiesPortal.screenWidth / 3)
        medalNode.zPosition = 0.1
        
        let action = SKAction.rotateToAngle(CGFloat(M_PI/2), duration: 5)
        let action1 = SKAction.rotateToAngle(CGFloat(-M_PI/2), duration: 5)
        let sequen = SKAction.sequence([action,action1])
        let repeatAction = SKAction.repeatActionForever(sequen)
        addChild(medalNode)
        medalNode.runAction(repeatAction)
        
        let scoreNode = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        scoreNode.text = "\(UtilitiesPortal.score)"
        scoreNode.position = CGPoint(x: UtilitiesPortal.screenWidth / 3, y: UtilitiesPortal.screenHeight / 2.1)
        scoreNode.fontSize = UtilitiesPortal.screenHeight*0.07
        addChild(scoreNode)
        
        let p1 = CGPoint(x: UtilitiesPortal.screenWidth*0.33, y: UtilitiesPortal.screenHeight*1.2)
        text = SKMultilineLabel(text: information1, labelWidth: UtilitiesPortal.screenWidth*0.6, pos: p1)
        text.alignment = .Center
        text.leading =  Int(UtilitiesPortal.screenHeight*0.1)
        text.fontSize = UtilitiesPortal.screenHeight*0.05
        addChild(text)
        
        let p2 = CGPoint(x: UtilitiesPortal.screenWidth * 0.33, y: UtilitiesPortal.screenHeight * 0.50)
        text1 = SKMultilineLabel(text: information2, labelWidth: UtilitiesPortal.screenWidth*0.6, pos: p2)
        text1.alignment = .Center
        text1.leading =  Int(UtilitiesPortal.screenHeight*0.08)
        text1.fontSize = UtilitiesPortal.screenHeight*0.045
        addChild(text1)
    }
    
    override func redoAction() {
        backLevel3()
    }
    
    // Share the score to any social media!
    /*func displayShareSheet(shareContent:String) {
        
        let myShare = "My best is \(shareContent)"
        let controller = self.view?.window?.rootViewController as! GameViewController
        
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [myShare], applicationActivities: nil)
        
        controller.presentViewController(activityVC, animated: true, completion: nil)
    }*/
    
    //back to the home page,
    func backLevel3() {
        UtilitiesPortal.score = 0
        UtilitiesPortal.totalQuestions = 0
        LevelThreeModel.reset()
        cleanScene()
        
        let secondScene = LevelThreeScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
        secondScene.userData = NSMutableDictionary()
        secondScene.userData!.setValue(UtilitiesPortal.levelLabelTexts[2], forKey: "levelName")
        //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func willMoveFromView(view: SKView) {
        self.removeAllActions()
        self.removeAllChildren()
        print("Remove all nodes Lvl 3 Result Scene")
    }
    
    override func cleanScene() {
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
        print("Clean Lvl 3 Result Scene")
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        super.touchesBegan(touches, withEvent: event)
        
        let location = touch!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        if state == true{
            myView.removeAllChildren()
            myView.removeFromParent()
            state = false
        }
        if node.name == UtilitiesPortal.infoButonName{
            infoTable()
            state = true
        }
    }
}
