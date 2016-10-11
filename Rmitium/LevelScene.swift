//
//  LevelScene.swift
//  Rmitium
//
//  Created by Thinh Tran on 5/10/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import AVFoundation
import SpriteKit

class LevelScene: SKScene {
    //var answers: [CustomSKSpriteNode] = []
    var questions: [CustomSKSpriteNode] = []
    var answeredQuestions: [CustomSKSpriteNode] = []
    var positions = [Position]()
    var currentAnswerPostions: [CGPoint] = []
    var factOverlayText: SKMultilineLabel!
    var infoOverlay, infoOverlayResult, factOverlay, homeView, factView, show, tick: SKSpriteNode!
    var homeDialogue: SKShapeNode!
    var score, factLabel, molecule, timeNode: SKLabelNode!
    var state, previousState: Int!
    var timeNsNode:NSTimer!
    var audioPlayer = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        setupScene()
    }
    
    func setupScene() {
        self.removeAllChildren()
        positions.removeAll()
        questions.removeAll()
        answeredQuestions.removeAll()
        
        PositionHandler.setRightHand()
        
        if let clickSound = NSBundle.mainBundle().URLForResource("clickSound", withExtension: "wav") {
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: clickSound, fileTypeHint: nil)
                audioPlayer.prepareToPlay()
            }
            catch {
                fatalError("Error loading sound: \(error)")
            }
        }
        
        //state = UtilitiesPortal.stateAnswer
        //setupItems()
        //setupImage()
        //setupDragLabel()
        //setupTargets()
        //setupFactLabel()
        //setupInfo()
        //setupInfoResult()
        createHomeDialogue()
    }
    
    func touchesBeganSuper(touches: Set<UITouch>, withEvent event: UIEvent?) -> Bool {
        let touch = touches.first
        
        if state == UtilitiesPortal.stateHome {
            let location = touch!.locationInNode(self)
            let nodes = self.nodesAtPoint(location)
            for node in nodes {
                if node.name == UtilitiesPortal.yesButtonName {
                    backHomePage()
                    return true
                }
                else if node.name == UtilitiesPortal.noButtonName {
                    homeDialogue.hidden = true
                    homeView.hidden = true
                    state = previousState
                    previousState = UtilitiesPortal.stateHome
                    return true
                }
            }
            return false
        }
        
        if state == UtilitiesPortal.stateInfo {
            infoOverlay.hidden = true
            //infoOverlay.removeAllActions()
            //infoOverlay.removeAllChildren()
            //infoOverlay.removeFromParent()
            state = previousState
            previousState = UtilitiesPortal.stateInfo
            return true
        }
        
        if state == UtilitiesPortal.stateInfoResult {
            infoOverlayResult .hidden = true
            //infoOverlayResult .removeAllActions()
            //infoOverlayResult .removeAllChildren()
            //infoOverlayResult .removeFromParent()
            state = previousState
            previousState = UtilitiesPortal.stateInfoResult
            return true
        }
        
        if state == UtilitiesPortal.stateFact {
            setupScene()
            return true
        }
        
        // Home button selected
        let location = touch!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if node.name == UtilitiesPortal.homeButtonName {
            homeDialogue.hidden = false
            homeView.hidden = false
            previousState = state
            state = UtilitiesPortal.stateHome
        }
        
        //Fact Overlay selected
        if node.name == UtilitiesPortal.factOverlayName {
            factOverlay.hidden = true
            factView.hidden = true
            setupScene()
            return true
        }
        
        return false
    }
    
    ////////////////////////////
    // List of final fuctions //
    ////////////////////////////
    
    final func createHomeDialogue() {
        let yesBtn = SKSpriteNode()
        let noBtn = SKSpriteNode()
        let alertLine1 = SKLabelNode(text: "Are you sure")
        let alertMessage = SKLabelNode(text: "you want to quit?")
        
        alertLine1.position = CGPoint(x: 0, y: 0 + alertLine1.fontSize * 0.75)
        alertLine1.zPosition = 0.9
        alertLine1.fontName = UtilitiesPortal.navLabelFont
        alertLine1.fontSize = UtilitiesPortal.factSize
        
        alertMessage.position = CGPoint(x: 0, y: 0)
        alertMessage.zPosition = 0.9
        alertMessage.fontName = UtilitiesPortal.navLabelFont
        alertMessage.fontSize = UtilitiesPortal.factSize
        
        homeView = SKSpriteNode()
        homeView.color = SKColor.blackColor()
        homeView.alpha = 0.8
        homeView.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        homeView.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        homeView.zPosition = 0.8
        homeView.hidden = true
        
        
        homeDialogue = SKShapeNode()
        homeDialogue.path = UIBezierPath(roundedRect: CGRect(x: -UtilitiesPortal.screenWidth/5, y: -UtilitiesPortal.screenHeight/5, width: UtilitiesPortal.screenWidth/2.5, height: UtilitiesPortal.screenHeight/2.5), cornerRadius: 5).CGPath
        homeDialogue.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        homeDialogue.fillColor = SKColor.blackColor()
        
        homeDialogue.alpha = 0.9
        homeDialogue.zPosition = 0.9
        homeDialogue.hidden = true
        
        yesBtn.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        yesBtn.color = SKColor.grayColor()
        yesBtn.name = UtilitiesPortal.yesButtonName
        yesBtn.texture = SKTexture(image: UIImage(named: "tick-white")!)
        yesBtn.position = CGPoint(x: (0 - yesBtn.size.width), y: (0 - yesBtn.size.height)*1.2)
        yesBtn.zPosition = 0.9
        
        noBtn.size = yesBtn.size
        noBtn.color = yesBtn.color
        noBtn.name = UtilitiesPortal.noButtonName
        noBtn.texture = SKTexture(image: UIImage(named: "cross-white")!)
        noBtn.position = CGPoint(x: yesBtn.size.width, y: (0 - yesBtn.size.height)*1.2)
        noBtn.zPosition = 0.9
        
        homeDialogue.addChild(yesBtn)
        homeDialogue.addChild(noBtn)
        homeDialogue.addChild(alertMessage)
        homeDialogue.addChild(alertLine1)
        addChild(homeDialogue)
        addChild(homeView)
    }

    final func backHomePage() {
        UtilitiesPortal.score = 0
        UtilitiesPortal.totalQuestions = 0
        cleanScene()
        let secondScene = GameScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    ///////////////////////////////////
    //List of Overridable Functions: //
    ///////////////////////////////////
    
    func setupItems() {
        let levelLabel = SKLabelNode(fontNamed: UtilitiesPortal.navLabelFont)
        levelLabel.zPosition = 0.1
        levelLabel.text = String(self.userData!.valueForKey("levelName")!)
        levelLabel.fontSize = UtilitiesPortal.navLabelSize
        levelLabel.position = CGPointMake(frame.midX, UtilitiesPortal.screenHeight*0.92)
        self.addChild(levelLabel)
        
        // Home button
        let home = SKSpriteNode(imageNamed: "home")
        home.name = UtilitiesPortal.homeButtonName
        home.zPosition = 0.1
        home.alpha = 1
        home.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        home.position = CGPoint(x:UtilitiesPortal.borderSize/2,
                                y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(home)
        
        // Tick button
        tick = SKSpriteNode(imageNamed: "submit-grey")
        tick.name = UtilitiesPortal.tickButtonName
        tick.zPosition = 0.1
        tick.alpha = 1
        tick.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        tick.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
                                y: UtilitiesPortal.navImgSize/2)
        addChild(tick)
        
        // Show button
        show = SKSpriteNode(imageNamed: "show")
        show.name = UtilitiesPortal.showButtonName
        show.zPosition = 0.1
        show.alpha = 1
        show.hidden = true
        show.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        show.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*2,
                                y: UtilitiesPortal.navImgSize/2)
        addChild(show)
        
        // Info button
        let info = SKSpriteNode(imageNamed: "help3")
        info.name = UtilitiesPortal.infoButonName
        info.zPosition = 0.1
        info.alpha = 1
        info.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        info.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
                                y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(info)
        
        // Score label
        score = SKLabelNode(fontNamed:UtilitiesPortal.factFont)
        score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        score.zPosition = 0.1
        score.text = "\(UtilitiesPortal.scoreText) \(UtilitiesPortal.score)"
        score.fontSize = UtilitiesPortal.factSize
        score.position = CGPointMake(UtilitiesPortal.borderSize/4, UtilitiesPortal.borderSize/4)
        self.addChild(score)
        
    }
    
    func setupImage() {
        
    }
    
    func setupDragLabel() {
        
    }
    
    func setupTargets() {
        
    }
    
    func setupFactLabel() {
        
    }
    
    func setupInfo() {
        
    }
    
    func setupInfoResult(){
        
    }
    
    func cleanScene() {
        
    }
    
    
}
