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
    }
    
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
            let transition = SKTransition.fadeWithColor(UIColor.blueColor(), duration: 0.5)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
