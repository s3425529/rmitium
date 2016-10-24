//
//  ResultPage2.swift
//  Rmitium
//
//  Created by Max on 13/09/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
//
//  ReslutPage3.swift
//  Rmitium
//

import AVFoundation
import SpriteKit
import Social

class ResultPage2: ResultPage {
    
    /*var facebook, twitter, redo, finish: CustomButton!
    var state, previousState: Int!
    var homeView: SKSpriteNode!
    var homeDialogue: SKShapeNode!
    var socialData:SocialClass!
    var text,text1 :SKMultilineLabel!
    var audioPlayer = AVAudioPlayer()*/
    var Dic:medalClass!
    var medalDic:(medalName:String,information:[String], newRecord: Bool)!
    //var myView:SKShapeNode!
    var stateInfo = false
    var modeName:String!
    override func didMoveToView(view: SKView) {
        
        // Get medal image and messages according current socre
        Dic = medalClass()
        switch String(self.userData!.valueForKey("gameMode")!) {
        case UtilitiesPortal.modeLabelTexts[0]:
            //DataHandler.saveLevelTwoScore()
            print("Game mode: Standard!")
            medalDic = Dic.level2("stand")
            modeName = "stand"
            //infoTable("stand")
            break
        case UtilitiesPortal.modeLabelTexts[1]:
            //DataHandler.saveLevelTwoTrialScore()
            print("Game mode: Time Trial!")
            medalDic = Dic.level2("trial")
            modeName = "trial"
            //infoTable("trial")
            break
        case UtilitiesPortal.modeLabelTexts[2]:
            //DataHandler.saveLevelTwoExtremeScore()
            print("Game mode: Extreme!")
            medalDic = Dic.level2("extreme")
            modeName = "extreme"
            //infoTable("extreme")
            break
        default:
            break
        }
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
        setupItems()
        setupMedal()
        setupCustomerButton()
        newRecordLabel.hidden = !medalDic.newRecord
        
        // Save the score
        switch String(self.userData!.valueForKey("gameMode")!) {
        case UtilitiesPortal.modeLabelTexts[0]:
            DataHandler.saveLevelTwoScore()
            break
        case UtilitiesPortal.modeLabelTexts[1]:
            DataHandler.saveLevelTwoTrialScore()
            break
        case UtilitiesPortal.modeLabelTexts[2]:
            DataHandler.saveLevelTwoExtremeScore()
            break
        default:
            break
        }
    }
    
    override func setupMedal() {
        
        // Get the image and messages from medalClass
        let medalName = medalDic.medalName
        let information1 = medalDic.information[0]
        let information2 = medalDic.information[1]
        
        // Create medal image node
        let medalNode = SKSpriteNode(imageNamed: medalName)
        let mins = UtilitiesPortal.score/60
        let sec = UtilitiesPortal.score%60
        var labelText:String!
        //let mode:String = userData!.valueForKey("gameMode") as! String
        
        //get the extreme current time
        /*if mode == UtilitiesPortal.modeLabelTexts[2]{
            mins = (UtilitiesPortal.level2ExtremeTime - UtilitiesPortal.score)/60
            sec = (UtilitiesPortal.level2ExtremeTime - UtilitiesPortal.score)%60
        }
        //get the trial current time
        if mode == UtilitiesPortal.modeLabelTexts[1]{
            mins = (UtilitiesPortal.score - UtilitiesPortal.level2TrialTime)/60
            sec = (UtilitiesPortal.score - UtilitiesPortal.level2TrialTime)%60
        }*/
        
        medalNode.color = SKColor.blueColor()
        medalNode.name = "medal"
        medalNode.position = CGPoint(x: UtilitiesPortal.screenWidth / 3, y: UtilitiesPortal.screenHeight / 2)
        medalNode.size = CGSize(width: UtilitiesPortal.screenWidth/3*1.1, height: UtilitiesPortal.screenWidth / 3)
        medalNode.zPosition = 0.1
        
        // Make the medal rotate
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
        
        // Create node to display the current time of score
        let scoreNode = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        // if minute is zero, it will not display.
        if mins == 0 {
            labelText = "\(sec)sec"
        }
        else {
            if sec < 10 {
                labelText = "\(mins):0\(sec)"
            }
            else {
                labelText = "\(mins):\(sec)"
            }
            
        }
        scoreNode.text = labelText
        scoreNode.position = CGPoint(x: UtilitiesPortal.screenWidth / 3, y: UtilitiesPortal.screenHeight / 2.1)
        
        scoreNode.fontSize = UtilitiesPortal.screenHeight*0.04
        addChild(scoreNode)
        
        // Create title node
        let p1 = CGPoint(x: UtilitiesPortal.screenWidth*0.33, y: UtilitiesPortal.screenHeight*0.92)
        text = SKMultilineLabel(text: information1, labelWidth: UtilitiesPortal.screenWidth*0.6, pos: p1)
        text.alignment = .Center
        text.leading =  Int(UtilitiesPortal.screenHeight*0.1)
        text.fontSize = UtilitiesPortal.screenHeight*0.05
        addChild(text)
        
        //creat message node
        var p2 = CGPoint(x: UtilitiesPortal.screenWidth*0.33, y: UtilitiesPortal.screenHeight*0.55)
        text1 = SKMultilineLabel(text: information2, labelWidth: UtilitiesPortal.screenWidth*0.6, pos: p2)
        text1.alignment = .Center
        text1.leading =  Int(UtilitiesPortal.screenHeight*0.1)
        text1.fontSize = UtilitiesPortal.screenHeight*0.05
        
        let lines = text1.lineCount
        p2 = CGPoint(x: UtilitiesPortal.screenWidth * 0.33, y: text1.labelHeight + UtilitiesPortal.borderSize/2)
        if lines == 1 {
            p2 = CGPoint(x: UtilitiesPortal.screenWidth * 0.33, y: text1.labelHeight + UtilitiesPortal.borderSize/2 + UtilitiesPortal.screenHeight*0.08)
        }
        text1.pos = p2
        addChild(text1)
    }
    
