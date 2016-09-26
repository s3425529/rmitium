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
    
    static func convertTargetPoint(current: CGPoint) -> CGPoint {
        if rightHand {
            return current
        }
        else {
            return CGPoint(x: current.x + UtilitiesPortal.screenWidth*0.4 - UtilitiesPortal.borderSize,
                           y: current.y)
        }
    }
    
    static func convertLabelPoint(current: CGPoint) -> CGPoint {
        if rightHand {
            return current
        }
        else {
            return CGPoint(x: current.x - UtilitiesPortal.screenWidth*0.65,
                           y: current.y)
        }
    }
}