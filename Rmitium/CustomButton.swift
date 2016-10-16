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
    var action: () -> Void
    
    //initial the button with two images and a function
    init(defaultButtonImage: String, activeButtonImage: String, buttonAction:() -> Void, scale:CGFloat) {
        self.defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        self.defaultButton.size = CGSize(width: UtilitiesPortal.screenWidth*scale, height: UtilitiesPortal.screenWidth*scale/2.48)
        self.activeButton = SKSpriteNode(imageNamed: activeButtonImage)
        self.activeButton.size = CGSize(width: UtilitiesPortal.screenWidth*scale, height: UtilitiesPortal.screenWidth*scale/2.48)
        self.activeButton.hidden = true
        action = buttonAction
        
        
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
    //default image change to other image
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
    //active the new image and hide the default image
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = touches.first! as UITouch
        let location: CGPoint = touch.locationInNode(self)
        
        if defaultButton.containsPoint(location) {
            action()
            
        }
        
        activeButton.hidden = true
        defaultButton.hidden = false
        
    }
}
