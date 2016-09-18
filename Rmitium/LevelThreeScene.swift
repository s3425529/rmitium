//
//  LevelOneScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/8/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import SpriteKit

class LevelThreeScene: SKScene {
    var answers: [CustomSKSpriteNode] = []
    var questions: [CustomSKSpriteNode] = []
    var answeredQuestions: [CustomSKSpriteNode] = []
    var positions = [Position]()
    var currentAnswerPostions: [CGPoint] = []
    var chosenAnswer: CustomSKSpriteNode!
    var resultImage, infoOverlay, factOverlay, homeDialogue: SKSpriteNode!
    var factOverlayText: SKMultilineLabel!
    var show, tick, redo, share, back: SKSpriteNode!
    var score, factLabel, itemName: SKLabelNode!
    //var questionId = 0
    var lvlThreeQuestion: LevelThreeQuestion!
    var state, previousState: Int!
    var listOfQuestions:[LevelThreeQuestion] = []
    
    
    override func didMoveToView(view: SKView) {
        //initRecord()
        setupScene()
    }
    
    func setupScene() {
        
        self.removeAllChildren()
        positions.removeAll()
        questions.removeAll()
        answeredQuestions.removeAll()
        
        lvlThreeQuestion = LevelThreeModel.currentQuestion
        // Result page
        if lvlThreeQuestion.positions.count == 0 {
            let secondScene = ResultPage3(size: self.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            return
        }
        
        state = UtilitiesPortal.stateAnswer
        
        setupImage()
        
        setupItems()
        
        setupDragLabel()
        setupTargets()
        setupFactLabel()
        setupInfo()
        createHomeDialogue()
        
    }
    func setupItems() {
        let levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        levelLabel.zPosition = 0.1
        levelLabel.text = UtilitiesPortal.levelLabelTexts[2]
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
        tick = SKSpriteNode(imageNamed: "tick-grey")
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
        let info = SKSpriteNode(imageNamed: "help2")
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
        
        // ItemName label
        
        itemName = SKLabelNode(fontNamed:"Zapfino")
        itemName.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        itemName.zPosition = 0.1
        itemName.fontColor = SKColor(colorLiteralRed: 0.7, green: 0.5, blue: 0.9, alpha: 1)
        
        itemName.text = "\(lvlThreeQuestion.itemName)"
        itemName.fontSize = UtilitiesPortal.factSize
        itemName.position = CGPointMake(UtilitiesPortal.screenWidth/3, UtilitiesPortal.borderSize/4)
        self.addChild(itemName)

    }
    func setupImage(){
        // Image
        let image = SKSpriteNode(imageNamed: lvlThreeQuestion.imageName)
        
        image.zPosition = 0.1
        image.alpha = 0.9
        image.position = CGPoint(x:UtilitiesPortal.borderSize+UtilitiesPortal.imageWidth/2,
                                 y:UtilitiesPortal.screenHeight/2 )
        image.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
        addChild(image)
        
    }
    
    func setupDragLabel() {
        for count in 0...UtilitiesPortal.levelThreeAnswers.count-1 {
            let answer = CustomSKSpriteNode(imageNamed:
                "\(UtilitiesPortal.levelThreeAnswers[count])")
            answer.name = UtilitiesPortal.levelThreeAnswers[count]
            answer.value = UtilitiesPortal.levelThreeAnswers[count]
            answer.zPosition = 0.3
            answer.alpha = 0.9
            answer.size = CGSize(width: UtilitiesPortal.screenWidth*0.20,
                                 height: UtilitiesPortal.screenHeight*0.15)
            answer.position = CGPoint(x:UtilitiesPortal.screenWidth*0.85,
                                      y:UtilitiesPortal.screenHeight*(0.8-0.20*CGFloat(count)))
            
            addChild(answer)
            answers.append(answer)
            currentAnswerPostions.append(answer.position)
        }
    }
    
    func setupTargets() {
        for x in 0...lvlThreeQuestion.positions.count-1 {
            positions.append(lvlThreeQuestion.positions[x])
        }
        
        for count in 0...positions.count-1 {
            let sprite = CustomSKSpriteNode()
            sprite.color = UIColor.blueColor()
            sprite.alpha = 0
            //sprite.texture = SKTexture(imageNamed: "\(count+1)")
            sprite.name = "question\(count)"
            sprite.size = CGSizeMake(UtilitiesPortal.screenWidth*0.25, UtilitiesPortal.screenHeight*0.15)
            //sprite.size = CGSizeMake(UtilitiesPortal.screenWidth*0.6, UtilitiesPortal.screenHeight*0.6)
            sprite.zPosition = 0.2
            sprite.position = CGPoint(x:UtilitiesPortal.screenWidth * positions[count].x,
                                      y:UtilitiesPortal.screenHeight * positions[count].y)
            addChild(sprite)
            questions.append(sprite)
            UtilitiesPortal.totalQuestions += 1
            let answeredQuestion = CustomSKSpriteNode(imageNamed: UtilitiesPortal.levelOneAnswers[0])
            answeredQuestion.name = UtilitiesPortal.emptyString
            answeredQuestion.value = UtilitiesPortal.emptyString
            answeredQuestion.zPosition = 0.2
            answeredQuestion.alpha = 1
            answeredQuestion.hidden = true
            answeredQuestion.position = sprite.position
            answeredQuestion.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                           height: UtilitiesPortal.screenHeight*0.1)
            addChild(answeredQuestion)
            answeredQuestions.append(answeredQuestion)
        }
    }
    
