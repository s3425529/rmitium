//
//  GameScene.swift
//  Rmitium
//
//  Created by Thinh Tran on 8/08/2016.
//  Copyright (c) 2016 RMIT. All rights reserved.
//

import AudioToolbox
import SpriteKit
import AVFoundation

class GameScene: SKScene {
    var infoOverlay: SKSpriteNode!
    var state, previousState: Int!
    var audioPlayer = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        //UtilitiesPortal.score = 0
        UtilitiesPortal.totalQuestions = 0
        state = UtilitiesPortal.stateAnswer
        
        if let clickSound = NSBundle.mainBundle().URLForResource("clickSound", withExtension: "wav") {
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: clickSound, fileTypeHint: nil)
                audioPlayer.prepareToPlay()
            }
            catch {
                fatalError("Error loading sound: \(error)")
            }
        }
        
        // Display score data to test
        DataHandler.getSettings()
        
        let image = SKSpriteNode(imageNamed: "chem-bg2")
        image.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        image.position = CGPoint(x:frame.midX, y:frame.midY)
        image.zPosition = 0
        addChild(image)
        
        // Setting button
        let setting = SKSpriteNode(imageNamed: "settings")
        setting.name = UtilitiesPortal.settingButtonName
        setting.zPosition = 0.1
        setting.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        setting.position = CGPoint(x:UtilitiesPortal.borderSize/2,
            y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(setting)
        
        // Help button
        let info = SKSpriteNode(imageNamed: "help3")
        info.name = UtilitiesPortal.infoButonName
        info.zPosition = 0.1
        info.alpha = 0.9
        info.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        info.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
            y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(info)
        
        // App name logo
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.setScale(UtilitiesPortal.screenHeight/88*0.30)
        logo.position = CGPoint(x:frame.midX, y:UtilitiesPortal.screenHeight*0.85)
        logo.zPosition = 0.1
        addChild(logo)

        // Generating level buttons
        for count in 0...2 {
            let levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.levelLabelFont)
            //levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
            levelLabel.zPosition = 0.2
            levelLabel.name = UtilitiesPortal.levelLabelNames[count]
            levelLabel.text = UtilitiesPortal.levelLabelTexts[count]
            levelLabel.fontSize = UtilitiesPortal.levelLabelSize
            levelLabel.position = CGPointMake(frame.midX/*UtilitiesPortal.borderSize*/,
                                              UtilitiesPortal.screenHeight*(0.58-CGFloat(count)*0.18))
            self.addChild(levelLabel)
            
            let levelButton = SKSpriteNode(imageNamed: "menubar3")
            levelButton.name = UtilitiesPortal.levelButtonNames[count]
            levelButton.alpha = 0.9
            levelButton.zPosition = 0.1
            levelButton.position = CGPointMake(frame.midX, UtilitiesPortal.screenHeight*(0.60-CGFloat(count)*0.18))
            levelButton.size = CGSize(width: UtilitiesPortal.screenWidth*0.9,
                                         height: UtilitiesPortal.hexImageSize*1.2)
            self.addChild(levelButton)
            
            
            if count != UtilitiesPortal.levelTwo - 1 {
                let medal = DataHandler.getMedal(count+1, mode: UtilitiesPortal.modeStandard)
                if medal != "" {
                    let levelMedal = SKSpriteNode(imageNamed: medal)
                    levelMedal.name = UtilitiesPortal.levelMedalNames[count]
                    levelMedal.alpha = 0.9
                    levelMedal.zPosition = 0.2
                    levelMedal.position = CGPointMake(UtilitiesPortal.screenWidth*0.88,
                                                      UtilitiesPortal.screenHeight*(0.60-CGFloat(count)*0.18))
                    levelMedal.size = CGSize(width: UtilitiesPortal.hexImageSize,
                                             height: UtilitiesPortal.hexImageSize)
                    self.addChild(levelMedal)
                }
            }
            
            setupInfo()
        }
        setupLevelTwoModes()
        UtilitiesPortal.setBgm()
    }
    
    // Info layout
    func setupInfo() {
        let infoOverlayText = SKMultilineLabel(text: "Info layout", labelWidth:UtilitiesPortal.screenWidth,
                                               pos: CGPoint(x: 0, y: 0),fontName: UtilitiesPortal.navLabelFont,
                                               fontSize: UtilitiesPortal.navLabelSize,
                                               leading: Int(UtilitiesPortal.navLabelSize))
        infoOverlayText.name = UtilitiesPortal.factMultiLine
        infoOverlayText.zPosition = 1
        
        infoOverlay = SKSpriteNode()
        infoOverlay.name = UtilitiesPortal.factOverlayName
        infoOverlay.size = CGSize(width: UtilitiesPortal.screenWidth,
                                   height: UtilitiesPortal.screenHeight)
        infoOverlay.position = CGPoint(x: UtilitiesPortal.screenWidth/2,
                                        y: UtilitiesPortal.screenHeight/2)
        infoOverlay.color = SKColor.blackColor()
        infoOverlay.alpha = 0.7
        infoOverlay.zPosition = 0.9
        infoOverlay.hidden = true
        infoOverlay.addChild(infoOverlayText)
        addChild(infoOverlay!)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if DataHandler.getSettings().getEffect {
            audioPlayer.play()
        }
        
        if state == UtilitiesPortal.stateInfo {
            infoOverlay!.hidden = true
            state = previousState
            previousState = UtilitiesPortal.stateInfo
            return
        }
        
        let location = touches.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        // Info selected
        if node.name == UtilitiesPortal.infoButonName {
            previousState = state
            state = UtilitiesPortal.stateInfo
            infoOverlay!.hidden = false
            return
        }
        
        // Setting selected
        if node.name == UtilitiesPortal.settingButtonName {
            cleanScene()
            let secondScene = SettingScene(size: self.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
            //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            return
        }

        if (node.name == UtilitiesPortal.levelLabelNames[0]
                                || node.name == UtilitiesPortal.levelButtonNames[0]) {
            cleanScene()
            LevelOneModel.reset()
            
            let secondScene = LevelOneScene(size: self.size)
            secondScene.userData = NSMutableDictionary()
            secondScene.userData!.setValue(UtilitiesPortal.levelLabelTexts[0], forKey: "levelName")
            //let secondScene = ResultPage(size: self.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
            //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            return
        }
        
        if (node.name == UtilitiesPortal.levelLabelNames[1]
                                || node.name == UtilitiesPortal.levelButtonNames[1]) {
            showLevelTwoModes()
            previousState = state
            state = UtilitiesPortal.stateResult
            return
        }
        
        if (node.name == UtilitiesPortal.levelLabelNames[2]
                                || node.name == UtilitiesPortal.levelButtonNames[2]) {
            cleanScene()
            LevelThreeModel.reset()
            let secondScene = LevelThreeScene(size: self.size)
            secondScene.userData = NSMutableDictionary()
            secondScene.userData!.setValue(UtilitiesPortal.levelLabelTexts[2], forKey: "levelName")
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            return
        }
        // Level 2 - Standard
        if (node.name == UtilitiesPortal.modeLabelNames[0]
                                || node.name == UtilitiesPortal.modeButtonNames[0]
                                || node.name == UtilitiesPortal.modeMedalNames[0]) {
            cleanScene()
            let secondScene = LevelTwoScene(size: self.size)
            //let secondScene = ResultPage2(size: self.size)
            secondScene.userData = NSMutableDictionary()
            secondScene.userData!.setValue(UtilitiesPortal.levelLabelTexts[1], forKey: "levelName")
            secondScene.userData!.setValue(UtilitiesPortal.modeLabelTexts[0], forKey: "gameMode")
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            return
        }
        // Level 2 - Time Trial
        if (node.name == UtilitiesPortal.modeLabelNames[1]
                                || node.name == UtilitiesPortal.modeButtonNames[1]
                                || node.name == UtilitiesPortal.modeMedalNames[1]) {
            cleanScene()
            let secondScene = LevelTwoScene(size: self.size)
            //let secondScene = ResultPage2(size: self.size)
            secondScene.userData = NSMutableDictionary()
            secondScene.userData!.setValue(UtilitiesPortal.levelLabelTexts[1], forKey: "levelName")
            secondScene.userData!.setValue(UtilitiesPortal.modeLabelTexts[1], forKey: "gameMode")
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            return
        }
        
        if (node.name == UtilitiesPortal.modeLabelNames[2]
                                || node.name == UtilitiesPortal.modeButtonNames[2]
                                || node.name == UtilitiesPortal.modeMedalNames[2]) {
            cleanScene()
            let secondScene = LevelTwoScene(size: self.size)
            //let secondScene = ResultPage2(size: self.size)
            secondScene.userData = NSMutableDictionary()
            secondScene.userData!.setValue(UtilitiesPortal.levelLabelTexts[1], forKey: "levelName")
            secondScene.userData!.setValue(UtilitiesPortal.modeLabelTexts[2], forKey: "gameMode")
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            return
        }
        
        if state == UtilitiesPortal.stateResult {
            previousState = UtilitiesPortal.stateResult
            state = UtilitiesPortal.stateAnswer
            
            childNodeWithName(UtilitiesPortal.levelLabelNames[1])?.hidden = false
            childNodeWithName(UtilitiesPortal.levelButtonNames[1])?.hidden = false
            
            for x in 0..<UtilitiesPortal.modeLabelNames.count {
                childNodeWithName(UtilitiesPortal.modeLabelNames[x])?.hidden = true
                childNodeWithName(UtilitiesPortal.modeButtonNames[x])?.hidden = true
                childNodeWithName(UtilitiesPortal.modeMedalNames[x])?.hidden = true
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func willMoveFromView(view: SKView) {
        self.removeAllActions()
        self.removeAllChildren()
        print("Remove all nodes Game Scene")
    }
    
    func setupLevelTwoModes() {
        for count in 0 ... 2 {
            let modeLabel = SKLabelNode(fontNamed:UtilitiesPortal.levelLabelFont)
            //levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
            modeLabel.zPosition = 0.4
            modeLabel.hidden = true
            modeLabel.name = UtilitiesPortal.modeLabelNames[count]
            modeLabel.text = UtilitiesPortal.modeLabelTexts[count]
            modeLabel.fontSize = UtilitiesPortal.levelLabelSize
            modeLabel.position = CGPointMake(UtilitiesPortal.borderSize*3 + CGFloat(count)*UtilitiesPortal.screenWidth*0.3/*UtilitiesPortal.borderSize*/,
                UtilitiesPortal.screenHeight*(0.58-0.18))
            addChild(modeLabel)
            
            let levelButton = SKSpriteNode(imageNamed: "menubar3")
            levelButton.name = UtilitiesPortal.modeButtonNames[count]
            levelButton.hidden = true
            levelButton.alpha = 0.9
            levelButton.zPosition = 0.3
            levelButton.position = CGPointMake(UtilitiesPortal.borderSize*3 + CGFloat(count)*UtilitiesPortal.screenWidth*0.3, UtilitiesPortal.screenHeight*(0.60-0.18))
            levelButton.size = CGSize(width: UtilitiesPortal.screenWidth*0.29,
                                      height: UtilitiesPortal.hexImageSize*1.2)
            addChild(levelButton)
            
            let medal = DataHandler.getMedal(UtilitiesPortal.levelTwo, mode: count)
            if medal != "" {
                let levelMedal = SKSpriteNode(imageNamed: medal)
                levelMedal.name = UtilitiesPortal.modeMedalNames[count]
                levelMedal.hidden = true
                levelMedal.alpha = 0.9
                levelMedal.zPosition = 0.4
                levelMedal.position = CGPointMake(UtilitiesPortal.borderSize*4.5 + CGFloat(count)*UtilitiesPortal.screenWidth*0.3, UtilitiesPortal.screenHeight*(0.60-0.18))
                levelMedal.size = CGSize(width: UtilitiesPortal.hexImageSize*2/3,
                                         height: UtilitiesPortal.hexImageSize*2/3)
                self.addChild(levelMedal)
            }
        }
    }
    
    func showLevelTwoModes() {
        childNodeWithName(UtilitiesPortal.levelLabelNames[1])?.hidden = true
        childNodeWithName(UtilitiesPortal.levelButtonNames[1])?.hidden = true
        for count in 0 ... 2 {
            childNodeWithName(UtilitiesPortal.modeLabelNames[count])?.hidden = false
            childNodeWithName(UtilitiesPortal.modeButtonNames[count])?.hidden = false
            childNodeWithName(UtilitiesPortal.modeMedalNames[count])?.hidden = false
        }
        state = UtilitiesPortal.stateResult
        previousState = UtilitiesPortal.stateAnswer
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
        print("Clean Game Scene")
    }
}
