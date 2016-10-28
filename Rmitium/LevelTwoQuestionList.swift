//
//  LevelTwoQuestionList.swift
//  Rmitium
//
//  Created by Aoi Mizu on 9/19/16.
//  Copyright © 2016 Spencer and Jones. All rights reserved.
//

import Foundation
class LevelTwoQuestionList {
    static var listOfQuestions:[LevelTwoQuestion] = []
    static var imageList:[NSString] = []
    
    static func getQuestionsList() ->[NSString] {
        listOfQuestions = LevelTwoQuestion.getQuestions()
        select(UtilitiesPortal.levelTwoWidth * UtilitiesPortal.levelTwoHeight)
        shuffle()
        return imageList
    }
    
    static func shuffle() {
        
        // Perform the swap operation equal to the number of Questions in the list
        for currentQuestionIndex in 0..<imageList.count-1 {
            
            // Random number between 0 and the number of Questions in list
            //let randomQuestionIndex = Int(arc4random_uniform(UInt32(listOfQuestions.count)))
            let randomIndex = random()
            
            // Check that we are not swapping a Question with itself
            if randomIndex != currentQuestionIndex {
                // Swap the current Question with a random Question
                swap(&imageList[currentQuestionIndex], &imageList[randomIndex])
            }
        }
    }
    
    static func random() -> Int{
        let randomQuestionIndex = Int(arc4random_uniform(UInt32(imageList.count-1)))
        return randomQuestionIndex
    }
    
    static func select(numberOfQuestion: Int) ->[NSString]
    {
        imageList.removeAll()
        /*if numberOfQuestion >= listOfQuestions.count {
            return listOfQuestions
        }*/
        for count in 0...numberOfQuestion/2-1 {
            let index = count%((listOfQuestions.count-1)/2)
            imageList.append(listOfQuestions[index*2].imageName)
            imageList.append(listOfQuestions[index*2+1].imageName)
        }
        return imageList
    }
}
