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
    
    case NilQuestion=0, QuestionOne, QuestionTwo, QuestionThree, QuestionFour, QuestionFive, QuestionSix, QuestionSeven, QuestionEight, QuestionNine, QuestionTen
    
    var imageName:String{
        get{
            
            switch self
            {
                case .NilQuestion: return "nil"
                case .QuestionOne: return "L3-S1-morphine-final"
                case .QuestionTwo: return "L3-S2-acetone-final"
                case .QuestionThree: return "L3-S3-coniine-final"
                case .QuestionFour: return "L3-S4-muscarine-final"
                case .QuestionFive: return "L3-S5-cadaverine-final"
                case .QuestionSix: return "L3-S6-piperine-final"
                case .QuestionSeven: return "L3-S7-diethylether-final"
                case .QuestionEight: return "L3-S8-Vanillin-final"
                case .QuestionNine: return "L3-S9-capsaicin-final"
                case .QuestionTen: return "L3-S10-aceticacid-final"
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
                case .QuestionTwo: return ["dipole-dipole"]
                case .QuestionThree: return ["h-bonding"]
                case .QuestionFour: return ["ionic", "h-bonding"]
                case .QuestionFive: return ["h-bonding", "h-bonding"]
                case .QuestionSix: return ["vanderwaals", "vanderwaals"]
                case .QuestionSeven: return ["dipole-dipole"]
                case .QuestionEight: return ["h-bonding", "van ser Waal's", "dipole-dipole"]
                case .QuestionNine: return ["h-bonding", "dipole-dipole", "h-bonding", "vanderwaals", "vanderwaals"]
                case .QuestionTen: return ["h-bonding"]
            }
        }
    }
    
    var positions:[Position]{
        get {
            switch self {
            case .NilQuestion: return []
            case .QuestionOne: return [Position(x: 0.18, y: 0.81), Position(x: 0.54, y: 0.63), Position(x: 0.61, y: 0.41)]
            case .QuestionTwo: return [Position(x:0.37, y:0.52)]
            case .QuestionThree: return [Position(x:0.47, y:0.62)]
            case .QuestionFour: return [Position(x:0.16, y:0.79), Position(x:0.56, y:0.22)]
            case .QuestionFive: return [Position(x:0.15, y:0.67), Position(x:0.59, y:0.29)]
            case .QuestionSix: return [Position(x:0.30, y:0.73), Position(x:0.21, y:0.27)]
            case .QuestionSeven: return [Position(x:0.44, y:0.50)]
            case .QuestionEight: return [Position(x:0.16, y:0.76),Position(x:0.43, y:0.71),Position(x:0.55, y:0.23)]
            case .QuestionNine: return [Position(x:0.42, y:0.78),Position(x:0.58, y:0.76),Position(x:0.11, y:0.64),Position(x:0.37, y:0.52),Position(x:0.41, y:0.36)]
            case .QuestionTen: return [Position(x:0.33, y:0.37)]
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
        return [QuestionOne, QuestionTwo, QuestionThree, QuestionFour, QuestionFive, QuestionSix,
                QuestionSeven, QuestionEight, QuestionNine, QuestionTen, NilQuestion]
    }
    
}
