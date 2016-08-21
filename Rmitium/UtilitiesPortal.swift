//
//  UtilitiesPortal.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/10/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class UtilitiesPortal {
    //static let mainScene = GameScene(fileNamed:"GameScene")
    
    static let levelLabelNames = ["lvl01", "lvl02", "lvl03", "setting"]
    static let levelOneAnswers = ["phenol", "acid", "alcohol", "amine", "amide", "alkene",
                                  "aldehyde", "ester", "ether", "thioether", "heterocyclicaromatic"]
    static let levelLabelTexts = ["Level 1: Identifying Functional Groups",
                                  "Level 2: Building Molecules",
                                  "Level 3: Intermolecular Forces", "SETTINGS"]
    
    static let emptyString = "nil"
    
    static let homeButtonName = "homeBtn"
    static let helpButtonName = "helpBtn"
    
    static let buttonLevelWidth: CGFloat = 1153
    static let buttonLevelHeight: CGFloat  = 317
    
    static let alphabet = ["A", "B", "C", "D", "E", "F", "G"] //HIJKLMNOPQRSTUVXYZ"
    
    static let screenSize: CGRect = UIScreen.mainScreen().bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
    
    static let hexImageSize = screenHeight*0.15
    
    static let navLabelFont = "Helvatica-Bold"
    static let navLabelSize = CGFloat(screenWidth/25)
    static let navImgSize = screenHeight*0.10
    
    static let levelLabelSize = CGFloat(screenWidth/30)
    
    static let levelLabelFont = "Chalkduster"
    static let levelLabelAnswerSize = CGFloat(screenWidth/40)
    
    static let borderSize = CGFloat(screenWidth/15)
    
    static let imageWidth = screenWidth*0.6
    static let imageHeight = screenHeight*0.6
}