//
//  LevelOneScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/8/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import AVFoundation
import SpriteKit

class LevelOneScene: LevelScene {
    var answers: [CustomSKSpriteNode] = []
    var lvlOneQuestion: LevelOneQuestion!
    var listOfQuestions:[LevelOneQuestion] = []
    var chosenAnswer: CustomSKSpriteNode!
    var resultImage: SKSpriteNode!
    //var timerClass:TimeControl!
    
    override func didMoveToView(view: SKView) {
        cleanScene()
        setupScene()
    }
    
    override func setupScene() {
        super.setupScene()
        
        if DataHandler.getLevelOneScore() == UtilitiesPortal.firstTime {
            previousState = UtilitiesPortal.stateAnswer
            state = UtilitiesPortal.stateInfo
            //DataHandler.saveLevelOneScore()
        }
        else {
            state = UtilitiesPortal.stateAnswer
        }
        
        lvlOneQuestion = LevelOneModel.currentQuestion
        
        // Result page
        if lvlOneQuestion.positions.count == 0 {
            cleanScene()
            let secondScene = ResultPage(size: self.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            return
        }
        //state = UtilitiesPortal.stateAnswer
        setupItems()
        setupImage()
        setupTargets()
        setupDragLabel()
        setupFactLabel()
        setupInfo()
        setupInfoResult()
    }
    
    override func setupItems() {
        super.setupItems()
        // Molecule name label
        molecule = SKLabelNode(fontNamed: UtilitiesPortal.navLabelFont)
        molecule.text = "\(lvlOneQuestion.itemName)"
        molecule.fontSize = UtilitiesPortal.factSize
        molecule.zPosition = 0.1
        molecule.fontColor = SKColor.whiteColor()
        /*
        if DataHandler.getSettings().getRightHand {
            molecule.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
            molecule.position = CGPointMake(UtilitiesPortal.screenWidth * 0.01, UtilitiesPortal.screenHeight * 0.8)
        }
        else {
            molecule.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
            molecule.position = CGPointMake(UtilitiesPortal.screenWidth * 0.99, UtilitiesPortal.screenHeight * 0.8)
        }
         */
        molecule.position = CGPoint(x:UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.borderSize/4)
        self.addChild(molecule)
    }
    
    override func setupImage() {
        // Image
        let image = SKSpriteNode(imageNamed: lvlOneQuestion.imageName)
        image.zPosition = 0.1
        image.alpha = 0.9
        let current = CGPoint(x:UtilitiesPortal.borderSize+UtilitiesPortal.imageWidth/2,
                       y:UtilitiesPortal.screenHeight/2)
        image.position = PositionHandler.convertTargetPoint(current)
        let currentSize = image.size
        let x = UtilitiesPortal.imageWidth/currentSize.width
        let y = UtilitiesPortal.imageHeight/currentSize.height
        if x < y {
            image.setScale(x)
        }
        else {
            image.setScale(y)
        }
        //image.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
        addChild(image)
    }
    
    override func setupDragLabel() {
        for count in 0...UtilitiesPortal.levelOneAnswers.count-1 {
            let answer = CustomSKSpriteNode(imageNamed: "\(UtilitiesPortal.levelOneAnswers[count])-border")
            answer.name = UtilitiesPortal.levelOneAnswers[count]
            answer.value = UtilitiesPortal.levelOneAnswers[count]
            answer.zPosition = 0.3
            answer.alpha = 0.9
            answer.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                 height: UtilitiesPortal.screenHeight*0.1)
            
            if count < 5 {
                let x = CGPoint(x:UtilitiesPortal.screenWidth*0.75,
                                y:UtilitiesPortal.screenHeight*(0.7-0.12*CGFloat(count)))
                answer.position = PositionHandler.convertLevelOneLabelPoint(x);
            }
            else if count < 10 {
                let x = CGPoint(x:UtilitiesPortal.screenWidth*0.90,
                                y:UtilitiesPortal.screenHeight*(0.7-0.12*CGFloat(count-5)))
                answer.position = PositionHandler.convertLevelOneLabelPoint(x);
            }
            
            addChild(answer)
            answers.append(answer)
            currentAnswerPostions.append(answer.position)
        }
    }
    
