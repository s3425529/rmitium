//
//  File.swift
//  Rmitium
//
//  Created by Max on 15/08/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

// add the UITextFieldDelegate to your GameScene class
import SpriteKit
class textFiled: SKScene, UITextFieldDelegate {
    
    let gameOver = SKLabelNode(fontNamed: "arial")
    // let submitScore = SKSpriteNode(imageNamed: "button")
    let submitScoreText = SKLabelNode(fontNamed: "arial")
    let submitScoreTextShadow = SKLabelNode(fontNamed: "arial")
    var highScoreText: UITextField!
    
    override func didMoveToView(view: SKView) {
        // changed to SKColor, but UIColor will work the same way. No Hex value.
        backgroundColor = SKColor(red: 0.53, green: 0.85, blue: 0.99, alpha: 1)
        
        // create the UITextField instance with positions... half of the screen width minus half of the textfield width.
        // Same for the height.
        highScoreText = UITextField(frame: CGRectMake(view.bounds.width / 2 - 160, view.bounds.height / 2 - 20, 320, 40))
        
        // add the UITextField to the GameScene's view
        view.addSubview(highScoreText)
        
        // add the gamescene as the UITextField delegate.
        // delegate funtion called is textFieldShouldReturn:
        highScoreText.delegate = self
        
        highScoreText.borderStyle = UITextBorderStyle.RoundedRect
        highScoreText.textColor = SKColor.blackColor()
        highScoreText.placeholder = "Enter your name here"
        highScoreText.backgroundColor = SKColor.whiteColor()
        highScoreText.autocorrectionType = UITextAutocorrectionType.Yes
        
        highScoreText.clearButtonMode = UITextFieldViewMode.WhileEditing
        highScoreText.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
        self.view!.addSubview(highScoreText)
        
        submitScoreText.fontSize = 22
        submitScoreText.position = CGPoint(x: size.width / 2, y: size.height * 0.7)
        submitScoreText.text = "your text will show here"
        addChild(submitScoreText)
    }
    
    
    // Called by tapping return on the keyboard.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Populates the SKLabelNode
        submitScoreText.text = textField.text
        
        // Hides the keyboard
        
        textField.resignFirstResponder()
        return true
    }  
    
}