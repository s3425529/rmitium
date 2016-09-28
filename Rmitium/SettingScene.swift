//
//  SettingScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/30/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class SettingScene: SKScene {
    var settings: [SKSpriteNode] = []
    var values: [Bool] = []
    var state: Int?
    weak var model: Settings!
    var audioPlayer = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        settings.removeAll()
        values.removeAll()
        UtilitiesPortal.score = 0
        state = UtilitiesPortal.stateAnswer
        
        // Reset the setting every time use enter the setting scene for testing purpose
        //DataHandler.initSettings()
        
        model = DataHandler.getSettings()
        values.append(model.getSound)
        values.append(model.getEffect)
        values.append(model.getRightHand)
        
        if let clickSound = NSBundle.mainBundle().URLForResource("clickSound", withExtension: "wav") {
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: clickSound, fileTypeHint: nil)
                audioPlayer.prepareToPlay()
            }
            catch {
                fatalError("Error loading sound: \(error)")
            }
        }
        
        // Home button
        let home = SKSpriteNode(imageNamed: "home")
        home.name = UtilitiesPortal.homeButtonName
        home.zPosition = 0.1
        home.alpha = 1
        home.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        home.position = CGPoint(x:UtilitiesPortal.borderSize/2,
                                y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(home)
        
        // Setting label
        let levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        levelLabel.zPosition = 0.1
        levelLabel.text = UtilitiesPortal.levelLabelTexts[3]
        levelLabel.fontSize = UtilitiesPortal.navLabelSize
        levelLabel.position = CGPointMake(frame.midX, UtilitiesPortal.screenHeight*0.92)
        self.addChild(levelLabel)
        
        // Generating level buttons
        for count in 0..<UtilitiesPortal.settingLabelNames.count {
            let levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.levelLabelFont)
            levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
            levelLabel.zPosition = 0.2
            levelLabel.name = UtilitiesPortal.settingLabelNames[count]
            levelLabel.text = UtilitiesPortal.settingLabelTexts[count]
            levelLabel.fontSize = UtilitiesPortal.levelLabelSize
            levelLabel.position = CGPointMake(UtilitiesPortal.screenWidth*0.27,
                                              UtilitiesPortal.screenHeight*(0.68-CGFloat(count)*0.15))
            self.addChild(levelLabel)
            
            let levelButton = SKSpriteNode(imageNamed: "offbutton")
            if count == 0 && model.getSound {
                levelButton.texture = SKTexture(image: UIImage(named: "onbutton")!)
            }
            else if count == 1 && model.getEffect {
                levelButton.texture = SKTexture(image: UIImage(named: "onbutton")!)
            }
            else if count == 2 && !model.getRightHand {
                levelButton.texture = SKTexture(image: UIImage(named: "onbutton")!)
            }
            levelButton.name = UtilitiesPortal.settingLabelButtons[count]
            levelButton.alpha = 0.9
            levelButton.zPosition = 0.1
            levelButton.position = CGPointMake(UtilitiesPortal.screenWidth*0.68,
                                               UtilitiesPortal.screenHeight*(0.70-CGFloat(count)*0.15))
            levelButton.size = CGSize(width: 305/3,height: 143/3)
            if count == UtilitiesPortal.settingLabelNames.count-1 {
                levelButton.hidden = true
            }
            self.addChild(levelButton)
            settings.append(levelButton)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if DataHandler.getSettings().getEffect {
            audioPlayer.play()
        }
        
        let location = touches.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if node.name == UtilitiesPortal.homeButtonName {
            // Save settings
            DataHandler.updateSettings(values)
            PositionHandler.setRightHand()
            cleanScene()
            
            let secondScene = GameScene(size: self.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
            //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
        }
        
        print("width: \(UtilitiesPortal.screenWidth)")
        print("height: \(UtilitiesPortal.screenHeight)")
        
        // Sound
        for count in 0..<UtilitiesPortal.settingLabelNames.count {
            if (node.name == UtilitiesPortal.settingLabelNames[count] ||
                node.name == UtilitiesPortal.settingLabelButtons[count]) {
                if count == UtilitiesPortal.settingLabelNames.count-1 {
                    DataHandler.resetScores()
                    return
                }
                else if count == UtilitiesPortal.settingLabelNames.count-2 {
                    if values[count] {
                        values[count] = false
                        settings[count].texture = SKTexture(image: UIImage(named: "onbutton")!)
                    }
                    else {
                        values[count] = true
                        settings[count].texture = SKTexture(image: UIImage(named: "offbutton")!)
                    }
                }
                else if values[count] {
                    values[count] = false
                    settings[count].texture = SKTexture(image: UIImage(named: "offbutton")!)
                    if count == 0 {
                        SKTAudio.sharedInstance().pauseBackgroundMusic()
                    }
                }
                else {
                    values[count] = true
                    settings[count].texture = SKTexture(image: UIImage(named: "onbutton")!)
                    if count == 0 {
                        SKTAudio.sharedInstance().resumeBackgroundMusic()
                    }
                }
            }
        }
        
        /*if (node.name == UtilitiesPortal.settingLabelNames[0] ||
         node.name == UtilitiesPortal.settingLabelButtons[0]) {
         if values[0] {
         values[0] = false
         settings[0].texture = SKTexture(image: UIImage(named: "offbutton")!)
         SKTAudio.sharedInstance().pauseBackgroundMusic()
         }
         else {
         values[0] = true
         settings[0].texture = SKTexture(image: UIImage(named: "onbutton")!)
         SKTAudio.sharedInstance().resumeBackgroundMusic()
         }
         
         }
         
         if (node.name == UtilitiesPortal.settingLabelNames[1] ||
         node.name == UtilitiesPortal.settingLabelButtons[1]) {
         if values[1] {
         values[1] = false
         settings[1].texture = SKTexture(image: UIImage(named: "offbutton")!)
         }
         else {
         values[1] = true
         settings[1].texture = SKTexture(image: UIImage(named: "onbutton")!)
         }
         }
         
         if (node.name == UtilitiesPortal.settingLabelNames[2] ||
         node.name == UtilitiesPortal.settingLabelButtons[2]) {
         if values[2] {
         values[2] = false
         settings[2].texture = SKTexture(image: UIImage(named: "offbutton")!)
         }
         else {
         values[2] = true
         settings[2].texture = SKTexture(image: UIImage(named: "onbutton")!)
         }
         }*/
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func willMoveFromView(view: SKView) {
        settings.removeAll()
        values.removeAll()
        self.removeAllActions()
        self.removeAllChildren()
        print("Remove all nodes Setting Scene")
    }
    
    func cleanScene() {
        settings.removeAll()
        values.removeAll()
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
        print("Clean Setting Scene")
    }
}