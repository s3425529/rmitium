//
//  CustomSKSpriteNode.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/19/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import SpriteKit

class CustomSKSpriteNode: SKSpriteNode {
    var value: String
    
    override init(texture: SKTexture!, color: SKColor, size: CGSize) {
        self.value = "" // Some sort of sensible default
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(color: SKColor, answerValue: String = "") {
        let size = CGSize(width: 10, height: 10);
        self.init(texture:nil, color: color, size: size)
        self.value = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        // Decoding length here would be nice...
        self.value = ""
        super.init(coder: aDecoder)
    }
}
