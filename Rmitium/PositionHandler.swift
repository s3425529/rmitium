//
//  PositionHandler.swift
//  Rmitium
//
//  Created by Aoi Mizu on 9/26/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

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
            return CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.imageBorderSize - UtilitiesPortal.imageWidth/2, y: current.y)
        }
    }
    
    static func convertTargetPointLevelThree(current: CGPoint) -> CGPoint {
        if rightHand {
            return current
        }
        else {
            return CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize - UtilitiesPortal.imageWidth/2, y: current.y)
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