//
//  LevelOneScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/8/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import SpriteKit

class LevelOneScene: SKScene {
    var answers: [CustomSKSpriteNode] = []
    var questions: [CustomSKSpriteNode] = []
    var answeredQuestions: [CustomSKSpriteNode] = []
    var positions = [Position]()
    var currentAnswerPostions: [CGPoint] = []
    var chosenAnswer: CustomSKSpriteNode!
    var resultImage: SKSpriteNode!
    var show, tick, next: SKSpriteNode!
    
    var lvlOneQuestion: LevelOneQuestion!
    var state: Bool!
    
  
    override func didMoveToView(view: SKView) {
        setupScene()
    }
    
    func setupScene() {
        self.removeAllChildren()
        lvlOneQuestion = LevelOneModel.sharedInstance.currentQuestion
        
        state = UtilitiesPortal.stateAnswer
        
        let levelLabel = SKLabelNode(fontNamed:UtilitiesPortal.navLabelFont)
        levelLabel.zPosition = 0.1
        levelLabel.text = UtilitiesPortal.levelLabelTexts[0]
        levelLabel.fontSize = UtilitiesPortal.navLabelSize
        levelLabel.position = CGPointMake(frame.midX, UtilitiesPortal.screenHeight*0.92)
        self.addChild(levelLabel)
        
        // Home button
        let home = SKSpriteNode(imageNamed: "home")
        home.name = UtilitiesPortal.homeButtonName
        home.zPosition = 0.1
        home.alpha = 0.9
        home.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        home.position = CGPoint(x:UtilitiesPortal.borderSize/2,
                                y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(home)
        
        // Tick button
        tick = SKSpriteNode(imageNamed: "tick-grey")
        tick.name = UtilitiesPortal.tickButtonName
        tick.zPosition = 0.1
        tick.alpha = 0.9
        tick.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        tick.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize,
                                y: UtilitiesPortal.navImgSize/2)
        addChild(tick)
        
        // Show button
        show = SKSpriteNode(imageNamed: "show")
        show.name = UtilitiesPortal.showButtonName
        show.zPosition = 0.1
        show.alpha = 0.9
        show.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        show.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*2,
                                y: UtilitiesPortal.navImgSize/2)
        addChild(show)
        
