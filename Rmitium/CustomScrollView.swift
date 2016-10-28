//
//  CustomScrollView.swift
//  Rmitium
//
//  Created by Aoi Mizu on 27/10/2016.
//  Copyright © 2016 Spencer and Jones. All rights reserved.
//

import SpriteKit

/// Scroll direction
enum ScrollDirection {
    case vertical // cases start with small letters as I am following Swift 3 guildlines.
    case horizontal
}

class CustomScrollView: UIScrollView {
    
    // MARK: - Static Properties
    
    /// Touches allowed
    static var disabledTouches = false
    
    /// Scroll view
    private static var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    /// Current scene
    private let currentScene: SKScene
    
    /// Moveable node
    private let moveableNode: SKNode
    
    /// Scroll direction
    private let scrollDirection: ScrollDirection
    
    /// Touched nodes
    private var nodesTouched = [AnyObject]()
    
    // MARK: - Init
    init(frame: CGRect, scene: SKScene, moveableNode: SKNode, scrollDirection: ScrollDirection) {
        self.currentScene = scene
        self.moveableNode = moveableNode
        self.scrollDirection = scrollDirection
        super.init(frame: frame)
        
        CustomScrollView.scrollView = self
        self.frame = frame
        delegate = self
        indicatorStyle = .White
        scrollEnabled = true
        userInteractionEnabled = true
        //canCancelContentTouches = false
        //self.minimumZoomScale = 1
        //self.maximumZoomScale = 3
        
        if scrollDirection == .horizontal {
            let flip = CGAffineTransformMakeScale(-1,-1)
            transform = flip
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Touches
extension CustomScrollView {
    
    /// Began
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(currentScene)
            
            guard !CustomScrollView.disabledTouches else { return }
            
            /// Call touches began in current scene
            currentScene.touchesBegan(touches, withEvent: event)
            
            /// Call touches began in all touched nodes in the current scene
            nodesTouched = currentScene.nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesBegan(touches, withEvent: event)
            }
        }
    }
    
    /// Moved
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(currentScene)
            
            guard !CustomScrollView.disabledTouches else { return }
            
            /// Call touches moved in current scene
            currentScene.touchesMoved(touches, withEvent: event)
            
            /// Call touches moved in all touched nodes in the current scene
            nodesTouched = currentScene.nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesMoved(touches, withEvent: event)
            }
        }
    }
    
    /// Ended
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(currentScene)
            
            guard !CustomScrollView.disabledTouches else { return }
            
            /// Call touches ended in current scene
            currentScene.touchesEnded(touches, withEvent: event)
            
            /// Call touches ended in all touched nodes in the current scene
            nodesTouched = currentScene.nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesEnded(touches, withEvent: event)
            }
        }
    }
    
    /// Cancelled
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
        for touch in touches! {
            let location = touch.locationInNode(currentScene)
            
            guard !CustomScrollView.disabledTouches else { return }
            
            /// Call touches cancelled in current scene
            currentScene.touchesCancelled(touches!, withEvent: event)
            
            /// Call touches cancelled in all touched nodes in the current scene
            nodesTouched = currentScene.nodesAtPoint(location)
            for node in nodesTouched {
                node.touchesCancelled(touches!, withEvent: event)
            }
        }
    }
}

// MARK: - Touch Controls
extension CustomScrollView {
    
    /// Disable
    class func disable() {
        CustomScrollView.scrollView?.userInteractionEnabled = false
        CustomScrollView.disabledTouches = true
    }
    
    /// Enable
    class func enable() {
        CustomScrollView.scrollView?.userInteractionEnabled = true
        CustomScrollView.disabledTouches = false
    }
}

// MARK: - Delegates
extension CustomScrollView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollDirection == .horizontal {
            moveableNode.position.x = scrollView.contentOffset.x
        } else {
            moveableNode.position.y = scrollView.contentOffset.y
        }
    }
}