    // Adding Fact label
    func setupFactLabel(){
        let randomIndex = Int(arc4random_uniform(UInt32(lvlThreeQuestion.facts.count)))
        let fact = lvlThreeQuestion.facts[randomIndex]
        let index = fact.startIndex.advancedBy(15)
        let shortenFact = fact.substringToIndex(index)
        
        factLabel = SKLabelNode(fontNamed: UtilitiesPortal.navLabelFont)
        factLabel.name = UtilitiesPortal.factLabelName
        factLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        factLabel.fontSize = UtilitiesPortal.factSize
        factLabel.text = "Did you know: " + shortenFact + "...(see more)"
        factLabel.hidden = true
        factLabel.zPosition = 0.3
        factLabel.position = CGPoint(x: UtilitiesPortal.screenWidth*0.20, y: UtilitiesPortal.borderSize/4)
        addChild(factLabel)
        
        factOverlayText = SKMultilineLabel(text: fact, labelWidth: UtilitiesPortal.screenWidth,
                                           pos: CGPoint(x: 0, y: 0),fontName: UtilitiesPortal.navLabelFont,
                                           fontSize: UtilitiesPortal.navLabelSize,
                                           leading: Int(UtilitiesPortal.navLabelSize))
        factOverlayText.name = UtilitiesPortal.factMultiLine
        factOverlayText.zPosition = 1
        
        factOverlay = SKSpriteNode()
        factOverlay.name = UtilitiesPortal.factOverlayName
        factOverlay.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        factOverlay.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        factOverlay.color = SKColor.blackColor()
        factOverlay.alpha = 0.7
        factOverlay.zPosition = 0.9
        factOverlay.hidden = true
        factOverlay.addChild(factOverlayText)
        addChild(factOverlay)
    }
    
    // Info layout
    func setupInfo(){
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
        arrow03.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.22,
                                   y: UtilitiesPortal.screenHeight * -0.1)
        
