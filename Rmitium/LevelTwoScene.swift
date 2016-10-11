//
//  LevelTwoScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 9/11/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import AVFoundation
import Foundation
import SpriteKit

class LevelTwoScene: LevelScene {
    var answers: [CustomSKSpriteNode] = []
    var chosenAnswer: Int!
    var timeOutMessage: SKShapeNode!
    var modeLabel: SKLabelNode!
    var timerClass:TimeControl!
    var LIMITTIME :Int!
    var plus = false
    
    override func didMoveToView(view: SKView) {
        //This is the template for implementing setting
        switch String(self.userData!.valueForKey("gameMode")!) {
            case UtilitiesPortal.modeLabelTexts[0]:
                //code goes here
                print("Game mode: \(UtilitiesPortal.modeLabelTexts[0])")
                DataHandler.saveLevelTwoFirstTime(UtilitiesPortal.modeLabelTexts[0])
                setupTimer()
            break
            case UtilitiesPortal.modeLabelTexts[1]:
                //code goes here
                print("Game mode: \(UtilitiesPortal.modeLabelTexts[1])")
                DataHandler.saveLevelTwoFirstTime(UtilitiesPortal.modeLabelTexts[1])
                trialTimer()
            break
            case UtilitiesPortal.modeLabelTexts[2]:
                //code goes here
                print("Game mode: \(UtilitiesPortal.modeLabelTexts[2])")
                DataHandler.saveLevelTwoFirstTime(UtilitiesPortal.modeLabelTexts[2])
                beatTimer()
            break
            default:
            break
        }
        setupScene()
    }
    
    override func setupScene() {
        super.setupScene()
        
        if DataHandler.getLevelTwoScore() == UtilitiesPortal.firstResult {
            previousState = UtilitiesPortal.stateAnswer
            state = UtilitiesPortal.stateInfo
        }
        else {
            state = UtilitiesPortal.stateAnswer
        }
        
        setupItems()
        setupDragLabel()
        setupInfo()
    }
    
    override func setupItems() {
        super.setupItems()
        
        //Hide score and tick
        tick.hidden = true
        score.hidden = true
        
        // Mode Label
        modeLabel = SKLabelNode(fontNamed: UtilitiesPortal.factFont)
        modeLabel.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.borderSize/4)
        modeLabel.zPosition = 0.1
        modeLabel.fontSize = UtilitiesPortal.factSize
        