    override func setupItems() {
        super.setupItems()
        levelLabel.text = "Level 2: \(self.userData!.valueForKey("gameMode")!)"
    }
    
    override func socialMessage() -> String {
        let mins = UtilitiesPortal.score/60
        let sec = UtilitiesPortal.score%60
        var score: String
        if mins == 0 {
            score = "\(sec)sec"
        }
        else {
            if sec < 10 {
                score = "\(mins):0\(sec)"
            }
            else {
                score = "\(mins):\(sec)"
            }
            
        }
        return "I finished Chirality Level 2: \(self.userData!.valueForKey("gameMode")!) in \(score)"
    }
    
    // Retry level 2
    override func redoAction() {
        print("redo")
        UtilitiesPortal.score = 0
        backLevel2()
        return
    }
    
    // Share the score to any social media!
    /*func displayShareSheet(shareContent:String) {
        let myShare = "My best is \(shareContent)"
        let controller = self.view?.window?.rootViewController as! GameViewController
        
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [myShare], applicationActivities: nil)
        
        controller.presentViewController(activityVC, animated: true, completion: nil)
    }*/
    
    // to go to Level 2 sence
    func backLevel2() {
        cleanScene()
        self.removeAllActions()
        self.removeAllChildren()
        UtilitiesPortal.score = 0
        let secondScene = LevelTwoScene(size: self.size)
        secondScene.userData = NSMutableDictionary()
        secondScene.userData!.setValue(UtilitiesPortal.levelLabelTexts[1], forKey: "levelName")
        let mode = self.userData?.valueForKey("gameMode")
        secondScene.userData?.setValue(mode, forKey: "gameMode")
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
        //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        super.touchesBegan(touches, withEvent: event)
        // Home button selected
        let location = touch!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        //if medal info view is open, it will be close with a click
        if stateInfo == true{
            myView.removeAllChildren()
            myView.removeFromParent()
            stateInfo = false
            return
        }
        
        
        if node.name == UtilitiesPortal.infoButonName {
            myView.removeAllChildren()
            myView.removeFromParent()
            stateInfo = false
            infoTable(modeName)
            stateInfo = true
            return
        }

    }
    
    // Formating the time to display as seconds, minutes etc
    func  timeFormat() -> String {
        let hour = UtilitiesPortal.score/3600
        let min = UtilitiesPortal.score/60
        let sec = UtilitiesPortal.score%60
        return"\(hour):\(min):\(sec)"
    }
    
    func infoTable(mode:String) {
        myView = SKShapeNode()
        let x = MedalInfo(myView: myView, modeName: mode)
        x.setupItem()
        addChild(myView)
        
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func willMoveFromView(view: SKView) {
        self.removeAllActions()
        self.removeAllChildren()
        print("Remove all nodes Lvl 2 Result Scene")
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
        print("Clean Lvl 2 Result Scene")
    }
}
