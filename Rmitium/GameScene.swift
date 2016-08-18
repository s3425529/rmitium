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
        
        let image = SKSpriteNode(imageNamed: "background")
        image.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        image.position = CGPoint(x:frame.midX, y:frame.midY)
        image.zPosition = 0
        //image.setScale(1.5)
        //image.alpha = 0.8
        addChild(image)
        
        // Add new button
        
        
        let home = SKSpriteNode(imageNamed: "home_1")
        home.name = UtilitiesPortal.homeButtonName
        home.zPosition = 0.1
        home.alpha = 0.9
        home.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        home.position = CGPoint(x:UtilitiesPortal.borderSize/2,
            y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(home)
        
        let help1 = SKSpriteNode(imageNamed: "help")
        help1.zPosition = 0.1
        help1.alpha = 0.9
        help1.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        help1.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
            y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        
        
        addChild(help1)
        
        let logo = SKSpriteNode(imageNamed: "logo")
        logo.setScale(UtilitiesPortal.screenHeight/88*0.30)
 
        //logo.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        logo.position = CGPoint(x:frame.midX, y:UtilitiesPortal.screenHeight*0.85)
        logo.zPosition = 0.1
        //image.alpha = 0.8
        addChild(logo)
        
        /*var scale: CGFloat = 0
        let scaleHeight = UtilitiesPortal.screenHeight/UtilitiesPortal.buttonLevelHeight*0.15
        let scaleWidth = UtilitiesPortal.screenWidth/UtilitiesPortal.buttonLevelWidth*0.6
        if(scaleHeight > scaleWidth) {
            scale = scaleWidth
        }
        else {
            scale = scaleHeight
        }*/

        for count in 0...2 {
            let levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.levelLabelFont)
            //levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
            levelLabel.zPosition = 1
            levelLabel.name = UtilitiesPortal.levelLabelNames[count]
            levelLabel.text = UtilitiesPortal.levelLabelTexts[count]
            levelLabel.fontSize = UtilitiesPortal.levelLabelSize
            levelLabel.position = CGPointMake(frame.midX/*UtilitiesPortal.borderSize*/,
                                              UtilitiesPortal.screenHeight*(0.60-CGFloat(count)*0.15))
            self.addChild(levelLabel)
            
            /*let levelHexImage = SKSpriteNode(imageNamed: "hexagon")
            levelHexImage.alpha = 0.9
            levelHexImage.zPosition = 0.6
            levelHexImage.size = CGSize(width: UtilitiesPortal.hexImageSize*2,
                                      height: UtilitiesPortal.hexImageSize*2)
            levelHexImage.position = CGPointMake(UtilitiesPortal.borderSize+UtilitiesPortal.hexImageSize/4, UtilitiesPortal.screenHeight*(0.75-CGFloat(count)*0.2)+UtilitiesPortal.hexImageSize/4)
            self.addChild(levelHexImage)*/
            
            let levelButton = SKSpriteNode(imageNamed: "levelButton")
            levelButton.alpha = 0.9
            levelButton.zPosition = 0.5
            levelButton.position = CGPointMake(frame.midX/*UtilitiesPortal.borderSize/4 + UtilitiesPortal.screenWidth*0.4*/, UtilitiesPortal.screenHeight*(0.60-CGFloat(count)*0.15))
            levelButton.size = CGSize(width: UtilitiesPortal.screenWidth*0.9,
                                         height: UtilitiesPortal.hexImageSize*1.2)
            self.addChild(levelButton)
            
            /*let button = CustomButton(defaultButtonImage: "level1", activeButtonImage: "level2",
                                      option: count)
            button.setScale(0.4)
            print("Scale: \(scale)")
            button.alpha = 0.9
            button.zPosition = 1
            button.position = CGPointMake(100,100 + CGFloat(count)*20)
            self.addChild(button)*/
        }
        
        /*backgroundColor = SKColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 0.3)
        let image:SKSpriteNode = SKSpriteNode(imageNamed: "background")
        image.setScale(1.5)
        //image.alpha = 0.8
        addChild(image)
        
        let buttonLevel1: GGButton = GGButton(defaultButtonImage: "level1", activeButtonImage: "level2", /*buttonAction:buttonAction2*/option: 1)
        buttonLevel1.position = CGPointMake(self.frame.width * 0.5, self.frame.height * 0.6)
        buttonLevel1.setScale(0.28)
        buttonLevel1.alpha = 0.9
        addChild(buttonLevel1)
       
        let buttonLevel2: GGButton = GGButton(defaultButtonImage: "level1", activeButtonImage: "level2", /*buttonAction:buttonAction2*/option: 2)
        buttonLevel2.position = CGPointMake(self.frame.width * 0.5, self.frame.height * 0.4)
        buttonLevel2.setScale(0.28)
        buttonLevel2.alpha = 0.9
        addChild(buttonLevel2)
       
        let buttonLevel3: GGButton = GGButton(defaultButtonImage: "level1", activeButtonImage: "level2", /*buttonAction:buttonAction2*/option: 3)
        buttonLevel3.position = CGPointMake(self.frame.width * 0.5, self.frame.height * 0.2)
        buttonLevel3.setScale(0.28)
        buttonLevel3.alpha = 0.9
        addChild(buttonLevel3)*/
    }
    
    /*func buttonAction1(){
    
        let level1Scene = LevelOneScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blueColor(), duration: 0.5)
        //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
        level1Scene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(level1Scene, transition: transition)
    }
    func buttonAction2(){
    
    }
    func buttonAction3(){
        
    }*/
    
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
        if (node.name == UtilitiesPortal.levelLabelNames[0]) {
            let secondScene = LevelOneScene(size: self.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
            //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
        }

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
