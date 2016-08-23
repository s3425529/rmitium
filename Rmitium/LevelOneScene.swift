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
    var tick: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        /*
        let background: SKSpriteNode = SKSpriteNode(imageNamed: "background")
        background.alpha = 0.3
        background.size = CGSize(width: UtilitiesPortal.screenWidth,
                                 height: UtilitiesPortal.screenHeight)
        background.position = CGPoint(x:frame.midX, y:frame.midY)
        background.zPosition = 0
        addChild(background)
        */
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
        tick.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
            y: UtilitiesPortal.navImgSize/2)
        addChild(tick)
        
        //Mark add new help
        let help = SKSpriteNode(imageNamed: "help2")
        help.zPosition = 0.1
        help.alpha = 0.9
        help.size = CGSize(width: UtilitiesPortal.navImgSize, height: UtilitiesPortal.navImgSize)
        help.position = CGPoint(x:UtilitiesPortal.screenWidth - UtilitiesPortal.borderSize/2,
                              y:UtilitiesPortal.screenHeight - UtilitiesPortal.navImgSize/2)
        addChild(help)
        
        // Image
        let image = SKSpriteNode(imageNamed: "S1-morphine-final")
        image.zPosition = 0.1
        image.alpha = 0.9
        image.position = CGPoint(x:UtilitiesPortal.borderSize+UtilitiesPortal.imageWidth/2,
                                 y:UtilitiesPortal.screenHeight/2 )
        image.position = CGPoint(x:UtilitiesPortal.borderSize+UtilitiesPortal.imageWidth/2,
            y:UtilitiesPortal.screenHeight/2 )
        image.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
        addChild(image)
        
        setupDragLabel()
        setupTargets()
    }
    
    func setupDragLabel() {
        for count in 0...UtilitiesPortal.levelOneAnswers.count-1 {
            let answer = CustomSKSpriteNode(imageNamed: UtilitiesPortal.levelOneAnswers[count])
            answer.name = UtilitiesPortal.levelOneAnswers[count]
            answer.value = UtilitiesPortal.levelOneAnswers[count]
            answer.zPosition = 1
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
        positions.append(Position(x:0.35, y:0.77))
        positions.append(Position(x:0.13, y:0.48))
        positions.append(Position(x:0.10, y:0.22))
        positions.append(Position(x:0.48, y:0.19))
        positions.append(Position(x:0.60, y:0.40))
        
        for count in 1...5 {
            let sprite = CustomSKSpriteNode()
            sprite.color = UIColor.blueColor()
            sprite.alpha = 0.7
            sprite.name = "question\(5-count)"
            sprite.size = CGSizeMake(UtilitiesPortal.screenWidth*0.3, UtilitiesPortal.screenHeight*0.2)
            sprite.zPosition = 0.9
            sprite.position = CGPoint(x:UtilitiesPortal.screenWidth * positions[count-1].x,
                                      y:UtilitiesPortal.screenHeight * positions[count-1].y)
            addChild(sprite)
            questions.append(sprite)
            
            let answeredQuestion = CustomSKSpriteNode(imageNamed: UtilitiesPortal.levelOneAnswers[0])
            answeredQuestion.name = UtilitiesPortal.emptyString
            answeredQuestion.zPosition = 1
            answeredQuestion.alpha = 1
            answeredQuestion.hidden = true
            answeredQuestion.position = sprite.position
            answeredQuestion.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                 height: UtilitiesPortal.screenHeight*0.1)
            addChild(answeredQuestion)
            answeredQuestions.append(answeredQuestion)
        }
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
                chosenAnswer.zPosition = 1
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
                chosenAnswer.zPosition = 1
                chosenAnswer.alpha = 0.9
                chosenAnswer.size = CGSize(width: UtilitiesPortal.screenWidth*0.15,
                                           height: UtilitiesPortal.screenHeight*0.1)
                chosenAnswer.zPosition = 1
                chosenAnswer.position = questions[x].position
                addChild(chosenAnswer)
                return
            }
        }
        
        // Home button selected
        let location = touch!.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if node.name == UtilitiesPortal.homeButtonName {
            print("Home selected")
            let secondScene = GameScene(size: self.size)
            let transition = SKTransition.fadeWithColor(UIColor.blackColor(), duration: 0.3)
            secondScene.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(secondScene, transition: transition)
        }
        
        // Tick button selected
        if node.name == UtilitiesPortal.tickButtonName {
            print("Tick selected")
            if checkResult() {
                resultImage = SKSpriteNode(imageNamed: "S1-morphine-finalsolution")
                resultImage.zPosition = 1
                resultImage.alpha = 1
                resultImage.position = CGPoint(x:UtilitiesPortal.borderSize+UtilitiesPortal.imageWidth/2,
                                               y:UtilitiesPortal.screenHeight/2 )
                resultImage.position = CGPoint(x:UtilitiesPortal.borderSize+UtilitiesPortal.imageWidth/2,
                                               y:UtilitiesPortal.screenHeight/2 )
                resultImage.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
                addChild(resultImage)
            }
            else {
                //resultImage.removeFromParent()
                //self.resultImage = nil
            }
        }
    }
    
    func checkResult() -> Bool {
        for x in 0...questions.count-1 {
            if answeredQuestions[x].hidden {
                return false
            }
        }
        return true
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
