//
//  Button.swift
//  Rmitium
//
//  Created by Max on 15/08/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import SpriteKit

class CustomButton: SKNode {
    var defaultButton: SKSpriteNode
    var activeButton: SKSpriteNode
    //var action: () -> Void
    var option: Int
    
    init(defaultButtonImage: String, activeButtonImage: String, /*buttonAction:() -> Void*/option: Int) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        activeButton.hidden = true
        //action = buttonAction
        self.option = option
        
        super.init()
        
        userInteractionEnabled = true
        addChild(defaultButton)
        addChild(activeButton)
    }
    
    /**
     Required so XCode doesn't throw warnings
     */
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        activeButton.hidden = false
        defaultButton.hidden = true
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //var touch: UITouch = touches.allObjects[0] as UITouch
        
        let touch:UITouch = touches.first! as UITouch
        let location: CGPoint = touch.locationInNode(self)
        
        if defaultButton.containsPoint(location) {
            activeButton.hidden = false
            defaultButton.hidden = true
        } else {
            activeButton.hidden = true
            defaultButton.hidden = false
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = touches.first! as UITouch
        let location: CGPoint = touch.locationInNode(self)
        
        if defaultButton.containsPoint(location) {
            //action()
            var scene: SKScene!
            if(option == 1) {
                scene = LevelOneScene(size:frame.size)
            }
            scene = LevelOneScene(size:frame.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.5)
            //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
            scene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(scene, transition: transition)
            
        }
        
        activeButton.hidden = true
        defaultButton.hidden = false
        
    }
}
