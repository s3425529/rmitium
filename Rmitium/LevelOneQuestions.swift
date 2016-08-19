//
//  LevelOneModel.swift
//  Rmitium
//
//  Created by Thinh Tran on 17/08/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation

enum LevelOneQuestion:Int
{
    init()
    {
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
        case 10: self = .QuestionTen
        default:
            return nil
        }
    }
    
    case QuestionOne=1, QuestionTwo, QuestionThree, QuestionFour, QuestionFive, QuestionSix, QuestionSeven,QuestionEight, QuestionNine, QuestionTen
    
    var name:String{
        get{
            
           switch self
           {
           case .QuestionOne: return "Question One"
           case .QuestionTwo: return "Question Two"
           case .QuestionThree: return "Question Three"
           case .QuestionFour: return "Question Four"
           case .QuestionFive: return "Question Five"
           case .QuestionSix: return "Question Six"
           case .QuestionSeven: return "Question Seven"
           case .QuestionEight: return "Question Eight"
           case .QuestionNine: return "Question Nine"
           case .QuestionTen: return "Question Ten"
            }
        }
    }
    
    var imageName:String
        {
        get
        {
            return self.name.stringByReplacingOccurrencesOfString(" ", withString: "", range: nil)
        }
        
    }
    
    var answers:[String]{
        get {
            switch self {
            case .QuestionOne: return ["Ether","Acid",]
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
    
    // func createQuestion()
    // func createQuestionList()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}