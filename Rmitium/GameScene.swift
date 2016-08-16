//
//  GameScene.swift
//  Rmitium
//
//  Created by Thinh Tran on 8/08/2016.
//  Copyright (c) 2016 RMIT. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        /*self.backgroundColor = SKColor(red: 0.15, green:0.15, blue:0.3, alpha: 1.0)
        let button = SKSpriteNode(imageNamed: "Spaceship")
        button.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        button.name = "nextButton"
        self.addChild(button)*/
        
        
        /*
        let levelOneLabel = SKLabelNode(fontNamed:UtilitiesPortal.levelLabelFont)
        levelOneLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        levelOneLabel.name = UtilitiesPortal.levelOneLabelName
        levelOneLabel.text = UtilitiesPortal.levelOneLabelText
        levelOneLabel.fontSize = UtilitiesPortal.levelLabelSize
        levelOneLabel.position = CGPointMake(UtilitiesPortal.borderSize, UtilitiesPortal.screenHeight*0.75)
        self.addChild(levelOneLabel)
        
        let levelTwoLabel = SKLabelNode(fontNamed:UtilitiesPortal.levelLabelFont)
        levelTwoLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        levelTwoLabel.name = UtilitiesPortal.levelTwoLabelName
        levelTwoLabel.text = UtilitiesPortal.levelTwoLabelText
        levelTwoLabel.fontSize = UtilitiesPortal.levelLabelSize
        levelTwoLabel.position = CGPointMake(UtilitiesPortal.borderSize, UtilitiesPortal.screenHeight*0.55)
        self.addChild(levelTwoLabel)
        
        let levelThreeLabel = SKLabelNode(fontNamed:UtilitiesPortal.levelLabelFont)
        levelThreeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        levelThreeLabel.name = UtilitiesPortal.levelThreeLabelName
        levelThreeLabel.text = UtilitiesPortal.levelThreeLabelText
        levelThreeLabel.fontSize = UtilitiesPortal.levelLabelSize
        levelThreeLabel.position = CGPointMake(UtilitiesPortal.borderSize, UtilitiesPortal.screenHeight*0.35)
        self.addChild(levelThreeLabel)
        
        let setting = SKLabelNode(fontNamed:UtilitiesPortal.levelLabelFont)
        setting.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        setting.name = UtilitiesPortal.settingLabelName
        setting.text = UtilitiesPortal.settingLabelText
        setting.fontSize = UtilitiesPortal.levelLabelSize
        //setting.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-200)
        setting.position = CGPointMake(UtilitiesPortal.borderSize, UtilitiesPortal.screenHeight*0.15)
        self.addChild(setting)
        */
        
        backgroundColor = SKColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 0.3)
        let image:SKSpriteNode = SKSpriteNode(imageNamed: "background")
        image.setScale(1.5)
        //image.alpha = 0.8
        addChild(image)
        
        let buttonLevel1: GGButton = GGButton(defaultButtonImage: "level1", activeButtonImage: "level2", buttonAction:buttonAction1)
        buttonLevel1.position = CGPointMake(self.frame.width * 0.5, self.frame.height * 0.6)
        buttonLevel1.setScale(0.3)
        buttonLevel1.alpha = 0.9
        addChild(buttonLevel1)
       
        let buttonLevel2: GGButton = GGButton(defaultButtonImage: "level1", activeButtonImage: "level2", buttonAction:buttonAction2)
        buttonLevel2.position = CGPointMake(self.frame.width * 0.5, self.frame.height * 0.4)
        buttonLevel2.setScale(0.3)
        buttonLevel2.alpha = 0.9
        addChild(buttonLevel2)
       
        let buttonLevel3: GGButton = GGButton(defaultButtonImage: "level1", activeButtonImage: "level2", buttonAction:buttonAction3)
        buttonLevel3.position = CGPointMake(self.frame.width * 0.5, self.frame.height * 0.2)
        buttonLevel3.setScale(0.3)
        buttonLevel3.alpha = 0.9
        addChild(buttonLevel3)
    }
    
    func buttonAction1(){
    
        let level1Scene = LevelOneScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blueColor(), duration: 0.5)
        //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
        level1Scene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(level1Scene, transition: transition)
    }
    func buttonAction2(){
    
    }
    func buttonAction3(){
        
    }
    /*
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        /*for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }*/
        let location = touches.first!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        // If next button is touched, start transition to second scene
        if (node.name == UtilitiesPortal.levelOneLabelName) {
            let secondScene = LevelOneScene(size: self.size)
            //let transition = SKTransition.fadeWithColor(UIColor.blueColor(), duration: 0.5)
            let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
        }
        if (node.name == UtilitiesPortal.levelTwoLabelName) {
            //let secondScene = textFiled(size: self.size)
            let secondScene = noticificationView(size: self.size)
           // let transition = SKTransition.fadeWithColor(UIColor.blueColor(), duration: 0.5)
            let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
        }

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    */
}
