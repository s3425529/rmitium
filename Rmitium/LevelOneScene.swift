//
//  LevelOneScene.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/8/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import SpriteKit

class LevelOneScene: SKScene {
    var answers: [SKLabelNode] = []
    var questions: [SKSpriteNode] = []
    var positions = [Position]()
    var currentAnswerPostions: [CGPoint] = []
    var chosenAnswer: SKLabelNode!
    let yellowBin = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        let image = SKSpriteNode(imageNamed: "test_ans")
        //image.position = CGPoint(x:UtilitiesPortal.screenWidth*0.35, y:frame.midY)
        //image.position = CGPoint(x:UtilitiesPortal.screenWidth, y:UtilitiesPortal.screenHeight)
        image.zPosition = 0
        image.position = CGPoint(x:UtilitiesPortal.borderSize+UtilitiesPortal.imageWidth/2, y:UtilitiesPortal.screenHeight/2)
        image.size = CGSize(width: UtilitiesPortal.imageWidth, height: UtilitiesPortal.imageHeight)
        addChild(image)
        setupDragLabel()
        setupTargets()
        
        
        //Make add button
        
        let button: GGButton = GGButton(defaultButtonImage: "refresh", activeButtonImage: "confirm", buttonAction:buttonAction)
        button.position = CGPointMake(self.frame.width * 0.05, self.frame.height * 0.9)
        button.setScale(0.3)
        addChild(button)
    }
    
    //Button action
    func buttonAction() -> Void{
       
        print("hello!!!!!!!")
      
    }
    
    
    func setupDragLabel() {
        for count in 1...5 {
            let answer = SKLabelNode()
            answer.fontName = "Chalkduster"
            answer.fontColor = UIColor.redColor()
            answer.text = "Answer \(5-count+1)"
            answer.name = "answer\(5-count)"
            answer.fontSize = UtilitiesPortal.levelLabelSize
            answer.zPosition = 1
            answer.position = CGPoint(x:UtilitiesPortal.screenWidth*0.9,
                                      y:UtilitiesPortal.screenHeight*(0.2+0.1*CGFloat(count)))
            addChild(answer)
            answers.append(answer)
            currentAnswerPostions.append(CGPoint(x:UtilitiesPortal.screenWidth*0.9,
                y:UtilitiesPortal.screenHeight*(0.2+0.1*CGFloat(count))))
        }
    }
    
    func setupTargets() {
        positions.append(Position(x:0.38, y:0.75))
        positions.append(Position(x:0.18, y:0.47))
        positions.append(Position(x:0.68, y:0.42))
        positions.append(Position(x:0.15, y:0.29))
        positions.append(Position(x:0.59, y:0.25))
        
        for count in 1...5 {
            let sprite = SKSpriteNode()
            //label.anchorPoint = CGPoint(x:0.5, y:1)
            sprite.alpha = 0.5
            //sprite.color = UIColor.blueColor()
            sprite.color = UIColor.whiteColor()
            sprite.name = "question\(5-count)"
            sprite.size = CGSizeMake(100, UtilitiesPortal.levelLabelSize)
            sprite.zPosition = 0.5
            sprite.position = CGPoint(x:UtilitiesPortal.screenWidth * positions[count-1].x,
                                      y:UtilitiesPortal.screenHeight * positions[count-1].y)
            addChild(sprite)
            questions.append(sprite)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        if chosenAnswer == nil {
            return
        }
        if chosenAnswer == answers[0] {
            answers[0].position = touch!.locationInNode(self)
        }
        if chosenAnswer == answers[1] {
            answers[1].position = touch!.locationInNode(self)
        }
        if chosenAnswer == answers[2] {
            answers[2].position = touch!.locationInNode(self)
        }
        if chosenAnswer == answers[3] {
            answers[3].position = touch!.locationInNode(self)
        }
        if chosenAnswer == answers[4] {
            answers[4].position = touch!.locationInNode(self)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(chosenAnswer == nil) {
            return
        }
        if(chosenAnswer == answers[0]) {
            if CGRectContainsPoint(questions[0].frame, answers[0].position) {
                answers[0].position = questions[0].position
            }
            else if CGRectContainsPoint(questions[1].frame, answers[0].position) {
                answers[0].position = questions[1].position
            }
            else if CGRectContainsPoint(questions[2].frame, answers[0].position) {
                answers[0].position = questions[2].position
            }
            else if CGRectContainsPoint(questions[3].frame, answers[0].position) {
                answers[0].position = questions[3].position
            }
            else if CGRectContainsPoint(questions[4].frame, answers[0].position) {
                answers[0].position = questions[4].position
            }
            else {
                answers[0].position = currentAnswerPostions[0]
            }
        }
        else if(chosenAnswer == answers[1]) {
            if CGRectContainsPoint(questions[0].frame, answers[1].position) {
                answers[1].position = questions[0].position
            }
            else if CGRectContainsPoint(questions[1].frame, answers[1].position) {
                answers[1].position = questions[1].position
            }
            else if CGRectContainsPoint(questions[2].frame, answers[1].position) {
                answers[1].position = questions[2].position
            }
            else if CGRectContainsPoint(questions[3].frame, answers[1].position) {
                answers[1].position = questions[3].position
            }
            else if CGRectContainsPoint(questions[4].frame, answers[1].position) {
                answers[1].position = questions[4].position
            }
            else {
                answers[1].position = currentAnswerPostions[1]
            }
        }
        else if(chosenAnswer == answers[2]) {
            if CGRectContainsPoint(questions[0].frame, answers[2].position) {
                answers[2].position = questions[0].position
            }
            else if CGRectContainsPoint(questions[1].frame, answers[2].position) {
                answers[2].position = questions[1].position
            }
            else if CGRectContainsPoint(questions[2].frame, answers[2].position) {
                answers[2].position = questions[2].position
            }
            else if CGRectContainsPoint(questions[3].frame, answers[2].position) {
                answers[2].position = questions[3].position
            }
            else if CGRectContainsPoint(questions[4].frame, answers[2].position) {
                answers[2].position = questions[4].position
            }
            else {
                answers[2].position = currentAnswerPostions[2]
            }
        }
        else if(chosenAnswer == answers[3]) {
            if CGRectContainsPoint(questions[0].frame, answers[3].position) {
                answers[3].position = questions[0].position
            }
            else if CGRectContainsPoint(questions[1].frame, answers[3].position) {
                answers[3].position = questions[1].position
            }
            else if CGRectContainsPoint(questions[2].frame, answers[3].position) {
                answers[3].position = questions[2].position
            }
            else if CGRectContainsPoint(questions[3].frame, answers[3].position) {
                answers[3].position = questions[3].position
            }
            else if CGRectContainsPoint(questions[4].frame, answers[3].position) {
                answers[3].position = questions[4].position
            }
            else {
                answers[3].position = currentAnswerPostions[3]
            }
        }
        else if(chosenAnswer == answers[4]) {
            if CGRectContainsPoint(questions[0].frame, answers[4].position) {
                answers[4].position = questions[0].position
            }
            else if CGRectContainsPoint(questions[1].frame, answers[4].position) {
                answers[4].position = questions[1].position
            }
            else if CGRectContainsPoint(questions[2].frame, answers[4].position) {
                answers[4].position = questions[2].position
            }
            else if CGRectContainsPoint(questions[3].frame, answers[4].position) {
                answers[4].position = questions[3].position
            }
            else if CGRectContainsPoint(questions[4].frame, answers[4].position) {
                answers[4].position = questions[4].position
            }
            else {
                answers[4].position = currentAnswerPostions[4]
            }
        }
        
        chosenAnswer = nil
        print(UtilitiesPortal.screenWidth)
        print(UtilitiesPortal.screenHeight)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        
        if CGRectContainsPoint(answers[0].frame, touch!.previousLocationInNode(self)) {
            chosenAnswer = answers[0]
        }
        if CGRectContainsPoint(answers[1].frame, touch!.previousLocationInNode(self)) {
            chosenAnswer = answers[1]
        }
        if CGRectContainsPoint(answers[2].frame, touch!.previousLocationInNode(self)) {
            chosenAnswer = answers[2]
        }
        if CGRectContainsPoint(answers[3].frame, touch!.previousLocationInNode(self)) {
            chosenAnswer = answers[3]
        }
        if CGRectContainsPoint(answers[4].frame, touch!.previousLocationInNode(self)) {
            chosenAnswer = answers[4]
        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
