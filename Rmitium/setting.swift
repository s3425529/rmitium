//
//  setting.swift
//  Rmitium
//
//  Created by Max on 7/09/2016.
//  Copyright © 2016 Spencer and Jones. All rights reserved.
//

import SpriteKit
private let MenuNum = 6
private let rows = 2
private let radius :CGFloat = 30
var nodes = [SKShapeNode]()
var nodesStore = [SKShapeNode]()
var time = 0.0
class setting: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        setupItem()
        setupMenu()
        shakeAction()
        
    }
    func shakeAction(){
        for node in nodes{
            time = time + 1.0
            let movedown1 = SKAction.moveByX(0, y: -frame.midY - radius, duration: 0.25)
            let moveup = SKAction.moveByX(0, y: radius, duration: 0.25)
            let movedown2 = SKAction.moveByX(0, y: -radius, duration: 0.25)
            let pause = SKAction.waitForDuration(time)
            
            let actionSequece = SKAction.sequence([movedown1, moveup, movedown2, pause])
            node.runAction(actionSequece)
        }
    }
    
    func setupMenu(){
        
        for i in 1...MenuNum{
            
            let circle = muneItem()
            circle.name = "menu\(i)"
            let num = MenuNum/rows
            let menuPos = CGPointMake(UtilitiesPortal.screenWidth / CGFloat(num) * CGFloat(i%num) + 100 ,UtilitiesPortal.screenHeight + radius*(CGFloat(i%rows)) * 3)
            circle.position = menuPos
            addChild(circle)
            nodes.append(circle)
        }
        nodesStore = nodes
        
    }
    func muneItem()->SKShapeNode{
        
        let circle = SKShapeNode(circleOfRadius: radius)
        circle.zPosition = 0.2
        let hue = CGFloat(arc4random() % 1000) / 1000
        circle.fillColor = SKColor(hue: hue, saturation: 1, brightness: 1, alpha: 0.5)
        circle.strokeColor = SKColor.blackColor()
        return circle
    }
    
    func setupItem(){
        
        let effectsNode = SKEffectNode()
        let filter = CIFilter(name: "CIGaussianBlur")
        let blur = 10.0
        filter?.setValue(blur, forKey: kCIInputRadiusKey)
        effectsNode.filter = filter
        effectsNode.position = CGPointMake(UtilitiesPortal.screenWidth/2, UtilitiesPortal.screenHeight/2)
        effectsNode.blendMode = .Alpha
        
        
        let image = SKSpriteNode(imageNamed: "background")
        image.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        image.position = CGPoint(x:frame.midX, y:frame.midY)
        image.zPosition = 0
        image.alpha = 0.4
        //image.setScale(1.5)
        //image.alpha = 0.8
        //effectsNode.addChild(image)
        //addChild(effectsNode)
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
        //image.alpha = 0.8
        addChild(logo)
        
        // effectsNode.addChild(image)
        
        //addChild(effectsNode)
    }
    
    
    func  backAction(){
        
        for item in nodes{
            for node in nodesStore{
                
                if item.name == node.name{
                    
                    let moveup = SKAction.moveByX(0, y: node.position.y, duration: 0.5)
                    let wait = SKAction.waitForDuration(1.3)
                    let remove = SKAction.removeFromParent()
                    let actionSequece = SKAction.sequence([moveup, wait, remove])
                    item.runAction(actionSequece)
                }
                
            }
        }
        let triggerTime = (Int64(NSEC_PER_SEC) * 1/3)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            self.backHome()
        })
    }
    
    func backHome(){
        
        let secondScene = GameScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.5)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first?.locationInNode(self)
        let node = self.nodeAtPoint(location!)
        
        if node.name == UtilitiesPortal.settingButtonName {
            backAction()
        }
        
        if node.name == nodes[0].name {
            let fade = SKAction.fadeOutWithDuration(0.5)
            let zoom = SKAction.scaleTo(1.5, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let actionSequence = SKAction.sequence([zoom,fade,remove])
            nodes[0].runAction(actionSequence)
            backHome()
        }
        if node.name == nodes[1].name {
            let fade = SKAction.fadeOutWithDuration(0.5)
            let zoom = SKAction.scaleTo(1.5, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let actionSequence = SKAction.sequence([zoom,fade,remove])
            
            nodes[1].runAction(actionSequence)
            backHome()
        }
        if node.name == nodes[2].name {
            let fade = SKAction.fadeOutWithDuration(0.5)
            let zoom = SKAction.scaleTo(1.5, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let actionSequence = SKAction.sequence([zoom,fade,remove])
            
            nodes[2].runAction(actionSequence)
            backHome()
        }
        if node.name == nodes[3].name {
            let fade = SKAction.fadeOutWithDuration(0.5)
            let zoom = SKAction.scaleTo(1.5, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let actionSequence = SKAction.sequence([zoom,fade,remove])
            
            nodes[3].runAction(actionSequence)
            backHome()
        }
        if node.name == nodes[4].name {
            let fade = SKAction.fadeOutWithDuration(0.5)
            let zoom = SKAction.scaleTo(1.5, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let actionSequence = SKAction.sequence([zoom,fade,remove])
            
            nodes[4].runAction(actionSequence)
            backHome()
        }
        if node.name == nodes[5].name {
            let fade = SKAction.fadeOutWithDuration(0.5)
            let zoom = SKAction.scaleTo(1.5, duration: 0.5)
            let remove = SKAction.removeFromParent()
            let actionSequence = SKAction.sequence([zoom,fade,remove])
            
            nodes[5].runAction(actionSequence)
            backHome()
        }
    }
}
