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

class LevelTwoScene: SKScene {
    var answers: [CustomSKSpriteNode] = []
    var chosenAnswer: Int!
    var tick, infoOverlay: SKSpriteNode!
    var homeDialogue: SKShapeNode!
    var score, factLabel, timeNode: SKLabelNode!
    var state, previousState: Int!
    var timerClass:TimeControl!
    var timeNsNode:NSTimer!
    var LIMITTIME :Int!
    var plus = false
    var audioPlayer = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        //This is the template for implementing setting
        switch String(self.userData!.valueForKey("gameMode")!) {
            case "Standard":
                //code goes here
                print("Game mode: Standard!")
                
                setupTimer()
            break
            case "Time Trial":
                //code goes here
                print("Game mode: Time Trial!")
                trialTimer()
            break
            case "Beat the Clock":
                //code goes here
                print("Game mode: Beat the Clock!")
                beatTimer()
            break
            default:
            break
        }
        
        
        //timerClass.pause(true)
        setupScene()
    }
    
    func setupScene() {
        answers.removeAll()
        self.removeAllChildren()
        
        if DataHandler.getLevelTwoScore() == UtilitiesPortal.defaultScore {
            previousState = UtilitiesPortal.stateAnswer
            state = UtilitiesPortal.stateInfo
            DataHandler.saveLevelTwoScore()
        }
        else {
            state = UtilitiesPortal.stateAnswer
        }
        
        if let clickSound = NSBundle.mainBundle().URLForResource("clickSound", withExtension: "wav") {
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: clickSound, fileTypeHint: nil)
                audioPlayer.prepareToPlay()
            }
            catch {
                fatalError("Error loading sound: \(error)")
            }
        }
        
        setupItems()
        setupDragLabel()
        //setupInfo()
        createHomeDialogue()
    }
    
    func setupItems() {
        let levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        levelLabel.zPosition = 0.1
        levelLabel.text = UtilitiesPortal.levelLabelTexts[1]
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
        tick.hidden = true
        tick.zPosition = 0.1
        tick.alpha = 1
        tick.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        tick.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
                                y: UtilitiesPortal.navImgSize/2)
        addChild(tick)
        
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
        score.hidden = true
        score.text = "\(UtilitiesPortal.scoreText) \(UtilitiesPortal.score)"
        score.fontSize = UtilitiesPortal.factSize
        score.position = CGPointMake(UtilitiesPortal.borderSize/4, UtilitiesPortal.borderSize/4)
        self.addChild(score)
        
        
        // Time label
        timeNode = SKLabelNode(fontNamed:UtilitiesPortal.factFont)
        timeNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        timeNode.zPosition = 0.1
        timeNode.text = "Time:\(timerClass.timeLabel)"
        timeNode.fontSize = UtilitiesPortal.factSize
        timeNode.position = CGPointMake(UtilitiesPortal.borderSize/4, UtilitiesPortal.borderSize/4)
        self.addChild(timeNode)
    }
    
    func setupDragLabel() {
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
    func setupInfo() {
        let arrow01 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[0])
        arrow01.zPosition = 0.9
        arrow01.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*2)
        arrow01.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.4,
                                   y: UtilitiesPortal.screenHeight * -0.3)
        
        let arrow02 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[1])
        arrow02.zPosition = 0.9
        arrow02.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*2)
        arrow02.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.4,
                                   y: UtilitiesPortal.screenHeight * 0.3)
        
        let arrow03 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[2])
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
        arrow04.runAction(repeatAction2)
        
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
        info01.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.27,
                                  y: UtilitiesPortal.screenHeight * 0.15)
        
        let info02 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[1])
        info02.zPosition = 1
        info02.size = CGSize(width: UtilitiesPortal.screenWidth*0.25,
                             height: UtilitiesPortal.screenHeight*0.15)
        info02.position = CGPoint(x: UtilitiesPortal.screenWidth*0.05,
                                  y: UtilitiesPortal.screenHeight * -0.2)
        
        let info03 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[2])
        info03.zPosition = 1
        info03.size = CGSize(width: UtilitiesPortal.screenWidth*0.25,
                             height: UtilitiesPortal.screenHeight*0.15)
        info03.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.3,
                                  y: UtilitiesPortal.screenHeight * -0.3)
        
        let info04 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[3])
        info04.zPosition = 1
        info04.size = CGSize(width: UtilitiesPortal.screenWidth*0.25,
                             height: UtilitiesPortal.screenHeight*0.15)
        info04.position = CGPoint(x: UtilitiesPortal.screenWidth * -0.35,
                                  y: UtilitiesPortal.screenHeight * 0.15)
        
        let info05 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[4])
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
        
        infoOverlay.addChild(arrow01)
        infoOverlay.addChild(arrow02)
        infoOverlay.addChild(arrow03)
        infoOverlay.addChild(arrow04)
        infoOverlay.addChild(arrow05)
        infoOverlay.addChild(arrow06)
        
        infoOverlay.addChild(info01)
        infoOverlay.addChild(info02)
        infoOverlay.addChild(info03)
        infoOverlay.addChild(info04)
        infoOverlay.addChild(info05)
        
        addChild(infoOverlay)
    }
    
    
    //Show Home Button Dialogue box
    func createHomeDialogue() {
        let yesBtn = SKSpriteNode()
        let noBtn = SKSpriteNode()
        
        let alertMessage = SKLabelNode(text: "Are you sure you want to quit?")
        alertMessage.position = CGPoint(x: 0, y: 0)
        alertMessage.zPosition = 0.9
        alertMessage.fontName = UtilitiesPortal.navLabelFont
        alertMessage.fontSize = 15
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
        addChild(homeDialogue)
        
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
        if checkResult() {
            tick.hidden = false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if DataHandler.getSettings().getEffect {
            audioPlayer.play()
        }
        
        let touch = touches.first
        let point = touch!.previousLocationInNode(self)
        
        if state == UtilitiesPortal.stateHome {
            let location = touch!.locationInNode(self)
            let nodes = self.nodesAtPoint(location)
            for node in nodes {
                if node.name == UtilitiesPortal.yesButtonName {
                    if timerClass.timeLabel > 0{
                        timeOut()
                        backHomePage()
                        return
                    }
                    else {
                        backHomePage()
                        return
                    }
                    
                }
                else if node.name == UtilitiesPortal.noButtonName {
                    timerClass.pause(false)
                    homeDialogue.hidden = true
                    state = previousState
                    previousState = UtilitiesPortal.stateHome
                    return
                }
            }
            return
        }
        
        if state == UtilitiesPortal.stateInfo {
            infoOverlay.hidden = true
            infoOverlay.removeAllActions()
            infoOverlay.removeAllChildren()
            if timerClass.timeLabel <= LIMITTIME{
                timerClass.pause(false)
            }
            
            state = previousState
            previousState = UtilitiesPortal.stateInfo
            return
        }
        
        // Home button selected
        let location = touch!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if node.name == UtilitiesPortal.homeButtonName {
            homeDialogue.hidden = false
            previousState = state
            state = UtilitiesPortal.stateHome
        }
        
        // Tick button selected
        if node.name == UtilitiesPortal.tickButtonName {
            print("Tick")
            return
        }
        
        // Info selected
        if node.name == UtilitiesPortal.infoButonName {
            previousState = state
            state = UtilitiesPortal.stateInfo
            setupInfo()
            infoOverlay.hidden = false
            return
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
    
    //back to the home page,
    func backHomePage() {
        self.removeAllActions()
        self.removeAllChildren()
        UtilitiesPortal.score = 0
        UtilitiesPortal.totalQuestions = 0
        cleanScene()
        let secondScene = GameScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
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
            toResultSence()
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
        LIMITTIME = 10
        timerClass = TimeControl(limitTime: LIMITTIME, tag: false)
        timerClass.startTimer()
        
        // timeNsNode = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LevelTwoScene.getTime(_:)), userInfo: nil, repeats: true)
        timeNsNode = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LevelTwoScene.getTime2(_:)), userInfo: nil, repeats: true)
    }
    @objc func getTime2(timer:NSTimer) {
        if plus == true{
        
            timerClass.remainSecond = timerClass.remainSecond + 5
            LIMITTIME = timerClass.remainSecond
            timerClass.limitTime = LIMITTIME
            plus = false
        }
        timeNode.text = "Time:\(timerClass.timeLabel)"
        
         if timerClass.timeLabel >= 0 && timerClass.timeLabel <= 4{
         timeNode.fontColor = SKColor.redColor()
         let zoom = SKAction.scaleTo(2, duration: 0.5)
         let fade = SKAction.fadeAlphaTo(0.1, duration: 0.5)
         let zoom1 = SKAction.scaleTo(1, duration: 0.1)
         let fade1 = SKAction.fadeAlphaTo(1, duration: 0.1)
         let action = SKAction.sequence([zoom,fade,fade1,zoom1])
         timeNode.runAction(action)
         }
        
        if checkResult() {
            UtilitiesPortal.score = timerClass.timeLabel
            timeOut()
            toResultSence()
        }
        
         if timerClass.timeLabel <= 0 {
         timeNode.text = "Time Out!"
         
         //block the game scene
         state = UtilitiesPortal.stateResult
         
         timeOut()
         //alertMessage()
         }
        
    }

    func beatTimer(){
        LIMITTIME = 30
        timerClass = TimeControl(limitTime: LIMITTIME, tag: false)
        timerClass.startTimer()
        
        // timeNsNode = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LevelTwoScene.getTime(_:)), userInfo: nil, repeats: true)
        timeNsNode = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(LevelTwoScene.getTime3(_:)), userInfo: nil, repeats: true)
        
    }
    @objc func getTime3(timer:NSTimer) {
        timeNode.text = "Time:\(timerClass.timeLabel)"
        
         if timerClass.timeLabel >= 1 && timerClass.timeLabel < 5{
         timeNode.fontColor = SKColor.redColor()
         let zoom = SKAction.scaleTo(2, duration: 0.5)
         let fade = SKAction.fadeAlphaTo(0.1, duration: 0.5)
         let zoom1 = SKAction.scaleTo(1, duration: 0.1)
         let fade1 = SKAction.fadeAlphaTo(1, duration: 0.1)
         let action = SKAction.sequence([zoom,fade,fade1,zoom1])
         timeNode.runAction(action)
         }
        
        if checkResult() {
            UtilitiesPortal.score = timerClass.timeLabel
            timeOut()
            toResultSence()
        }
        
         if timerClass.timeLabel <= 0 {
         timeNode.text = "Time Out!"
         
         //block the game scene
         state = UtilitiesPortal.stateResult
         
         timeOut()
         //alertMessage()
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
    
    func toResultSence() {
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
        self.removeAllActions()
        self.removeAllChildren()
        print("Remove all nodes Lvl 2 Scene")
    }
    
    func cleanScene() {
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
