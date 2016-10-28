//
//  PositionHandler.swift
//  Rmitium
//
//  Created by Aoi Mizu on 9/26/16.
//  Copyright © 2016 Spencer and Jones. All rights reserved.
//

// ***********
// Converting Level 1 and Level 3 display mode (default as right-hand mode) to left-hand mode
// ***********

import Foundation
import SpriteKit

class PositionHandler {
    static var rightHand: Bool = true;
    
    static func setRightHand() -> Bool {
        rightHand = DataHandler.getSettings().getRightHand
        return rightHand
    }
    
    static func convertTargetPointLevelOne(current: CGPoint) -> CGPoint {
        if rightHand {
            return current
        }
        else {
            return CGPoint(x:UtilitiesPortal.screenWidth - 2*UtilitiesPortal.imageBorderSize - UtilitiesPortal.imageWidth + current.x, y: current.y)
        }
    }
    
    static func convertTargetPointLevelThree(current: CGPoint) -> CGPoint {
        if rightHand {
            return current
        }
        else {
            return CGPoint(x:UtilitiesPortal.screenWidth - 2*UtilitiesPortal.borderSize - UtilitiesPortal.imageWidth + current.x, y: current.y)
        }
    }
    
    static func convertLevelOneLabelPoint(current: CGPoint) -> CGPoint {
        if rightHand {
            return current
        }
        else {
            return CGPoint(x: current.x - UtilitiesPortal.screenWidth*0.65,
                           y: current.y)
        }
    }
    
    static func convertLevelThreeLabelPoint(current: CGPoint) -> CGPoint {
        if rightHand {
            return current
        }
        else {
            return CGPoint(x: current.x - UtilitiesPortal.screenWidth*0.70,
                           y: current.y)
        }
    }
}
