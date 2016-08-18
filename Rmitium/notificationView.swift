//
//  noticeficationView.swift
//  Rmitium
//
//  Created by Max on 16/08/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import SpriteKit
/*
class noticificationView: SKScene , UITextViewDelegate{
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor(red: 0.1, green: 0, blue: 0, alpha: 1)
        let myView = UITextView(frame: CGRectMake(view.bounds.width * 0.1  , view.bounds.height * 0.15, view.bounds.width * 0.1, view.bounds.height * 0.1))
        view.addSubview(myView)
        
        myView.bringSubviewToFront(view)
        myView.textColor = UIColor.redColor()
        myView.text = "hello!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        myView.backgroundColor  = UIColor(red: 0.2, green: 0.5, blue: 0, alpha: 0.5))
    }

    
}
*/
class notificationView: SKNode{
    
   
    var myView: SKShapeNode
    var sceneView: CGRect
    var isShowing = false
    
    init(sceneFrame: CGRect) {
        
        sceneView = sceneFrame
        myView = SKShapeNode(rectOfSize: CGSize(width: sceneView.size.width * 0.8  , height: sceneView.size.height * 0.8))
        super.init()
        myView.fillColor = SKColor.redColor()
        myView.position = CGPoint(x: sceneView.width * 0.5, y: sceneView.height * 0.5)
        myView.zPosition = 1
        addChild(myView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func slideDown(){
    
       // let distance = -myView.frame.size.height
        //let moveAction = (SKAction.moveTo(CGPoint(x: myView., y: <#T##CGFloat#>))), duration: <#T##NSTimeInterval#>))
    }
    func slideUP(){
    
    
    }
    
}


