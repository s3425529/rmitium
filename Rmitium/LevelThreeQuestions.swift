//
//  LevelThreeQuestions.swift
//  Rmitium
//
//  Created by Thinh Tran on 26/08/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation

enum LevelThreeQuestion:Int {
    
    init() {
        self = .QuestionOne
    }
    
    init?(number:Int)
    {
        switch number
        {
        case 1: self = .QuestionOne
        case 2: self = .QuestionTwo
        case 3: self = .QuestionThree
        case 4: self = .QuestionFour
        case 5: self = .QuestionFive
        case 6: self = .QuestionSix
        case 7: self = .QuestionSeven
        case 8: self = .QuestionEight
        case 9: self = .QuestionNine
        default:
            return nil
        }
    }
    
    case QuestionOne=1, QuestionTwo, QuestionThree, QuestionFour, QuestionFive, QuestionSix, QuestionSeven,QuestionEight, QuestionNine
    var imageName:String{
        get{
            
            switch self
            {
            case .QuestionOne: return ""
            case .QuestionTwo: return ""
            case .QuestionThree: return ""
            case .QuestionFour: return ""
            case .QuestionFive: return ""
            case .QuestionSix: return ""
            case .QuestionSeven: return ""
            case .QuestionEight: return ""
            case .QuestionNine: return ""
            }
        }
    }
    
    var imageSol:String
        {
        get
        {
            return self.imageName.stringByAppendingString("solution")
        }
        
    }
    
    var solutions:[String]{
        get {
            switch self {
            case .QuestionOne: return []
            case .QuestionTwo: return []
            case .QuestionThree: return []
            case .QuestionFour: return []
            case .QuestionFive: return []
            case .QuestionSix: return []
            case .QuestionSeven: return []
            case .QuestionEight: return []
            case .QuestionNine: return []
            }
        }
    }
    
    var positions:[Position]{
        get {
            switch self {
                
            case .QuestionOne: return []
            case .QuestionTwo: return []
            case .QuestionThree: return []
            case .QuestionFour: return []
            case .QuestionFive: return []
            case .QuestionSix: return []
            case .QuestionSeven: return []
            case .QuestionEight: return []
            case .QuestionNine: return []
            }
        }
    }
    
    var facts:[String]{
        get {
            switch self{
            case .QuestionOne: return[]
            case .QuestionTwo: return []
            case .QuestionThree: return []
            case .QuestionFour: return []
            case .QuestionFive: return []
            case .QuestionSix: return []
            case .QuestionSeven: return []
            case .QuestionEight: return []
            case .QuestionNine: return []
                
            }
        }
    }
    
    static func getQuestions() ->[LevelThreeQuestion]{
        return [QuestionOne,QuestionTwo,QuestionThree,QuestionFour,QuestionFive,QuestionSix,
            QuestionSeven,QuestionEight,QuestionNine]
    }
    
}

    
    
