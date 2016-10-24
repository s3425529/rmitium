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
    // Create level name node
    override func setupItems() {
        super.setupItems()
        levelLabel.text = UtilitiesPortal.levelLabelTexts[2]
    }
    
    // Create medal node
    override func setupMedal() {
        //call the medalClass  to get the relevant medal image and messages.
        let medalDic = medalClass().assignMedal(UtilitiesPortal.levelThree)
        let medalName = medalDic.medalName
        let information1 = medalDic.information[0]
        let information2 = medalDic.information[1]
        
        //create medalNode
        let medalNode = SKSpriteNode(imageNamed: medalName)
        newRecordLabel.hidden = !medalDic.newRecord
        medalNode.color = SKColor.blueColor()
        medalNode.name = "medal"
        medalNode.position = CGPoint(x: UtilitiesPortal.screenWidth / 3, y: UtilitiesPortal.screenHeight / 2)
        medalNode.size = CGSize(width: UtilitiesPortal.screenWidth/3*1.1, height: UtilitiesPortal.screenWidth / 3)
        medalNode.zPosition = 0.1
        
        //make medal image to rotate
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
        
        // create scoreNode to display the current score
        let scoreNode = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        scoreNode.text = "\(UtilitiesPortal.score)"
        scoreNode.position = CGPoint(x: UtilitiesPortal.screenWidth / 3, y: UtilitiesPortal.screenHeight / 2.1)
        
        scoreNode.fontSize = UtilitiesPortal.screenHeight*0.07
        addChild(scoreNode)
        
        //create title message
        let p1 = CGPoint(x: UtilitiesPortal.screenWidth * 0.33, y: UtilitiesPortal.screenHeight * 1.2)
        text = SKMultilineLabel(text: information1, labelWidth: UtilitiesPortal.screenWidth*0.6, pos: p1)
        text.alignment = .Center
        text.leading =  Int(UtilitiesPortal.screenHeight*0.1)
        text.fontSize = UtilitiesPortal.screenHeight*0.05
        addChild(text)
        /*text = SKLabelNode(fontNamed: UtilitiesPortal.navLabelFont)
        text.text = information1
        text.fontSize = UtilitiesPortal.factSize
        text.zPosition = 0.1
        text.fontColor = SKColor.whiteColor()
        text.position = CGPoint(x:UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.borderSize/4)
        addChild(text)*/
        
        //create encourage message node
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
    
    override func socialMessage() -> String {
        return "I got \(UtilitiesPortal.score) in Level 3 of Chirality!"
    }
    
    override func redoAction() {
        backLevel3()
    }
    
    // Back to the home page
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
