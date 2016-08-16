//
//  noticeficationView.swift
//  Rmitium
//
//  Created by Max on 16/08/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import SpriteKit

class noticificationView: SKScene , UITextViewDelegate{
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor(red: 0.1, green: 0, blue: 0, alpha: 1)
        let myView = UITextView(frame: CGRectMake(view.bounds.width * 0.1  , view.bounds.height * 0.15, view.bounds.width * 0.1, view.bounds.height * 0.1))
        view.addSubview(myView)
        
        
        myView.textColor = UIColor.redColor()
        myView.text = "hello!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        myView.backgroundColor  = UIColor(red: 0.2, green: 0.5, blue: 0, alpha: 0.5)
        myView.alpha = 0.5
    }

    
}
