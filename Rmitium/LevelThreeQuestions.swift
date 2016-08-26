//
//  LevelThreeQuestion.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/26/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
enum LevelThreeQuestion:Int{
    
    init()
    {
        self = .QuestionOne
    }
    
    init?(number:Int)
    {
        switch number
        {
        case 0: self = .NilQuestion
        case 1: self = .QuestionOne
        case 2: self = .QuestionTwo
        case 3: self = .QuestionThree
        case 4: self = .QuestionFour
        case 5: self = .QuestionFive
        case 6: self = .QuestionSix
        case 7: self = .QuestionSeven
        case 8: self = .QuestionEight
        case 9: self = .QuestionNine
        case 10: self = .QuestionTen
        default:
            return nil
        }
    }
    
    case NilQuestion=0, QuestionOne=1, QuestionTwo, QuestionThree, QuestionFour, QuestionFive, QuestionSix, QuestionSeven,QuestionEight, QuestionNine, QuestionTen
    
    var imageName:String{
        get{
            
            switch self
            {
                case .NilQuestion: return "nil"
                case .QuestionOne: return "L3-S1-morphine-final"
                case .QuestionTwo: return ""
                case .QuestionThree: return ""
                case .QuestionFour: return ""
                case .QuestionFive: return ""
                case .QuestionSix: return ""
                case .QuestionSeven: return ""
                case .QuestionEight: return ""
                case .QuestionNine: return ""
                case .QuestionTen: return ""
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
                case .NilQuestion: return []
                case .QuestionOne: return ["h-bonding", "vanderwaals", "ionic"]
                case .QuestionTwo: return []
                case .QuestionThree: return []
                case .QuestionFour: return []
                case .QuestionFive: return []
                case .QuestionSix: return []
                case .QuestionSeven: return []
                case .QuestionEight: return []
                case .QuestionNine: return []
                case .QuestionTen: return []
            }
        }
    }
    
    var positions:[Position]{
        get {
            switch self {
            case .NilQuestion: return []
            case .QuestionOne: return [Position(x: 0.18, y: 0.81), Position(x: 0.54, y: 0.63), Position(x: 0.61, y: 0.41)]
            case .QuestionTwo: return []
            case .QuestionThree: return []
            case .QuestionFour: return []
            case .QuestionFive: return []
            case .QuestionSix: return []
            case .QuestionSeven: return []
            case .QuestionEight: return []
            case .QuestionNine: return []
            case .QuestionTen: return []
            }
        }
    }
    
    var facts:[String]{
        get {
            switch self{
            case .NilQuestion: return []
            case .QuestionOne: return["Fact 1"]
            case .QuestionTwo: return []
            case .QuestionThree: return []
            case .QuestionFour: return []
            case .QuestionFive: return []
            case .QuestionSix: return []
            case .QuestionSeven: return []
            case .QuestionEight: return []
            case .QuestionNine: return []
            case .QuestionTen: return []
                
            }
        }
    }
    
    static func getQuestions() ->[LevelThreeQuestion]{
        return [QuestionOne/*,QuestionTwo,QuestionThree,QuestionFour,QuestionFive,QuestionSix,
                QuestionSeven,QuestionEight,QuestionNine,QuestionTen*/,NilQuestion]
    }
    
}
