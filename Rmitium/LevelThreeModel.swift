//
//  LevelThreeModel.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/26/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
class LevelThreeModel {
    var listOfQuestions: LevelThreeQuestionList
    var index: Int
    
    private struct Static{
        static var instance: LevelThreeModel?
    }
    
    class var sharedInstance: LevelThreeModel
    {
        if !(Static.instance != nil)
        {
            Static.instance = LevelThreeModel()
        }
        return Static.instance!
    }
    
    private init(){
        listOfQuestions = LevelThreeQuestionList()
        index = 0
    }
    
    var currentQuestion:LevelThreeQuestion {
        get {
            var current = index
            if index == listOfQuestions.listOfQuestions.count-1 {
                index = 1
                current = 0
            }
            else {
                index = index + 1
            }
            return listOfQuestions.listOfQuestions[current]
        }
    }
}