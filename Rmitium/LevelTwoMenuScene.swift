//
//  LevelTwoMenuScene.swift
//  Rmitium
//
//  Created by Thinh Tran on 22/09/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import SpriteKit

class LevelTwoMenuScene: SKScene {
    var homeDialogue, tick, infoOverlay: SKSpriteNode!
    var standard, timeTrial, beatTheClock : CustomButton!
    
    override func didMoveToView(view: SKView) {
        setupScene()
    }
    
    func setupScene(){
        setupItem()
        setupInfo()
        createHomeDialogue()
    }
    
    func setupItem() {
        
        // Home button
        let home = SKSpriteNode(imageNamed: "home")
        home.name = UtilitiesPortal.homeButtonName
        home.zPosition = 0.1
        home.alpha = 1
        home.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        home.position = CGPoint(x:UtilitiesPortal.borderSize/2,
            y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(home)
        
        // Tick button
        tick = SKSpriteNode(imageNamed: "tick-white")
        tick.name = UtilitiesPortal.tickButtonName
        tick.zPosition = 0.1
        tick.alpha = 1
        tick.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        tick.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
            y: UtilitiesPortal.navImgSize/2)
        addChild(tick)
        
        // Info button
        let info = SKSpriteNode(imageNamed: "help2")
        info.name = UtilitiesPortal.infoButonName
        info.zPosition = 0.1
        info.alpha = 1
        info.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        info.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
            y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(info)
        
        //Standard mode button
        standard = CustomButton(defaultButtonImage: "Level 2-1", activeButtonImage: "Level 2-1", buttonAction: standardAction, scale: 0.3)
        standard.position = CGPoint(x: UtilitiesPortal.screenWidth*0.2, y: UtilitiesPortal.screenHeight/2)
        addChild(standard)
        
        timeTrial = CustomButton(defaultButtonImage: "Level 2-2", activeButtonImage: "Level 2-2", buttonAction: timeTrialAction, scale: 0.3)
        timeTrial.position = CGPoint(x: UtilitiesPortal.screenWidth*0.5, y: UtilitiesPortal.screenHeight/2)
        addChild(timeTrial)
        
        beatTheClock = CustomButton(defaultButtonImage: "Level 2-3", activeButtonImage: "Level 2-3", buttonAction: beatTheClockAction, scale: 0.3)
        beatTheClock.position = CGPoint(x: UtilitiesPortal.screenWidth*0.8, y: UtilitiesPortal.screenHeight/2)
        addChild(beatTheClock)
    }
    
    func setupInfo() {
    
    }
    
    func createHomeDialogue() {
        let yesBtn = SKSpriteNode()
        let noBtn = SKSpriteNode()
        
        let alertMessage = SKLabelNode(text: "Are you sure you want to quit?")
        alertMessage.position = CGPoint(x: 0, y: 0)
        alertMessage.zPosition = 0.9
        alertMessage.fontName = UtilitiesPortal.navLabelFont
        alertMessage.fontSize = 15
        homeDialogue = SKSpriteNode()
        homeDialogue.size = CGSize(width: UtilitiesPortal.screenWidth/2.5, height: UtilitiesPortal.screenHeight/2.5)
        homeDialogue.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        homeDialogue.color = SKColor.blackColor()
        homeDialogue.alpha = 0.9
        homeDialogue.zPosition = 0.9
        homeDialogue.hidden = true
        
        yesBtn.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        yesBtn.color = SKColor.grayColor()
        yesBtn.name = UtilitiesPortal.yesButtonName
        yesBtn.texture = SKTexture(image: UIImage(named: "tick-white")!)
        yesBtn.position = CGPoint(x: (0 - yesBtn.size.width), y: (0 - yesBtn.size.height)*1.5)
        yesBtn.zPosition = 0.9
        
        noBtn.size = yesBtn.size
        noBtn.color = yesBtn.color
        noBtn.name = UtilitiesPortal.noButtonName
        noBtn.texture = SKTexture(image: UIImage(named: "cross-white")!)
        noBtn.position = CGPoint(x: yesBtn.size.width, y: (0 - yesBtn.size.height)*1.5)
        noBtn.zPosition = 0.9
        
        homeDialogue.addChild(yesBtn)
        homeDialogue.addChild(noBtn)
        homeDialogue.addChild(alertMessage)
        addChild(homeDialogue)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        //Home button
        if node.name == UtilitiesPortal.homeButtonName {
            homeDialogue.hidden = false
        }
        //Yes button
        if node.name == UtilitiesPortal.yesButtonName {
            backHomePage()
        }
        //No button
        if node.name == UtilitiesPortal.noButtonName {
            homeDialogue.hidden = true
        }
        //Tick button: proceed to the choosen gameplay mode 
        if node.name == UtilitiesPortal.tickButtonName {
            proceedToLevel2()
        }
    }
    
    override func willMoveFromView(view: SKView) {
        self.removeAllActions()
        self.removeAllChildren()
        print("Cleaning scene!")
    }
    
    func backHomePage() {
        let secondScene = GameScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    func proceedToLevel2(){
        let secondScene = LevelTwoScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
        UtilitiesPortal.score = 0
    }
    
    func standardAction() {
        
    }
    
    func timeTrialAction() {
        
    }
    
    func beatTheClockAction() {
        
    }
}
