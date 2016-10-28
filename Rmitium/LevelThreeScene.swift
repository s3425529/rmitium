//
//  LevelOneScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/8/16.
//  Copyright © 2016 Spencer and Jones. All rights reserved.
//

import AVFoundation
import SpriteKit

class LevelThreeScene: LevelScene {
    var answers: [CustomSKSpriteNode] = []
    var chosenAnswer: CustomSKSpriteNode!
    var timeOutMessage: SKShapeNode!
    var resultImage: SKSpriteNode!
    var lvlThreeQuestion: LevelThreeQuestion!
    var listOfQuestions:[LevelThreeQuestion] = []
    var isFirstTouch: Bool!
    
    override func didMoveToView(view: SKView) {
        cleanScene()
        setupScene()
    }
    
    // A general set up function for declaring elements of a scene
    override func setupScene() {
        isFirstTouch = false
        super.setupScene()
        
        if DataHandler.getLevelThreeScore() == UtilitiesPortal.firstTime {
            previousState = UtilitiesPortal.stateAnswer
            state = UtilitiesPortal.stateInfo
            DataHandler.saveLevelThreeFirstTime()
        }
        else {
            state = UtilitiesPortal.stateAnswer
        }
        
        lvlThreeQuestion = LevelThreeModel.currentQuestion
        // Result page
        if lvlThreeQuestion.positions.count == 0 {
            let secondScene = ResultPage3(size: self.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
            return
        }
        
        setupImage()
        setupItems()
        setupDragLabel()
        setupTargets()
        setupFactLabel()
        setupInfo()
        setupInfoResult()
        UtilitiesPortal.setBgm(UtilitiesPortal.levelThree)
    }
    
    // Molecule name label
    override func setupItems() {
        super.setupItems()
        // Molecule name label
        molecule = SKLabelNode(fontNamed: UtilitiesPortal.navLabelFont)
        molecule.text = "\(lvlThreeQuestion.itemName)"
        molecule.fontSize = UtilitiesPortal.factSize
        molecule.zPosition = 0.1
        molecule.fontColor = SKColor.whiteColor()
        molecule.position = CGPoint(x:UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.borderSize/4)
        self.addChild(molecule)
    }
    
    // Molecule image
    override func setupImage() {
        let image = SKSpriteNode(imageNamed: lvlThreeQuestion.imageName)
        
        image.zPosition = 0.1
        image.alpha = 0.9
        let current = CGPoint(x:UtilitiesPortal.borderSize+UtilitiesPortal.imageWidth/2,
                              y:UtilitiesPortal.screenHeight/2)
        image.position = PositionHandler.convertTargetPointLevelThree(current)
        let currentSize = image.size
        let x = UtilitiesPortal.imageWidth/currentSize.width
        let y = UtilitiesPortal.imageHeight/currentSize.height
        if x < y {
            image.setScale(x)
        }
        else {
            image.setScale(y)
        }
        addChild(image)
        
    }
    
    // Answer tiles - where the tiles are dragged from
    override func setupDragLabel() {
        for count in 0...UtilitiesPortal.levelThreeAnswers.count-1 {
            let answer = CustomSKSpriteNode(imageNamed:
                "\(UtilitiesPortal.levelThreeAnswers[count])-border")
            answer.name = UtilitiesPortal.levelThreeAnswers[count]
            answer.value = UtilitiesPortal.levelThreeAnswers[count]
            answer.zPosition = 0.3
            answer.alpha = 0.9
            answer.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                 height: UtilitiesPortal.screenHeight*0.1)
            let current = CGPoint(x:UtilitiesPortal.screenWidth*0.85,
                                  y:UtilitiesPortal.screenHeight*(0.7-0.12*CGFloat(count)))
            
            answer.position = PositionHandler.convertLevelThreeLabelPoint(current)
            
            addChild(answer)
            answers.append(answer)
            currentAnswerPostions.append(answer.position)
        }
    }
    
