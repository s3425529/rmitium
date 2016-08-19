//
//  LevelOneModel.swift
//  Rmitium
//
//  Created by Thinh Tran on 19/08/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
class LevelOneModel {
    var listOfQuestions: LevelOneQuestionList
    
    private struct Static{
        static var instance: LevelOneModel?
    }
    
    class var sharedInstance: LevelOneModel
    {
        if !(Static.instance != nil)
        {
            Static.instance = LevelOneModel()
        }
        return Static.instance!
    }
    
    private init(){
        listOfQuestions = LevelOneQuestionList()
    }
    
}