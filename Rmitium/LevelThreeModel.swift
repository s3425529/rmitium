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
        listOfQuestions = LevelThreeQuestionList.getQuestionsList()
        index = 0
    }
    
    static var currentQuestion:LevelThreeQuestion {
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