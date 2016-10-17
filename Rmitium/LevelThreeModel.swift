//
//  LevelThreeModel.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/26/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
class LevelThreeModel {
    static var listOfQuestions: [LevelThreeQuestion] = []
    static var index: Int = 0
    
    static func reset() {
        // Get a new list of level 3 questions
        listOfQuestions = LevelThreeQuestionList.getQuestionsList()
        index = 0
    }
    
    static var currentQuestion:LevelThreeQuestion {
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
