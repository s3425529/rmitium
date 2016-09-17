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
    var state: Int!
    
    override func didMoveToView(view: SKView) {
        UtilitiesPortal.score = 0
        state = UtilitiesPortal.stateAnswer
        
        let image = SKSpriteNode(imageNamed: "chem-bg2")
        image.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        image.position = CGPoint(x:frame.midX, y:frame.midY)
        image.zPosition = 0
        //image.setScale(1.5)
        //image.alpha = 0.8
        addChild(image)
        
        // Setting button
        let setting = SKSpriteNode(imageNamed: "settings")
        setting.name = UtilitiesPortal.settingButtonName
        setting.zPosition = 0.1
        //setting.alpha = 0.2
        setting.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        setting.position = CGPoint(x:UtilitiesPortal.borderSize/2,
            y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(setting)
        
        // Help button
        let info = SKSpriteNode(imageNamed: "help2")
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
        //image.alpha = 0.8
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
            
            setupInfo()
        }
        setupSound()
    }
    
    // Info layout
    func setupInfo(){
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
    
    func setupSound() {
        let backgroundMusic = SKAudioNode(fileNamed: "bgSound.wav")
        backgroundMusic.autoplayLooped = true
        self.addChild(backgroundMusic)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        runAction(SKAction.playSoundFileNamed("clickSound.wav", waitForCompletion: true))
        if state == UtilitiesPortal.stateInfo {
            infoOverlay!.hidden = true
            state = UtilitiesPortal.stateAnswer
            return
        }
        
        let location = touches.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        // Info selected
        if node.name == UtilitiesPortal.infoButonName {
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
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
            //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            return
        }
        
        if (node.name == UtilitiesPortal.levelLabelNames[1]
                                || node.name == UtilitiesPortal.levelButtonNames[1]) {
            cleanScene()
            let secondScene = LevelTwoScene(size: self.size)
                                    
            //let secondScene = ResultPage(size: self.size)
            //let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
            let transition = SKTransition.moveInWithDirection(.Down, duration: 0.1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            return
        }
        
        if (node.name == UtilitiesPortal.levelLabelNames[2]
                                || node.name == UtilitiesPortal.levelButtonNames[2]) {
            
            cleanScene()
            LevelThreeModel.reset()
            
            //let secondScene = ResultPage(size: self.size)
            let secondScene = LevelThreeScene(size: self.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
            //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            return
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
