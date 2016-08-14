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
    static let levelOneLabelName = "lvl01"
    static let levelOneLabelText = "LEVEL 1: Identifying Functional Groups"
    static let levelTwoLabelName = "lvl02"
    static let levelTwoLabelText = "LEVEL 2: Building Molecules"
    static let levelThreeLabelName = "lvl03"
    static let levelThreeLabelText = "LEVEL 3: Intermolecular Forces"
    static let settingLabelName = "setting"
    static let settingLabelText = "SETTINGS"
    
    static let alphabet = ["A", "B", "C", "D", "E", "F", "G"] //HIJKLMNOPQRSTUVXYZ"
    
    static let screenSize: CGRect = UIScreen.mainScreen().bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
    
    static let levelLabelFont = "Chalkduster"
    static let levelLabelSize = CGFloat(screenWidth/30)
    static let borderSize = screenWidth/15
    
    static let imageWidth = screenWidth*0.7
    static let imageHeight = screenHeight*0.6
}