    override func setupTargets() {
        for x in 0...lvlOneQuestion.positions.count-1 {
            positions.append(lvlOneQuestion.positions[x])
        }
        UtilitiesPortal.totalQuestions += positions.count
        
    
        
        for count in 0...positions.count-1 {
            let sprite = CustomSKSpriteNode()
            sprite.color = UIColor.blueColor()
            sprite.alpha = 0
            sprite.texture = SKTexture(imageNamed: "\(count)")
            sprite.name = "question\(count)"
            
           
            sprite.size = CGSizeMake(UtilitiesPortal.screenWidth*0.25, UtilitiesPortal.screenHeight*0.15)
            sprite.zPosition = 0.2
            let x = CGPoint(x:UtilitiesPortal.screenWidth * positions[count].x,
                            y:UtilitiesPortal.screenHeight * positions[count].y)
            sprite.position = PositionHandler.convertTargetPoint(x)
            addChild(sprite)
            questions.append(sprite)
            
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
    override func setupFactLabel() {
        let randomIndex = Int(arc4random_uniform(UInt32(lvlOneQuestion.facts.count)))
        let fact = lvlOneQuestion.facts[randomIndex]
        let index = fact.startIndex.advancedBy(19)
        let shortenFact = fact.substringToIndex(index)
        
        factLabel = SKLabelNode(fontNamed: UtilitiesPortal.navLabelFont)
        factLabel.name = UtilitiesPortal.factLabelName
        factLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        factLabel.fontSize = UtilitiesPortal.factSize
        factLabel.text = "Did you know: " + shortenFact + "...(more)"
        factLabel.hidden = true
        factLabel.zPosition = 0.3
        factLabel.position = CGPoint(x: UtilitiesPortal.screenWidth*0.20, y: UtilitiesPortal.borderSize/4)
        //addChild(factLabel)
        
        factOverlayText = SKMultilineLabel(text: fact, labelWidth: UtilitiesPortal.screenWidth,
                                           pos: CGPoint(x: 0, y: UtilitiesPortal.screenHeight/8),fontName: UtilitiesPortal.navLabelFont,
                                           fontSize: UtilitiesPortal.navLabelSize,
                                           leading: Int(UtilitiesPortal.navLabelSize))
        
        // If the fact is shorter than 3 lines, reduces the width of the label by 50
        if factOverlayText.lineCount < 3{
            
            factOverlayText.labelWidth -= 50
        }
        
        factOverlayText.name = UtilitiesPortal.factMultiLine
        //factOverlayText.alignment = .Left
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
    override func setupInfo() {
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
        info01.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.38,
                                  y: UtilitiesPortal.screenHeight * 0.14)
        
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
    
    // Info layout
    override func setupInfoResult() {
        let arrow01 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[0])
        arrow01.zPosition = 0.9
        arrow01.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*2)
        arrow01.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.30,
                                   y: UtilitiesPortal.screenHeight * -0.3)
        
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
        arrow03.runAction(repeatAction1)*/
        
        let arrow04 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[6])
        arrow04.zPosition = 0.9
        arrow04.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*2)
        arrow04.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.40,
                                   y: UtilitiesPortal.screenHeight * -0.3)
        /*let action2_1 = SKAction.fadeInWithDuration(0.6)
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
        
        let info02 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[7])
        info02.zPosition = 1
        info02.size = CGSize(width: UtilitiesPortal.screenWidth*0.25,
                             height: UtilitiesPortal.screenHeight*0.15)
        info02.position = CGPoint(x: UtilitiesPortal.screenWidth*0.40,
                                  y: UtilitiesPortal.screenHeight * -0.1)
        
        let info03 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[5])
        info03.zPosition = 1
        info03.size = CGSize(width: UtilitiesPortal.screenWidth*0.25,
                             height: UtilitiesPortal.screenHeight*0.15)
        info03.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.20,
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
        
        infoOverlayResult = SKSpriteNode()
        infoOverlayResult.name = UtilitiesPortal.factOverlayName
        infoOverlayResult.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        infoOverlayResult.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        infoOverlayResult.color = SKColor.blackColor()
        infoOverlayResult.alpha = 0.7
        infoOverlayResult.zPosition = 0.8
        
        if state == UtilitiesPortal.stateInfoResult {
            infoOverlayResult.hidden = false
        }
        else {
            infoOverlayResult.hidden = true
        }
        
        infoOverlayResult.addChild(arrow01)
        infoOverlayResult.addChild(arrow02)
        //infoOverlay.addChild(arrow03)
        infoOverlayResult.addChild(arrow04)
        infoOverlayResult.addChild(arrow05)
        infoOverlayResult.addChild(arrow06)
        
        infoOverlayResult.addChild(info01)
        infoOverlayResult.addChild(info02)
        infoOverlayResult.addChild(info03)
        infoOverlayResult.addChild(info04)
        infoOverlayResult.addChild(info05)
        
        addChild(infoOverlayResult)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        if chosenAnswer == nil {
            return
        }
        
        chosenAnswer.position = touch!.locationInNode(self)
        /*
        print("+++++++++++++++++++++++++")
        
        let xPostion = chosenAnswer.position.x
        let yPostion = chosenAnswer.position.y
        let x = xPostion / UtilitiesPortal.screenWidth
        let y = yPostion / UtilitiesPortal.screenHeight
        print("x=\(x)")
        print("y=\(y)")
         */
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(chosenAnswer == nil) {
            return
        }
        
        for x in 0...questions.count-1 {
            if CGRectContainsPoint(questions[x].frame, chosenAnswer.position) {
                answeredQuestions[x].hidden = false
                answeredQuestions[x].texture = SKTexture(image: UIImage(named: chosenAnswer.value)!)
                answeredQuestions[x].value = chosenAnswer.value
                break
            }
        }
        
        chosenAnswer.removeFromParent()
        self.chosenAnswer = nil
        
        if checkResult() {
            tick.texture = SKTexture(image: UIImage(named: "submit-blue")!)
        }
        else {
            tick.texture = SKTexture(image: UIImage(named: "submit-grey")!)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        let point = touch!.previousLocationInNode(self)
        super.touchesBegan(touches, withEvent: event)
        
        if state == UtilitiesPortal.stateAnswer && lvlOneQuestion.positions.count > 0{
            // Labels selected
            for x in 0...answers.count-1 {
                if CGRectContainsPoint(answers[x].frame, point) {
                    // Play sound only when drag labels
                    if DataHandler.getSettings().getEffect {
                        audioPlayer.play()
                    }
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
        
        // Tick button selected
        if node.name == UtilitiesPortal.tickButtonName {
            if state == UtilitiesPortal.stateAnswer && checkResult() {
                displayResult()
                if DataHandler.getLevelOneScore() == UtilitiesPortal.firstTime {
                    infoOverlayResult.hidden = false
                    previousState = UtilitiesPortal.stateResult
                    state = UtilitiesPortal.stateInfoResult
                    DataHandler.saveLevelOneScore()
                }
                return
            }
            if state == UtilitiesPortal.stateResult || state == UtilitiesPortal.stateReview {
                previousState = state
                state = UtilitiesPortal.stateFact
                factOverlay.hidden = false
            }
            return
        }
        
        // Show button selected
        
        if node.name == UtilitiesPortal.showButtonName {
            if state == UtilitiesPortal.stateResult {
                displayAnswers(true)
                resultImage = SKSpriteNode(imageNamed: lvlOneQuestion.imageSol)
                resultImage.zPosition = 0.5
                resultImage.alpha = 1
                let current = CGPoint(x:UtilitiesPortal.borderSize + UtilitiesPortal.imageWidth/2,
                                y:UtilitiesPortal.screenHeight/2)
                resultImage.position = PositionHandler.convertTargetPoint(current)
                let currentSize = resultImage.size
                let x = UtilitiesPortal.imageWidth/currentSize.width
                let y = UtilitiesPortal.imageHeight/currentSize.height
                if x < y {
                    resultImage.setScale(x)
                }
                else {
                    resultImage.setScale(y)
                }
                //resultImage.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
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
            for x in 0...lvlOneQuestion.solutions.count-1 {
                if answeredQuestions[x].value != UtilitiesPortal.emptyString {
                    if answeredQuestions[x].value == lvlOneQuestion.solutions[x] {
                        answeredQuestions[x].texture = SKTexture(image: UIImage(named:
                            "\(answeredQuestions[x].value)-green")!)
                        UtilitiesPortal.score = UtilitiesPortal.score + 1
                    }
                    else {
                        answeredQuestions[x].texture = SKTexture(image: UIImage(named:
                            "\(answeredQuestions[x].value)-red")!)
                    }
                }
            }
        }
        factLabel.hidden = false
        score.text = "\(UtilitiesPortal.scoreText) \(UtilitiesPortal.score)"
        tick.texture = SKTexture(image: UIImage(named: "next")!)
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
    
    /*
    func initRecord(){
        listOfQuestions = LevelOneQuestion.getQuestions()
        for item in 0..<listOfQuestions.count{
            UtilitiesPortal.record.append(item)
        }
    
    }
*/
    //MARK------- Timer
    /*func setupTimer(){
    
        timerClass = TimeControl(limitTime: 180)
        timerClass.startTimer()
        
            timeNsNode = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "getTime:", userInfo: nil, repeats: true)
        
    }
    
    @objc func getTime(timer:NSTimer){
        timeNode.text = "Time:\(timerClass.timeLabel)"
        if timerClass.timeLabel <= 5 && timerClass.timeLabel > 0{
            timeNode.fontColor = SKColor.redColor()
            let zoom = SKAction.scaleTo(2, duration: 0.5)
            let fade = SKAction.fadeAlphaTo(0.1, duration: 0.5)
            let zoom1 = SKAction.scaleTo(1, duration: 0.1)
            let fade1 = SKAction.fadeAlphaTo(1, duration: 0.1)
            let action = SKAction.sequence([zoom,fade,fade1,zoom1])
            timeNode.runAction(action)
        }
        
        if timerClass.timeLabel <= 0{
            timeNode.text = "Time Out!"
            timeOut()
        }
    }*/
    
    func alertMessage() {
    
        let controller = self.view?.window?.rootViewController as! GameViewController
        let alert = UIAlertController(title: "Time Out!", message: "Try Again or Back Home?", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Try again", style: .Destructive, handler: {action in
            self.didMoveToView(self.view!)
            
        }))
        alert.addAction(UIAlertAction(title: "Home", style: .Destructive, handler: {action in
             self.backHomePage()
        }))
        controller.presentViewController(alert, animated: true, completion: nil)
    }
    
    func timeOut(){
        timeNsNode.invalidate()
        timeNsNode = nil
        LevelOneModel.index = 0
        alertMessage()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func willMoveFromView(view: SKView) {
        cleanScene()
    }
    
    override func cleanScene() {
        for node in answers {
            node.texture = nil
        }
        answers.removeAll()
        positions.removeAll()
        for node in questions {
            node.texture = nil
        }
        questions.removeAll()
        for node in answeredQuestions {
            node.texture = nil
        }
        answeredQuestions.removeAll()
        listOfQuestions.removeAll()
        
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
        print("Clean Lvl 1 Scene")
    }
}