    // Setting up the positions where the tiles can be dropped onto the molecule image
    override func setupTargets() {
        switch UIDevice.currentDevice().userInterfaceIdiom {
        case .Pad:
            for x in 0...lvlThreeQuestion.positionsIpad.count-1 {
                positions.append(lvlThreeQuestion.positionsIpad[x])
            }
            break;
        default:
            for x in 0...lvlThreeQuestion.positions.count-1 {
                positions.append(lvlThreeQuestion.positions[x])
            }
            break;
        }
        
        for count in 0...positions.count-1 {
            let sprite = CustomSKSpriteNode()
            //sprite.texture = SKTexture(imageNamed: "\(count+1)")
            sprite.color = UIColor.whiteColor()
            sprite.alpha = 0
            sprite.name = "question\(count)"
            sprite.size = CGSizeMake(UtilitiesPortal.screenWidth*0.25, UtilitiesPortal.screenHeight*0.15)
            //sprite.size = CGSizeMake(UtilitiesPortal.screenWidth*0.6, UtilitiesPortal.screenHeight*0.6)
            sprite.zPosition = 0.2
            let current = CGPoint(x:UtilitiesPortal.screenWidth * positions[count].x,
                                  y:UtilitiesPortal.screenHeight * positions[count].y)
            sprite.position = PositionHandler.convertTargetPointLevelThree(current)
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
    override func setupFactLabel() {
        let randomIndex = Int(arc4random_uniform(UInt32(lvlThreeQuestion.facts.count)))
        let fact = lvlThreeQuestion.facts[randomIndex]
        factLabel = SKLabelNode(fontNamed: UtilitiesPortal.navLabelFont)
        factLabel.name = UtilitiesPortal.factLabelName
        factLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        factLabel.fontSize = UtilitiesPortal.navLabelSize
        factLabel.text = "Did you know:"
        factLabel.zPosition = 0.9
        factLabel.position = CGPoint(x: 0, y: UtilitiesPortal.screenHeight/2 - factLabel.fontSize * 4)
        //addChild(factLabel)
        
        factOverlayText = SKMultilineLabel(text: fact, labelWidth: UtilitiesPortal.screenWidth*0.9,
                                           pos: CGPoint(x: 0, y: UtilitiesPortal.screenHeight/8),fontName: UtilitiesPortal.navLabelFont,
                                           fontSize: UtilitiesPortal.navLabelSize,
                                           leading: Int(UtilitiesPortal.navLabelSize))
        
        factOverlayText.name = UtilitiesPortal.factMultiLine
        //factOverlayText.alignment = .Left
        factOverlayText.zPosition = 1
        
        factOverlay = SKSpriteNode()
        factOverlay.name = UtilitiesPortal.factOverlayName
        factOverlay.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        factOverlay.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        factOverlay.hidden = true
        
        factView = SKSpriteNode()
        factView.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        factView.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        factView.color = SKColor.blackColor()
        factView.alpha = 0.7
        factView.zPosition = 0.8
        factView.hidden = true
        
        factOverlay.addChild(factOverlayText)
        factOverlay.addChild(factLabel)
        addChild(factOverlay)
        addChild(factView)
    }
    
    // Info layout - arrows and text images while the user is completing a question
    override func setupInfoResult() {
        let arrow01 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[0])
        arrow01.zPosition = 0.9
        arrow01.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*2)
        arrow01.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.30,
                                   y: UtilitiesPortal.screenHeight * -0.3)
        
        /*let arrow02 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[1])
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
         arrow03.runAction(repeatAction1)*/
        
