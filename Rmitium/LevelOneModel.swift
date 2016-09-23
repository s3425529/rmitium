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
    
    /*private struct Static{
     static var instance: LevelThreeModel?
     }
     
     class var sharedInstance: LevelThreeModel
     {
     if !(Static.instance != nil)
     {
     Static.instance = LevelThreeModel()
     }
     return Static.instance!
     }*/
    
    static func reset() {
        listOfQuestions = LevelOneQuestionList.getQuestionsList()
        index = 0
    }
    
    static var currentQuestion:LevelOneQuestion {
        get {
            let current = index
            if index == listOfQuestions.count {
            
                reset()
            }
            else {
                index = index + 1
            }
            return listOfQuestions[current]
        }
    }
}
