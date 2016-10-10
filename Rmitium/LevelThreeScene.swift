//
//  LevelOneScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/8/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import AVFoundation
import SpriteKit

class LevelThreeScene: SKScene {
    var answers: [CustomSKSpriteNode] = []
    var questions: [CustomSKSpriteNode] = []
    var answeredQuestions: [CustomSKSpriteNode] = []
    var positions = [Position]()
    var currentAnswerPostions: [CGPoint] = []
    var chosenAnswer: CustomSKSpriteNode!
    var resultImage, infoOverlay, infoOverlayResult, factOverlay, homeView : SKSpriteNode!
    var homeDialogue: SKShapeNode!
    var factOverlayText: SKMultilineLabel!
    var show, tick, redo, share, back: SKSpriteNode!
    var score, factLabel, molecule: SKLabelNode!
    //var questionId = 0
    var lvlThreeQuestion: LevelThreeQuestion!
    var state, previousState: Int!
    var listOfQuestions:[LevelThreeQuestion] = []
    var audioPlayer = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        //initRecord()
        setupScene()
    }
    
    func setupScene() {
        cleanScene()
        
        PositionHandler.setRightHand()
        
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
        
        if let clickSound = NSBundle.mainBundle().URLForResource("clickSound", withExtension: "wav") {
            do {
                try audioPlayer = AVAudioPlayer(contentsOfURL: clickSound, fileTypeHint: nil)
                audioPlayer.prepareToPlay()
            }
            catch {
                fatalError("Error loading sound: \(error)")
            }
        }
        
        setupImage()
        setupItems()
        setupDragLabel()
        setupTargets()
        setupFactLabel()
        setupInfo()
        setupInfoResult()
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
        
        // Molecule name label
        molecule = SKLabelNode(fontNamed: UtilitiesPortal.navLabelFont)
        molecule.text = "\(lvlThreeQuestion.itemName)"
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
    func setupImage() {
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
    
    func setupDragLabel() {
        for count in 0...UtilitiesPortal.levelThreeAnswers.count-1 {
            let answer = CustomSKSpriteNode(imageNamed:
                "\(UtilitiesPortal.levelThreeAnswers[count])-border")
            answer.name = UtilitiesPortal.levelThreeAnswers[count]
            answer.value = UtilitiesPortal.levelThreeAnswers[count]
            answer.zPosition = 0.3
            answer.alpha = 0.9
            /*answer.size = CGSize(width: UtilitiesPortal.screenWidth*0.20,
                                 height: UtilitiesPortal.screenHeight*0.15)
            let current = CGPoint(x:UtilitiesPortal.screenWidth*0.85,
                                  y:UtilitiesPortal.screenHeight*(0.75-0.18*CGFloat(count)))*/
            
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
    
    func setupTargets() {
        for x in 0...lvlThreeQuestion.positions.count-1 {
            positions.append(lvlThreeQuestion.positions[x])
        }
        
        for count in 0...positions.count-1 {
            let sprite = CustomSKSpriteNode()
            sprite.texture = SKTexture(imageNamed: "\(count+1)")
            sprite.color = UIColor.whiteColor()
            sprite.alpha = 0.9
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
    func setupFactLabel() {
        let randomIndex = Int(arc4random_uniform(UInt32(lvlThreeQuestion.facts.count)))
        let fact = lvlThreeQuestion.facts[randomIndex]
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
        
        // If the fact is shorter than 2 lines, reduces the width of the label by 50
        if factOverlayText.lineCount < 3 {
            factOverlayText.labelWidth -= 50
        }
        
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
    func setupInfoResult() {
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
    
    //Show Home Button Dialogue box
    func createHomeDialogue() {
        let yesBtn = SKSpriteNode()
        let noBtn = SKSpriteNode()
        let alertMessage = SKLabelNode(text: "You sure you wanna quit?")
        
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
        addChild(homeDialogue)
        addChild(homeView)
    }

    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        if chosenAnswer == nil {
            return
        }
        
        chosenAnswer.position = touch!.locationInNode(self)
        
        print("+++++++++++++++++++++++++")
        
        let xPostion = chosenAnswer.position.x
        let yPostion = chosenAnswer.position.y
        let x = xPostion / UtilitiesPortal.screenWidth
        let y = yPostion / UtilitiesPortal.screenHeight
        print("x=\(x)")
        print("y=\(y)")
        
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
                    homeView.hidden = true
                    state = previousState
                    previousState = UtilitiesPortal.stateHome
                    return
                }
            }
            return
        }
        
        if state == UtilitiesPortal.stateInfo {
            //infoOverlay.hidden = true
            infoOverlay.removeAllActions()
            infoOverlay.removeAllChildren()
            infoOverlay.removeFromParent()
            state = previousState
            previousState = UtilitiesPortal.stateInfo
            return
        }
        
        if state == UtilitiesPortal.stateInfoResult {
            infoOverlayResult .hidden = true
            infoOverlayResult .removeAllActions()
            infoOverlayResult .removeAllChildren()
            infoOverlayResult .removeFromParent()
            state = previousState
            previousState = UtilitiesPortal.stateInfoResult
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
            homeView.hidden = false
            previousState = state
            state = UtilitiesPortal.stateHome
        }
        
        // Tick button selected
        if node.name == UtilitiesPortal.tickButtonName {
            if state == UtilitiesPortal.stateAnswer && checkResult() {
                displayResult()
                if DataHandler.getLevelThreeScore() == UtilitiesPortal.firstTime {
                    infoOverlayResult.hidden = false
                    previousState = UtilitiesPortal.stateResult
                    state = UtilitiesPortal.stateInfoResult
                    DataHandler.saveLevelThreeScore()
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
        
        if state == UtilitiesPortal.stateFact {
            setupScene()
            return
        }
        
        // Show button selected
        if node.name == UtilitiesPortal.showButtonName {
            if state == UtilitiesPortal.stateResult {
                displayAnswers(true)
                resultImage = SKSpriteNode(imageNamed: lvlThreeQuestion.imageSol)
                resultImage.zPosition = 0.5
                resultImage.alpha = 1
                let current = CGPoint(x:UtilitiesPortal.borderSize + UtilitiesPortal.imageWidth/2,
                                      y:UtilitiesPortal.screenHeight/2 )
                resultImage.position = PositionHandler.convertTargetPointLevelThree(current)
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
        
        // Fact Overlay selected
        if node.name == UtilitiesPortal.factOverlayName {
            factOverlay.hidden = true
            setupScene()
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
    
    //back to the home page,
    func backHomePage() {
        UtilitiesPortal.totalQuestions = 0
        UtilitiesPortal.score = 0
        cleanScene()
        let secondScene = GameScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    override func willMoveFromView(view: SKView) {
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
        
        self.removeAllActions()
        self.removeAllChildren()
        print("Remove all nodes Lvl 3 Scene")
    }
    
    func cleanScene() {
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
