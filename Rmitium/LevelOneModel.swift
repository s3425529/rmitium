//
//  LevelOneModel.swift
//  Rmitium
//
//  Created by Thinh Tran on 19/08/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
class LevelOneModel {
    static var listOfQuestions: [LevelOneQuestion] = []
    static var index: Int = 0
    
    static func reset() {
        // Get a new list of level 1 questions
        listOfQuestions = LevelOneQuestionList.getQuestionsList()
        index = 0
    }
    
    static var currentQuestion:LevelOneQuestion {
        get {
            let current = index
            if index == listOfQuestions.count { // Reset at the end of the list
                reset()
            }
            else { // Traverse through the list
                index = index + 1
            }
            return listOfQuestions[current]
        }
    }
}
