//
//  UtilitiesPortal.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/10/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import UIKit

class UtilitiesPortal {
    static let levelLabelNames = ["lvl01", "lvl02", "lvl03", "setting"]
    static let levelLabelTexts = ["Level 1: Identifying Functional Groups",
                                  "Level 2: Building Molecules",
                                  "Level 3: Intermolecular Forces", "SETTINGS"]
    
    static let buttonLevelWidth: CGFloat = 1153
    static let buttonLevelHeight: CGFloat  = 317
    
    static let alphabet = ["A", "B", "C", "D", "E", "F", "G"] //HIJKLMNOPQRSTUVXYZ"
    
    static let screenSize: CGRect = UIScreen.mainScreen().bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
    
    static let hexImageSize = screenHeight*0.15
    
    static let levelLabelFont = "Chalkduster"
    static let levelLabelSize = CGFloat(screenWidth/30)
    static let borderSize = CGFloat(screenWidth/15)
    
    static let imageWidth = screenWidth*0.7
    static let imageHeight = screenHeight*0.6
}