        modeLabel.text = String(self.userData!.valueForKey("gameMode")!)
        self.addChild(modeLabel)
        // Time label
        timeNode = SKLabelNode(fontNamed:UtilitiesPortal.factFont)
        timeNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        timeNode.zPosition = 0.1
        timeNode.text = "Time:\(timerClass.timeLabel)"
        timeNode.fontSize = UtilitiesPortal.factSize
        timeNode.position = CGPointMake(UtilitiesPortal.borderSize/4, UtilitiesPortal.borderSize/4)
        self.addChild(timeNode)
    }
    
    override func setupDragLabel() {
        answers.removeAll()
        var list = LevelTwoQuestionList.getQuestionsList()
        for count in 0...list.count-1 {
            let answer = CustomSKSpriteNode(imageNamed: "\(list[count])")
            answer.value = "\(list[count])"
            answer.zPosition = 0.3
            answer.alpha = 0.9
            answer.size = CGSize(width: UtilitiesPortal.levelTwoImageWidth*UtilitiesPortal.screenWidth,
                                 height: UtilitiesPortal.levelTwoImageHeight*UtilitiesPortal.screenHeight)
            answer.position = CGPoint(
                x:UtilitiesPortal.screenWidth*(0.10+UtilitiesPortal.levelTwoImageWidth*CGFloat(count%UtilitiesPortal.levelTwoWidth)),
                y:UtilitiesPortal.screenHeight*(0.8-UtilitiesPortal.levelTwoImageHeight*CGFloat(count/UtilitiesPortal.levelTwoWidth)))
            
            addChild(answer)
            answers.append(answer)
        }
    }
    
    // Info layout
    override func setupInfo() {
        /*let arrow01 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[0])
        arrow01.zPosition = 0.9
        arrow01.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*2)
        arrow01.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.4,
                                   y: UtilitiesPortal.screenHeight * -0.3)*/
        
        let arrow02 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[1])
        arrow02.zPosition = 0.9
        arrow02.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*2)
        arrow02.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.4,
                                   y: UtilitiesPortal.screenHeight * 0.3)
        
        /*let arrow03 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[2])
        arrow03.zPosition = 0.9
        arrow03.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*2)
        arrow03.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.24,
                                   y: UtilitiesPortal.screenHeight * -0.1)
        let action1_1 = SKAction.fadeOutWithDuration(0.6)
        let action1_2 = SKAction.fadeInWithDuration(0.6)
        let sequence1 = SKAction.sequence([action1_1, action1_2])
        let repeatAction1 = SKAction.repeatActionForever(sequence1)
        arrow03.runAction(repeatAction1)
        
        let arrow04 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[3])
        arrow04.zPosition = 0.9
        arrow04.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*2)
        arrow04.position = CGPoint(x: UtilitiesPortal.screenWidth * -0.15,
                                   y: UtilitiesPortal.screenHeight * -0.1)
        let action2_1 = SKAction.fadeInWithDuration(0.6)
        let action2_2 = SKAction.fadeOutWithDuration(0.6)
        let sequence2 = SKAction.sequence([action2_1, action2_2])
        let repeatAction2 = SKAction.repeatActionForever(sequence2)
        arrow04.runAction(repeatAction2)*/
        
        let arrow05 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[4])
        arrow05.zPosition = 0.9
        arrow05.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*2)
        arrow05.position = CGPoint(x: UtilitiesPortal.screenWidth * -0.4,
                                   y: UtilitiesPortal.screenHeight * 0.30)
        
        let arrow06 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[5])
        arrow06.zPosition = 0.9
        arrow06.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*2)
        arrow06.position = CGPoint(x: UtilitiesPortal.screenWidth * -0.4,
                                   y: UtilitiesPortal.screenHeight * -0.30)
        
        let info01 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[0])
        info01.zPosition = 1
        info01.size = CGSize(width: UtilitiesPortal.screenWidth*0.25,
                             height: UtilitiesPortal.screenHeight*0.15)
        info01.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.38,
                                  y: UtilitiesPortal.screenHeight * 0.14)
        
        let info02 = SKSpriteNode(imageNamed: UtilitiesPortal.levelGameMode[0])
        switch String(self.userData!.valueForKey("gameMode")!) {
        case UtilitiesPortal.modeLabelTexts[0]:
            info02.texture = SKTexture(image: UIImage(named: UtilitiesPortal.levelGameMode[0])!)
            info02.zPosition = 1
            info02.size = CGSize(width: UtilitiesPortal.screenWidth*0.25*2.2,
                                 height: UtilitiesPortal.screenHeight*0.15*1.49)
            info02.position = CGPoint(x: UtilitiesPortal.screenWidth*0.01,
                                      y: UtilitiesPortal.screenHeight*(-0.4))
            break
        case UtilitiesPortal.modeLabelTexts[1]:
            info02.texture = SKTexture(image: UIImage(named: UtilitiesPortal.levelGameMode[1])!)
            info02.zPosition = 1
            info02.size = CGSize(width: UtilitiesPortal.screenWidth*0.25*2.2,
                                 height: UtilitiesPortal.screenHeight*0.15*1.49)
            info02.position = CGPoint(x: UtilitiesPortal.screenWidth*0.01,
                                      y: UtilitiesPortal.screenHeight*(-0.4))
            break
        case UtilitiesPortal.modeLabelTexts[2]:
            info02.texture = SKTexture(image: UIImage(named: UtilitiesPortal.levelGameMode[2])!)
            info02.zPosition = 1
            info02.size = CGSize(width: UtilitiesPortal.screenWidth*0.25*2.2,
                                 height: UtilitiesPortal.screenHeight*0.15*1.49)
            info02.position = CGPoint(x: UtilitiesPortal.screenWidth*0.01,
                                      y: UtilitiesPortal.screenHeight*(-0.4))
            break
        default:
            break
        }
        
        let info03 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[6])
        info03.zPosition = 1
        info03.size = CGSize(width: UtilitiesPortal.screenWidth*0.25*2.2,
                             height: UtilitiesPortal.screenHeight*0.15*1.49)
        info03.position = CGPoint(x: UtilitiesPortal.screenWidth*0.01,
                                  y: UtilitiesPortal.screenHeight*(0))
        
        let info04 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[3])
        info04.zPosition = 1
        info04.size = CGSize(width: UtilitiesPortal.screenWidth*0.25,
                             height: UtilitiesPortal.screenHeight*0.15)
        info04.position = CGPoint(x: UtilitiesPortal.screenWidth * -0.35,
                                  y: UtilitiesPortal.screenHeight * 0.15)
        
        let info05 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[8])
        info05.zPosition = 1
        info05.size = CGSize(width: UtilitiesPortal.screenWidth*0.25,
                             height: UtilitiesPortal.screenHeight*0.15)
        info05.position = CGPoint(x: UtilitiesPortal.screenWidth * -0.35,
                                  y: UtilitiesPortal.screenHeight * -0.10)
        
        infoOverlay = SKSpriteNode()
        infoOverlay.name = UtilitiesPortal.factOverlayName
        infoOverlay.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        infoOverlay.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        infoOverlay.color = SKColor.blackColor()
        infoOverlay.alpha = 0.7
        infoOverlay.zPosition = 0.8
        
        if state == UtilitiesPortal.stateInfo {
            infoOverlay.hidden = false
        }
        else {
            infoOverlay.hidden = true
        }
        
        //infoOverlay.addChild(arrow01)
        infoOverlay.addChild(arrow02)
        //infoOverlay.addChild(arrow03)
        //infoOverlay.addChild(arrow04)
        infoOverlay.addChild(arrow05)
        infoOverlay.addChild(arrow06)
        
        infoOverlay.addChild(info01)
        infoOverlay.addChild(info02)
        infoOverlay.addChild(info03)
        infoOverlay.addChild(info04)
        infoOverlay.addChild(info05)
        
        addChild(infoOverlay)
    }
    
    
    func addTimeOutMessage() {
        let retryBtn = SKSpriteNode()
        let backHomebtn = SKSpriteNode()
        let title = SKLabelNode(text:"Time Out!")
        let message = SKLabelNode(text: "Wanna try again?")
        let backgroundNode = SKSpriteNode()
        
        homeDialogue.hidden = true
        homeView.hidden = true
        infoOverlay.hidden = true
        
        backgroundNode.color = SKColor.blackColor()
        backgroundNode.alpha = 0.8
        backgroundNode.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        backgroundNode.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        backgroundNode.zPosition = 0.8
        
        title.position = CGPoint(x: 0, y: 0 + message.fontSize*3.5)
        title.zPosition = 0.9
        title.fontName = UtilitiesPortal.navLabelFont
        title.fontSize = UtilitiesPortal.factSize
        
        message.position = CGPoint(x: 0, y: 0)
        message.zPosition = 0.9
        message.fontName = UtilitiesPortal.navLabelFont
        message.fontSize = UtilitiesPortal.factSize
        
        
        timeOutMessage = SKShapeNode()
        timeOutMessage.path = UIBezierPath(roundedRect: CGRect(x: -UtilitiesPortal.screenWidth/5, y: -UtilitiesPortal.screenHeight/5, width: UtilitiesPortal.screenWidth/2.5, height: UtilitiesPortal.screenHeight/2.5), cornerRadius: 5).CGPath
        timeOutMessage.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        timeOutMessage.fillColor = SKColor.blackColor()
        
        timeOutMessage.alpha = 0.9
        timeOutMessage.zPosition = 0.9
        
        retryBtn.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        retryBtn.color = SKColor.grayColor()
        retryBtn.name = UtilitiesPortal.timeOutRetryName
        retryBtn.texture = SKTexture(image: UIImage(named: "replay")!)
        retryBtn.position = CGPoint(x: (0 - retryBtn.size.width), y: (0 - retryBtn.size.height)*1.2)
        retryBtn.zPosition = 0.9
        
        backHomebtn.size = retryBtn.size
        backHomebtn.color = retryBtn.color
        backHomebtn.name = UtilitiesPortal.timeOutHomeName
        backHomebtn.texture = SKTexture(image: UIImage(named: "home")!)
        backHomebtn.position = CGPoint(x: retryBtn.size.width, y: (0 - retryBtn.size.height)*1.2)
        backHomebtn.zPosition = 0.9
        
        timeOutMessage.addChild(retryBtn)
        timeOutMessage.addChild(backHomebtn)
        timeOutMessage.addChild(message)
        timeOutMessage.addChild(title)
        addChild(backgroundNode)
        addChild(timeOutMessage)
    }
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /*let touch = touches.first
        if chosenAnswer == nil {
            return
        }
        
        chosenAnswer.position = touch!.locationInNode(self)*/
        //print("+++++++++++++++++++++++++")
        
        /*let xPostion = chosenAnswer.position.x
         let yPostion = chosenAnswer.position.y
         let x = xPostion / UtilitiesPortal.screenWidth
         let y = yPostion / UtilitiesPortal.screenHeight
         print("x=\(x)")
         print("y=\(y)")*/
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch!.previousLocationInNode(self)
        if super.touchesBeganSuper(touches, withEvent: event) {
            return
        }
        
        // Home button selected
        let location = touch!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        
        // Info selected
        if node.name == UtilitiesPortal.infoButonName {
            if state == UtilitiesPortal.stateAnswer {
                setupInfo()
                previousState = state
                state = UtilitiesPortal.stateInfo
                infoOverlay.hidden = false
                return
            }
            else {
                setupInfoResult()
                previousState = state
                state = UtilitiesPortal.stateInfoResult
                infoOverlayResult.hidden = false
                return
            }
        }
        
        if node.name == UtilitiesPortal.timeOutHomeName {
            backHomePage()
        }
        
        if node.name == UtilitiesPortal.timeOutRetryName {
            retryLvl()
        }
        if state == UtilitiesPortal.stateAnswer {
            // Labels selected
            for x in 0...answers.count-1 {
                if CGRectContainsPoint(answers[x].frame, point) {
                    if answers[x].hidden == false {
                        chosenAnswer = x
                        answers[x].texture = SKTexture(image: UIImage(named: "\(answers[chosenAnswer].value)-selected")!)
                        state = UtilitiesPortal.stateReview
                    }
                    return
                }
            }
            return
        }
        else if state == UtilitiesPortal.stateReview {
            for x in 0...answers.count-1 {
                if CGRectContainsPoint(answers[x].frame, point) {
                    if x == chosenAnswer {
                        answers[x].texture = SKTexture(image: UIImage(named: "\(answers[x].value)")!)
                    }
                    else if answers[x].hidden == false {
                        if compareTiles(x, b: chosenAnswer) {
                            // Play sound when two tiles are matched only
                            if DataHandler.getSettings().getEffect {
                                audioPlayer.play()
                            }
                            
                            answers[chosenAnswer].hidden = true
                            answers[x].hidden = true
                            plus = true
                        }
                        else {
                            answers[chosenAnswer].texture =
                                SKTexture(image: UIImage(named: "\(answers[chosenAnswer].value)")!)
                        }
                    }
                    else {
                        return
                    }
                    state = UtilitiesPortal.stateAnswer
                    chosenAnswer = UtilitiesPortal.levelTwoNil
                    return
                }
            }
            return
        }
    }
    
    func compareTiles(a: Int, b: Int) -> Bool {
        print("Compare: \(answers[a].value) and \(answers[b].value)")
        let string: String = answers[a].value
        let removeColor = string.startIndex.advancedBy(0)..<string.endIndex.advancedBy(-2)
        
        let stringA: String = answers[a].value.substringWithRange(removeColor)
        let rangeA = stringA.startIndex.advancedBy(0)..<stringA.endIndex.advancedBy(-1)
        let prefixA = stringA.substringWithRange(rangeA)
        let postfixA = stringA.characters.last!
        
        let stringB: String = answers[b].value.substringWithRange(removeColor)
        let rangeB = stringB.startIndex.advancedBy(0)..<stringB.endIndex.advancedBy(-1)
        let prefixB = stringB.substringWithRange(rangeB)
        let postfixB = stringB.characters.last!
        if prefixA == prefixB && postfixA != postfixB {
            print("Result: true")
            return true
        }
        print("Result: false")
        return false
    }
    
    func checkResult() -> Bool {
        for x in 0...answers.count-1 {
            if answers[x].hidden == false {
                return false
            }
        }
        return true
    }
    
    // retry level 2
    func retryLvl() {
        self.removeAllActions()
        self.removeAllChildren()
        UtilitiesPortal.score = 0
        let secondScene = LevelTwoScene(size: self.size)
        secondScene.userData = NSMutableDictionary()
        let mode = self.userData?.valueForKey("gameMode")
        secondScene.userData?.setValue(mode, forKey: "gameMode")
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
        //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    //MARK------- Timer
    func setupTimer() {
        LIMITTIME = 100000
        timerClass = TimeControl(limitTime: LIMITTIME, tag: true)
        timerClass.startTimer()
        
       // timeNsNode = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LevelTwoScene.getTime(_:)), userInfo: nil, repeats: true)
        timeNsNode = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LevelTwoScene.getTime(_:)), userInfo: nil, repeats: true)
    }
    
    @objc func getTime(timer:NSTimer) {
        timeNode.text = "Time:\(timerClass.timeLabel)"
        /*
        if timerClass.timeLabel >= LIMITTIME-4 && timerClass.timeLabel < LIMITTIME{
            timeNode.fontColor = SKColor.redColor()
            let zoom = SKAction.scaleTo(2, duration: 0.5)
            let fade = SKAction.fadeAlphaTo(0.1, duration: 0.5)
            let zoom1 = SKAction.scaleTo(1, duration: 0.1)
            let fade1 = SKAction.fadeAlphaTo(1, duration: 0.1)
            let action = SKAction.sequence([zoom,fade,fade1,zoom1])
            timeNode.runAction(action)
        }
        */
        if checkResult() {
            UtilitiesPortal.score = timerClass.timeLabel
            timeOut()
            toResultScene()
        }
        /*
        if timerClass.timeLabel >= LIMITTIME {
            timeNode.text = "Time Out!"
            
            //block the game scene
            state = UtilitiesPortal.stateResult
            
            timeOut()
            //alertMessage()
        }
        */
    }
    
    func trialTimer(){
        LIMITTIME = 15
        timerClass = TimeControl(limitTime: LIMITTIME, tag: false)
        timerClass.startTimer()
        
        // timeNsNode = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LevelTwoScene.getTime(_:)), userInfo: nil, repeats: true)
        timeNsNode = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LevelTwoScene.getTime2(_:)), userInfo: nil, repeats: true)
    }
    @objc func getTime2(timer:NSTimer) {
        if plus == true{
            if timerClass.remainSecond != 0{
                timerClass.remainSecond = timerClass.remainSecond + 6
            }
            
            LIMITTIME = timerClass.remainSecond
            timerClass.limitTime = LIMITTIME
            plus = false
        }
        timeNode.text = "Time:\(timerClass.timeLabel)"
        /*
        if timerClass.timeLabel > 5{
        
            timeNode.removeAllActions()
            timeNode.fontSize = UtilitiesPortal.factSize
            timeNode.fontColor = SKColor.whiteColor()
            let zoom1 = SKAction.scaleTo(1, duration: 0.1)
            let fade1 = SKAction.fadeAlphaTo(1, duration: 0.1)
            let action = SKAction.sequence([fade1,zoom1])
            timeNode.runAction(action)
            
        }
        
         if timerClass.timeLabel >= 0 && timerClass.timeLabel <= 4{
         timeNode.fontColor = SKColor.redColor()
         let zoom = SKAction.scaleTo(2, duration: 0.5)
         let fade = SKAction.fadeAlphaTo(0.1, duration: 0.5)
         let zoom1 = SKAction.scaleTo(1, duration: 0.1)
         let fade1 = SKAction.fadeAlphaTo(1, duration: 0.1)
         let action = SKAction.sequence([zoom,fade,fade1,zoom1])
         timeNode.runAction(action)
         }
         */
        if checkResult() {
            UtilitiesPortal.score = timerClass.timeLabel
            timeOut()
            toResultScene()
        }
        
        if timerClass.timeLabel <= 0 {
            timeNode.text = "Time Out!"
         
            //block the game scene
            state = UtilitiesPortal.stateResult
            timeOut()
            // go to resultpage or retr
            addTimeOutMessage()
        }
        
    }

    func beatTimer(){
        LIMITTIME = 300
        timerClass = TimeControl(limitTime: LIMITTIME, tag: false)
        timerClass.startTimer()
        
        // timeNsNode = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LevelTwoScene.getTime(_:)), userInfo: nil, repeats: true)
        timeNsNode = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LevelTwoScene.getTime3(_:)), userInfo: nil, repeats: true)
        
    }
    @objc func getTime3(timer:NSTimer) {
        timeNode.text = "Time:\(timerClass.timeLabel)"
        /*
         if timerClass.timeLabel >= 1 && timerClass.timeLabel < 5{
         timeNode.fontColor = SKColor.redColor()
         let zoom = SKAction.scaleTo(2, duration: 0.5)
         let fade = SKAction.fadeAlphaTo(0.1, duration: 0.5)
         let zoom1 = SKAction.scaleTo(1, duration: 0.1)
         let fade1 = SKAction.fadeAlphaTo(1, duration: 0.1)
         let action = SKAction.sequence([zoom,fade,fade1,zoom1])
         timeNode.runAction(action)
         }
        */
        if checkResult() {
            UtilitiesPortal.score = timerClass.timeLabel
            timeOut()
            toResultScene()
        }
        
         if timerClass.timeLabel <= 0 {
         timeNode.text = "Time Out!"
         
         //block the game scene
         state = UtilitiesPortal.stateResult
         
         timeOut()
         addTimeOutMessage()
        }

    }

    
    func alertMessage(){
        let controller = self.view?.window?.rootViewController as! GameViewController
        let alert = UIAlertController(title: "Time Out!", message: "Try Again or Back Home?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .Destructive, handler: {action in
            let secondScene = LevelTwoScene(size: self.size)
            //let secondScene = ResultPage(size: self.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0)
            //let transition = SKTransition.moveInWithDirection(.Down, duration: 1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            
        }))
        alert.addAction(UIAlertAction(title: "Home", style: .Destructive, handler: {action in
            self.backHomePage()
            
        }))
        controller.presentViewController(alert, animated: true, completion: nil)
    }
    
    func timeOut() {
        timerClass.stopTimer()
        timeNsNode.invalidate()
        timeNsNode = nil
    }
    
    func toResultScene() {
        cleanScene()
        let secondScene = ResultPage2(size: self.size)
        secondScene.userData = NSMutableDictionary()
        let mode = self.userData?.valueForKey("gameMode")
        secondScene.userData?.setValue(mode, forKey: "gameMode")
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    override func willMoveFromView(view: SKView) {
        cleanScene()
    }
    
    override func cleanScene() {
        for node in answers {
            node.texture = nil
        }
        answers.removeAll()
        if let s = self.view?.scene {
            NSNotificationCenter.defaultCenter().removeObserver(self)
            self.enumerateChildNodesWithName("//") { node, _ in
                node.removeAllActions()
                node.removeAllChildren()
                node.removeFromParent()
            }
            s.removeAllActions()
            s.removeAllChildren()
            s.removeFromParent()
        }
        print("Clean Lvl 2 Scene")
    }
}