        let arrow04 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[3])
        arrow04.zPosition = 0.9
        arrow04.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*2)
        arrow04.position = CGPoint(x: UtilitiesPortal.screenWidth * -0.15,
                                   y: UtilitiesPortal.screenHeight * -0.1)
        
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
        infoOverlay.hidden = true
        
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
        homeDialogue = SKSpriteNode()
        homeDialogue.size = CGSize(width: UtilitiesPortal.screenWidth/2.5, height: UtilitiesPortal.screenHeight/2.5)
        homeDialogue.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        homeDialogue.color = SKColor.blackColor()
        homeDialogue.alpha = 0.9
        homeDialogue.zPosition = 0.9
        homeDialogue.hidden = true
        
        yesBtn.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        yesBtn.color = SKColor.grayColor()
        yesBtn.name = UtilitiesPortal.yesButtonName
        yesBtn.texture = SKTexture(imageNamed: "tick-white")
        yesBtn.position = CGPoint(x: (0 - yesBtn.size.width), y: (0 - yesBtn.size.height)*1.5)
        yesBtn.zPosition = 0.9
        
        noBtn.size = yesBtn.size
        noBtn.color = yesBtn.color
        noBtn.name = UtilitiesPortal.noButtonName
        noBtn.texture = SKTexture(imageNamed: "cross-white")
        noBtn.position = CGPoint(x: yesBtn.size.width, y: (0 - yesBtn.size.height)*1.5)
        noBtn.zPosition = 0.9
        
        homeDialogue.addChild(yesBtn)
        homeDialogue.addChild(noBtn)
        homeDialogue.addChild(alertMessage)
        addChild(homeDialogue)

    }

    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        if chosenAnswer == nil {
            return
        }
        
        chosenAnswer.position = touch!.locationInNode(self)
        //print("+++++++++++++++++++++++++")
        
        /*let xPostion = chosenAnswer.position.x
        let yPostion = chosenAnswer.position.y
        let x = xPostion / UtilitiesPortal.screenWidth
        let y = yPostion / UtilitiesPortal.screenHeight
        print("x=\(x)")
        print("y=\(y)")*/
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(chosenAnswer == nil) {
            return
        }
        
        for x in 0...questions.count-1 {
            if CGRectContainsPoint(questions[x].frame, chosenAnswer.position) {
                answeredQuestions[x].hidden = false
                answeredQuestions[x].texture = SKTexture(imageNamed: chosenAnswer.value)
                answeredQuestions[x].value = chosenAnswer.value
                break
            }
        }
        
        chosenAnswer.removeFromParent()
        self.chosenAnswer = nil
        
        if checkResult() {
            tick.texture = SKTexture(imageNamed: "tick-green")
        }
        else {
            tick.texture = SKTexture(imageNamed: "tick-grey")
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch!.previousLocationInNode(self)
        
        if state == UtilitiesPortal.stateHome {
            let location = touch!.locationInNode(self)
            let nodes = self.nodesAtPoint(location)
            for node in nodes {
                if node.name == UtilitiesPortal.yesButtonName {
                    backHomePage()
                    return
                }
                else if node.name == UtilitiesPortal.noButtonName {
                    homeDialogue.hidden = true
                    state = previousState
                    previousState = UtilitiesPortal.stateHome
                    return
                }
            }
            return
        }
        
        if state == UtilitiesPortal.stateFact {
            factOverlay.hidden = true
            state = previousState
            previousState = UtilitiesPortal.stateFact
            return
        }
        
        if state == UtilitiesPortal.stateInfo {
            infoOverlay.hidden = true
            state = previousState
            previousState = UtilitiesPortal.stateInfo
            return
        }
        
        if state == UtilitiesPortal.stateAnswer {
            // Labels selected
            for x in 0...answers.count-1 {
                if CGRectContainsPoint(answers[x].frame, point) {
                    chosenAnswer = CustomSKSpriteNode(imageNamed: answers[x].name!)
                    chosenAnswer.value = answers[x].name!
                    chosenAnswer.zPosition = 0.4
                    chosenAnswer.alpha = 0.9
                    chosenAnswer.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                               height: UtilitiesPortal.screenHeight*0.1)
                    chosenAnswer.zPosition = 1
                    chosenAnswer.position = answers[x].position
                    addChild(chosenAnswer)
                    return
                }
            }
            
            // Targets node selected
            for x in 0...questions.count-1 {
                if CGRectContainsPoint(questions[x].frame, point) {
                    if answeredQuestions[x].hidden {
                        return
                    }
                    answeredQuestions[x].hidden = true
                    
                    chosenAnswer = CustomSKSpriteNode(imageNamed: answeredQuestions[x].value)
                    chosenAnswer.value = answeredQuestions[x].value
                    chosenAnswer.zPosition = 0.4
                    chosenAnswer.alpha = 0.9
                    chosenAnswer.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                               height: UtilitiesPortal.screenHeight*0.1)
                    chosenAnswer.zPosition = 1
                    chosenAnswer.position = questions[x].position
                    addChild(chosenAnswer)
                    
                    answeredQuestions[x].value = UtilitiesPortal.emptyString
                    return
                }
            }
            
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
            if state == UtilitiesPortal.stateAnswer && checkResult() {
                displayResult()
                itemName.hidden = true
                return
            }
             
            if state == UtilitiesPortal.stateResult || state == UtilitiesPortal.stateReview {
                setupScene()
            }
            return
        }
        
        
        
        // Show button selected
        if node.name == UtilitiesPortal.showButtonName {
            if state == UtilitiesPortal.stateResult {
                displayAnswers(true)
                resultImage = SKSpriteNode(imageNamed: lvlThreeQuestion.imageSol)
                resultImage.zPosition = 0.5
                resultImage.alpha = 1
                resultImage.position = CGPoint(x:UtilitiesPortal.borderSize + UtilitiesPortal.imageWidth/2,
                                               y:UtilitiesPortal.screenHeight/2 )
                resultImage.position = CGPoint(x:UtilitiesPortal.borderSize + UtilitiesPortal.imageWidth/2,
                                               y:UtilitiesPortal.screenHeight/2 )
                resultImage.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
                addChild(resultImage)
                state = UtilitiesPortal.stateReview
                return
            }
                
            else if state == UtilitiesPortal.stateReview {
                displayAnswers(false)
                resultImage.removeFromParent()
                self.resultImage = nil
                state = UtilitiesPortal.stateResult
                return
            }
            return
        }
        
        // Info selected
        if node.name == UtilitiesPortal.infoButonName {
            previousState = state
            state = UtilitiesPortal.stateInfo
            infoOverlay.hidden = false
            return
        }
        
        // Fact label selected
        if node.name == UtilitiesPortal.factLabelName {
            previousState = state
            state = UtilitiesPortal.stateFact
            factOverlay.hidden = false
            return
        }
    }
    
    func checkResult() -> Bool {
        if questions.count != 0 {
            for x in 0...questions.count-1 {
                if answeredQuestions[x].value == UtilitiesPortal.emptyString {
                    return false
                }
            }
            return true
        }
        return false
    }
    
    func displayResult() {
        if state == UtilitiesPortal.stateAnswer {
            for x in 0...lvlThreeQuestion.solutions.count-1 {
                if answeredQuestions[x].value != UtilitiesPortal.emptyString {
                    if answeredQuestions[x].value == lvlThreeQuestion.solutions[x] {
                        answeredQuestions[x].texture = SKTexture(imageNamed:
                            "\(answeredQuestions[x].value)-green")
                        UtilitiesPortal.score = UtilitiesPortal.score + 1
                    }
                    else {
                        answeredQuestions[x].texture = SKTexture(imageNamed:
                            "\(answeredQuestions[x].value)-red")
                    }
                }
            }
        }
        factLabel.hidden = false
        score.text = "\(UtilitiesPortal.scoreText) \(UtilitiesPortal.score)"
        
        tick.texture = SKTexture(imageNamed: "next")
        
        show.hidden = false
        
        state = UtilitiesPortal.stateResult
    }
    
    func displayAnswers(value: Bool) {
        if value {
            for x in 0...questions.count-1 {
                questions[x].hidden = true
                answeredQuestions[x].hidden = true
            }
        }
        else {
            for x in 0...questions.count-1 {
                questions[x].hidden = false
                answeredQuestions[x].hidden = false
            }
        }
    }
    
    //back to the home page,
    func backHomePage(){
        UtilitiesPortal.totalQuestions = 0
        UtilitiesPortal.score = 0
        cleanScene()
        let secondScene = GameScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    /*func initRecord(){
        listOfQuestions = LevelThreeQuestion.getQuestions()
        for item in 0..<listOfQuestions.count{
            UtilitiesPortal.record.append(item)
        }
        
    }*/
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func willMoveFromView(view: SKView) {
        self.removeAllActions()
        self.removeAllChildren()
        print("Remove all nodes Lvl 3 Scene")
    }
    
    func cleanScene() {
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
        print("Clean Lvl 3 Scene")
    }
}