        // Next button
        next = SKSpriteNode(imageNamed: "next")
        next.name = UtilitiesPortal.nextButtonName
        next.zPosition = 0.1
        next.alpha = 0.9
        next.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        next.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize*3,
                                y: UtilitiesPortal.navImgSize/2)
        addChild(next)
        
        // Help button
        let help = SKSpriteNode(imageNamed: "help2")
        help.zPosition = 0.1
        help.alpha = 0.9
        help.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        help.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
                                y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(help)
        
        // Image
        let image = SKSpriteNode(imageNamed: lvlOneQuestion.imageName)
        image.zPosition = 0.1
        image.alpha = 0.9
        image.position = CGPoint(x:UtilitiesPortal.borderSize+UtilitiesPortal.imageWidth/2,
                                 y:UtilitiesPortal.screenHeight/2 )
        image.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
        addChild(image)
        setupDragLabel()
        setupTargets()
        setupFactLabel("Morphine has a high potential for addiction; during the American Civil War, around 400 000 soldiers became addicted to morphine.")
    }
    
    func setupDragLabel() {
        for count in 0...UtilitiesPortal.levelOneAnswers.count-1 {
            let answer = CustomSKSpriteNode(imageNamed: UtilitiesPortal.levelOneAnswers[count])
            answer.name = UtilitiesPortal.levelOneAnswers[count]
            answer.value = UtilitiesPortal.levelOneAnswers[count]
            answer.zPosition = 0.3
            answer.alpha = 0.9
            answer.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                 height: UtilitiesPortal.screenHeight*0.1)
            
            if count < 5 {
                answer.position = CGPoint(x:UtilitiesPortal.screenWidth*0.75,
                                          y:UtilitiesPortal.screenHeight*(0.8-0.1*CGFloat(count)))
            }
            else if count < 10 {
                answer.position = CGPoint(x:UtilitiesPortal.screenWidth*0.90,
                                          y:UtilitiesPortal.screenHeight*(0.8-0.1*CGFloat(count-5)))
            }
            else {
                answer.position = CGPoint(x:UtilitiesPortal.screenWidth*0.85,
                                          y:UtilitiesPortal.screenHeight*(0.8-0.1*CGFloat(count-5)))
            }
            
            addChild(answer)
            answers.append(answer)
            currentAnswerPostions.append(answer.position)
        }
    }
    
    func setupTargets() {
        positions.removeAll()
        questions.removeAll()
        answeredQuestions.removeAll()
        
        for x in 0...lvlOneQuestion.positions.count-1 {
            positions.append(lvlOneQuestion.positions[x])
        }
        
        for count in 0...positions.count-1 {
            let sprite = CustomSKSpriteNode()
            sprite.color = UIColor.blueColor()
            sprite.alpha = 0
            sprite.name = "question\(count)"
            sprite.size = CGSizeMake(UtilitiesPortal.screenWidth*0.3, UtilitiesPortal.screenHeight*0.2)
            sprite.zPosition = 0.2
            sprite.position = CGPoint(x:UtilitiesPortal.screenWidth * positions[count].x,
                                      y:UtilitiesPortal.screenHeight * positions[count].y)
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
    func setupFactLabel(fact: String){
        let fact = fact
        let index = fact.startIndex.advancedBy(20)
        let shortenFact = fact.substringToIndex(index)
        
        let factLabel = SKLabelNode(fontNamed: UtilitiesPortal.navLabelFont)
        factLabel.name = UtilitiesPortal.factLabelName
        factLabel.fontSize = 25
        factLabel.text = "Did you know: " + shortenFact + "...(see more)"
        factLabel.zPosition = 0.9
        factLabel.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.navImgSize/2)
        
        let factOverlayText = SKMultilineLabel(text: fact, labelWidth: UtilitiesPortal.screenWidth, pos: CGPoint(x: 0, y: 0),fontName: UtilitiesPortal.navLabelFont ,fontSize: 40, leading: 40 )
        
        let factOverlay = SKSpriteNode()
        factOverlay.name = UtilitiesPortal.factOverlayName
        factOverlay.size = CGSize(width: UtilitiesPortal.screenWidth, height: UtilitiesPortal.screenHeight)
        factOverlay.position = CGPoint(x: UtilitiesPortal.screenWidth/2, y: UtilitiesPortal.screenHeight/2)
        factOverlay.color = SKColor.blackColor()
        factOverlay.alpha = 0.7
        factOverlay.zPosition = 1
        factOverlay.hidden = true
        factOverlay.addChild(factOverlayText)
        addChild(factLabel)
        addChild(factOverlay)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        if chosenAnswer == nil {
            return
        }
        
        chosenAnswer.position = touch!.locationInNode(self)
        //print("+++++++++++++++++++++++++")
        
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
        print(chosenAnswer.value)
        
        for x in 0...questions.count-1 {
            if CGRectContainsPoint(questions[x].frame, chosenAnswer.position) {
                answeredQuestions[x].hidden = false
                answeredQuestions[x].texture = SKTexture(imageNamed: chosenAnswer.value)
                answeredQuestions[x].value = chosenAnswer.value
                print(answeredQuestions[x].value)
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
        
        // Home button selected
        let location = touch!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if node.name == UtilitiesPortal.homeButtonName {
            backHomePage()
            
        }
        
        // Tick button selected
        if node.name == UtilitiesPortal.tickButtonName {
            if checkResult() {
                if resultImage == nil {
                    displayResult()
                }
            }
            return
             //displayShareSheet("heoooooo!")
        }
        
        // Show button selected
        if node.name == UtilitiesPortal.showButtonName {
            if checkResult() {
                if resultImage == nil {
                    displayAnswers(true)
                    resultImage = SKSpriteNode(imageNamed: lvlOneQuestion.imageSol)
                    resultImage.zPosition = 0.5
                    resultImage.alpha = 1
                    resultImage.position = CGPoint(x:UtilitiesPortal.borderSize+UtilitiesPortal.imageWidth/2,
                                                   y:UtilitiesPortal.screenHeight/2 )
                    resultImage.position = CGPoint(x:UtilitiesPortal.borderSize+UtilitiesPortal.imageWidth/2,
                                                   y:UtilitiesPortal.screenHeight/2 )
                    resultImage.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
                    addChild(resultImage)
                    return
                }
                else {
                    displayAnswers(false)
                    resultImage.removeFromParent()
                    self.resultImage = nil
                }
            }
        }
        //Fact label selected
        if node.name == UtilitiesPortal.factLabelName {
            let factOvl = self.childNodeWithName(UtilitiesPortal.factOverlayName)
            factOvl?.hidden = false
        }
        
        if node.name == UtilitiesPortal.factOverlayName {
            node.hidden = true
        }
        
    }
    
    func checkResult() -> Bool {
        for x in 0...questions.count-1 {
            if answeredQuestions[x].value == UtilitiesPortal.emptyString {
                return false
            }
        }
        return true
    }
    
    func displayResult() {
        if state == UtilitiesPortal.stateAnswer {
            for x in 0...lvlOneQuestion.solutions.count-1 {
                if answeredQuestions[x].value != UtilitiesPortal.emptyString {
                    if answeredQuestions[x].value == lvlOneQuestion.solutions[x] {
                        answeredQuestions[x].texture = SKTexture(imageNamed: "tick-green")
                    }
                    else {
                        answeredQuestions[x].texture = SKTexture(imageNamed: "tick-grey")
                    }
                }
            }
            state = UtilitiesPortal.stateResult
        }
        else if state == UtilitiesPortal.stateResult {
            for x in 0...lvlOneQuestion.solutions.count-1 {
                if answeredQuestions[x].value != UtilitiesPortal.emptyString {
                    answeredQuestions[x].texture = SKTexture(imageNamed: answeredQuestions[x].value)
                }
                
            }
            state = UtilitiesPortal.stateAnswer
        }
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
    
    // Share the score to any social media!
    func displayShareSheet(shareContent:String) {
        
            let myShare = "My best is \(shareContent)"
            let controller = self.view?.window?.rootViewController as! GameViewController
            
            let activityVC: UIActivityViewController = UIActivityViewController(activityItems: [myShare], applicationActivities: nil)
            
            controller.presentViewController(activityVC, animated: true, completion: nil)
        
    }
    
    //back to the home page,
    func backHomePage(){
    
        let secondScene = GameScene(size: self.size)
        let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
