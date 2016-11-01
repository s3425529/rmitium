//
//  LevelOneQuestionList.swift
//  Rmitium
//
//  Created by Thinh Tran on 19/08/2016.
//  Copyright © 2016 Spencer and Jones. All rights reserved.
//

import Foundation
class LevelOneQuestionList {
    static var listOfQuestions:[LevelOneQuestion] = []
    
    static func getQuestionsList() ->[LevelOneQuestion] {
        listOfQuestions = LevelOneQuestion.getQuestions()
        shuffle()
        //select(9)
        select(5)
        return listOfQuestions
    }
    
    static func shuffle() {
        
        // Perform the swap operation equal to the number of Questions in the list
        for currentQuestionIndex in 0..<listOfQuestions.count-1 {
            
            // Random number between 0 and the number of Questions in list
            //let randomQuestionIndex = Int(arc4random_uniform(UInt32(listOfQuestions.count)))
            let randomIndex = random()
            
            // Check that we are not swapping a Question with itself
            if randomIndex != currentQuestionIndex {
                // Swap the current Question with a random Question
                swap(&listOfQuestions[currentQuestionIndex], &listOfQuestions[randomIndex])
            }
        }
    }
    
    static func random() -> Int{
        let randomQuestionIndex = Int(arc4random_uniform(UInt32(listOfQuestions.count-1)))
        return randomQuestionIndex
    }
    
    //Function outputting a specified number of questions
    static func select(numberOfQuestion: Int) ->[LevelOneQuestion]
    {
        if numberOfQuestion >= listOfQuestions.count {
            return listOfQuestions
        }
        var selectedQuestions:[LevelOneQuestion] = []
        for count in 0...numberOfQuestion-1 {
            selectedQuestions.append(listOfQuestions[count])
            
        }
        selectedQuestions.append(listOfQuestions[listOfQuestions.count-1])
        listOfQuestions.removeAll()
        listOfQuestions = selectedQuestions
        return listOfQuestions
    }
}