        let arrow04 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[6])
        arrow04.zPosition = 0.9
        arrow04.size = CGSize(width: UtilitiesPortal.navImgSize*2,
                              height: UtilitiesPortal.navImgSize*4)
        arrow04.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.40,
                                   y: UtilitiesPortal.screenHeight * -0.20)
        /*let action2_1 = SKAction.fadeInWithDuration(0.6)
         let action2_2 = SKAction.fadeOutWithDuration(0.6)
         let sequence2 = SKAction.sequence([action2_1, action2_2])
         let repeatAction2 = SKAction.repeatActionForever(sequence2)
         arrow04.runAction(repeatAction2)*/
        
        /*let arrow05 = SKSpriteNode(imageNamed: UtilitiesPortal.infoArrowNames[4])
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
         y: UtilitiesPortal.screenHeight * -0.30)*/
        
        /*let info01 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[0])
         info01.zPosition = 1
         info01.size = CGSize(width: UtilitiesPortal.screenWidth*0.25,
         height: UtilitiesPortal.screenHeight*0.15)
         info01.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.38,
         y: UtilitiesPortal.screenHeight * 0.14)*/
        
        let info02 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[7])
        info02.zPosition = 1
        info02.size = CGSize(width: UtilitiesPortal.screenWidth*0.25,
                             height: UtilitiesPortal.screenHeight*0.15)
        info02.position = CGPoint(x: UtilitiesPortal.screenWidth*0.35,
                                  y: UtilitiesPortal.screenHeight * 0.1)
        
        let info03 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[5])
        info03.zPosition = 1
        info03.size = CGSize(width: UtilitiesPortal.screenWidth*0.25,
                             height: UtilitiesPortal.screenHeight*0.15)
        info03.position = CGPoint(x: UtilitiesPortal.screenWidth * 0.20,
                                  y: UtilitiesPortal.screenHeight * -0.3)
        
        /*let info04 = SKSpriteNode(imageNamed: UtilitiesPortal.infoLabelNames[3])
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
         y: UtilitiesPortal.screenHeight * -0.10)*/
        
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
        //infoOverlayResult.addChild(arrow02)
        //infoOverlay.addChild(arrow03)
        infoOverlayResult.addChild(arrow04)
        //infoOverlayResult.addChild(arrow05)
        //infoOverlayResult.addChild(arrow06)
        
        //infoOverlayResult.addChild(info01)
        infoOverlayResult.addChild(info02)
        infoOverlayResult.addChild(info03)
        //infoOverlayResult.addChild(info04)
        //infoOverlayResult.addChild(info05)
        
        addChild(infoOverlayResult)
    }
    
    // Info layout - after the user has completed the question i.e. on the individual solution page
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
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        if chosenAnswer == nil {
            return
        }
        // Move the drag label to the touch location
        chosenAnswer.position = touch!.locationInNode(self)
        
        /*print("+++++++++++++++++++++++++")
        
        let xPostion = chosenAnswer.position.x
        let yPostion = chosenAnswer.position.y
        let x = xPostion / UtilitiesPortal.screenWidth
        let y = yPostion / UtilitiesPortal.screenHeight
        print("x=\(x)")
        print("y=\(y)")*/
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Return if there is no dragged label
        if(chosenAnswer == nil) {
            return
        }
        
        // Change the postions based on dragged label
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
        
        // Check if all answers are filled then enable submit button
        if checkResult() {
            tick.texture = SKTexture(image: UIImage(named: "submit-blue")!)
        }
        else {
            tick.texture = SKTexture(image: UIImage(named: "submit-grey")!)
        }
        isFirstTouch = false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !isFirstTouch {
            let touch = touches.first
            let point = touch!.previousLocationInNode(self)
            if super.touchesBeganSuper(touches, withEvent: event) {
                return
            }
            
            if state == UtilitiesPortal.stateAnswer {
                // Labels selected
                for x in 0...answers.count-1 {
                    if CGRectContainsPoint(answers[x].frame, point) {
                        // Play sound only when drag labels
                        if DataHandler.getSettings().getEffect {
                            audioPlayer.play()
                        }
                        
                        // Create drag label based on selected label
                        chosenAnswer = CustomSKSpriteNode(imageNamed: answers[x].name!)
                        chosenAnswer.value = answers[x].name!
                        chosenAnswer.zPosition = 0.4
                        chosenAnswer.alpha = 0.9
                        chosenAnswer.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                                   height: UtilitiesPortal.screenHeight*0.1)
                        chosenAnswer.zPosition = 1
                        chosenAnswer.position = answers[x].position
                        addChild(chosenAnswer)
                        isFirstTouch = true
                        return
                    }
                }
                
                // Targets node selected
                for x in 0...questions.count-1 {
                    if CGRectContainsPoint(questions[x].frame, point) {
                        // Empty the target location if it has answer
                        if answeredQuestions[x].hidden {
                            return
                        }
                        answeredQuestions[x].hidden = true
                        
                        // Create a drag label based on the the selected target node
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
            
            // Arrow button selected
            if node.name == UtilitiesPortal.tickButtonName {
                // Display result
                if state == UtilitiesPortal.stateAnswer && checkResult() {
                    displayResult()
                    // Display first time info overlay result
                    if DataHandler.getLevelThreeScore() == UtilitiesPortal.firstResult {
                        infoOverlayResult.hidden = false
                        previousState = UtilitiesPortal.stateResult
                        state = UtilitiesPortal.stateInfoResult
                        DataHandler.saveLevelThreeFirstResult()
                    }
                    return
                }
                
                // Hide fact overlay
                if state == UtilitiesPortal.stateResult || state == UtilitiesPortal.stateReview {
                    previousState = state
                    state = UtilitiesPortal.stateFact
                    factOverlay.hidden = false
                    factView.hidden = false
                }
                return
            }
            
            // Go to next scene after fact state
            if state == UtilitiesPortal.stateFact {
                setupScene()
                return
            }
            
            // Show button selected
            if node.name == UtilitiesPortal.showButtonName {
                // Display result image
                if state == UtilitiesPortal.stateResult {
                    displayAnswers(true)
                    resultImage = SKSpriteNode(imageNamed: lvlThreeQuestion.imageSol)
                    resultImage.zPosition = 0.5
                    resultImage.alpha = 1
                    let current = CGPoint(x:UtilitiesPortal.borderSize + UtilitiesPortal.imageWidth/2,
                                          y:UtilitiesPortal.screenHeight/2 )
                    resultImage.position = PositionHandler.convertTargetPointLevelThree(current)
                    
                    // Resize to keep normal ratio
                    let currentSize = resultImage.size
                    let x = UtilitiesPortal.imageWidth/currentSize.width
                    let y = UtilitiesPortal.imageHeight/currentSize.height
                    if x < y {
                        resultImage.setScale(x)
                    }
                    else {
                        resultImage.setScale(y)
                    }
                    addChild(resultImage)
                    state = UtilitiesPortal.stateReview
                    return
                }
                // Hide result image
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
        }
    }
    
    func checkResult() -> Bool {
        // Check if all questions are answered
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
        // Change color of result labels
        if state == UtilitiesPortal.stateAnswer {
            for x in 0...lvlThreeQuestion.solutions.count-1 {
                if answeredQuestions[x].value != UtilitiesPortal.emptyString {
                    if answeredQuestions[x].value == lvlThreeQuestion.solutions[x] {
                        answeredQuestions[x].texture = SKTexture(image: UIImage(named: "\(answeredQuestions[x].value)-green")!)
                        UtilitiesPortal.score = UtilitiesPortal.score + 1
                    }
                    else {
                        answeredQuestions[x].texture = SKTexture(image: UIImage(named: "\(answeredQuestions[x].value)-red")!)
                    }
                }
            }
        }
        factLabel.hidden = false
        // Change score text and tick button to next button
        score.text = "\(UtilitiesPortal.scoreText) \(UtilitiesPortal.score)"
        tick.texture = SKTexture(image: UIImage(named: "next")!)
        show.hidden = false
        state = UtilitiesPortal.stateResult
    }
    
    // Display or hide all answered questions
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
        print("Clean Lvl 3 Scene")
    }
}
