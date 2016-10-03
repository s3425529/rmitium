//
//  MedalInfo.swift
//  Rmitium
//
//  Created by Max on 2/10/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import SpriteKit

struct medalStru {
    var image:String!
    var text:String!
}
class MedalInfo:SKNode{
    var medalItem = [medalStru]()
    
    var myView:SKShapeNode!
    init(myView:SKShapeNode) {
        super.init()
        self.myView = myView
        medalItem.append(medalStru(image: "Medal1-Diamond", text: "100%"))
        medalItem.append(medalStru(image: "Medal2-Gold", text: "80-99%"))
        medalItem.append(medalStru(image: "Medal3-Silver", text: "70-89%"))
        medalItem.append(medalStru(image: "Medal4-Bronze", text: "50-69%"))
        medalItem.append(medalStru(image: "Medal5-Rust", text: "<50%"))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupItem(){
    
       
        myView.path = UIBezierPath(roundedRect: CGRect(x: -UtilitiesPortal.screenWidth/2 + UtilitiesPortal.screenWidth*0.1, y: -UtilitiesPortal.screenHeight/2 + UtilitiesPortal.screenHeight*0.1, width: UtilitiesPortal.screenWidth*0.8 , height: UtilitiesPortal.screenHeight*0.8), cornerRadius: 10).CGPath
        myView.fillColor = SKColor.blackColor()
        myView.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        myView.zPosition = 0.9
        myView.alpha = 0.9


        for i in 0..<medalItem.count{
            
            let size = CGSize(width: myView.frame.height / 5, height: myView.frame.height / 5 )
            let imageNode = SKSpriteNode(imageNamed: medalItem[i].image)
            imageNode.size = size
            imageNode.position = CGPoint(x: myView.position.x - myView.frame.width, y: (myView.position.y - myView.frame.height)*1.05 + size.height * CGFloat(i))
            imageNode.zPosition = 0.9
            
            let p = CGPoint(x:  myView.position.x - myView.frame.width/2 , y: (myView.position.y - myView.frame.height) + size.height * CGFloat(i+1))
            
            let textNode = SKMultilineLabel(text: medalItem[i].text, labelWidth: myView.frame.width - size.width*3, pos: p)
            //textNode.alignment = .Left
        //  let textNode = SKLabelNode(fontNamed: "ChalkboardSE-Regular")
           // textNode.text = medalItem[i].text
           // textNode.position = CGPoint(x:  myView.position.x - myView.frame.width + size.width , y: (myView.position.y - myView.frame.height) + size.height * CGFloat(i))
            textNode.zPosition = 0.9
            //textNode.horizontalAlignmentMode = .Left
            textNode.alignment = .Left
            textNode.leading = Int(UtilitiesPortal.screenHeight*0.05)
            textNode.fontSize = UtilitiesPortal.screenHeight*0.05
            myView.addChild(imageNode)
            
            myView.addChild(textNode)
            
 
        }
    }
}