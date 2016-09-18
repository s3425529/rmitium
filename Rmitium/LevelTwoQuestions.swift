//
//  LevelTwoQuestions.swift
//  Rmitium
//
//  Created by Max on 15/09/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

enum LevelTwoQuestion:Int {
    
    init()
    {
        self = .p01
    }
    
    init?(number:Int)
    {
        switch number
        {
        case 0: self = .NilQuestion
        case 1: self = .p01
        case 2: self = .p02
        case 3: self = .p03
        case 4: self = .p04
        case 5: self = .p05
        case 6: self = .p06
        case 7: self = .p07
        case 8: self = .p08
        case 9: self = .p09
        case 10: self = .p10
        case 11: self = .p11
        case 12: self = .p12
        case 13: self = .p13
        case 14: self = .p14
        default: return nil
        }
    }
    
    case NilQuestion=0, p01, p02, p03, p04, p05, p06, p07, p08, p09, p10, p11, p12, p13, p14
    
    var imageName:String {
        get {
            switch self
            {
            case .NilQuestion: return "nil"
            case .p01: return "1alcohol1"
            case .p02: return "1alcohol2"
            case .p03: return "1alkyl1"
            case .p04: return "1alkyl2"
            case .p05: return "1amine1"
            case .p06: return "1amine2"
            case .p07: return "2alcohol1"
            case .p08: return "2alcohol2"
            case .p09: return "2amine1"
            case .p10: return "2amine2"
            case .p11: return "3alcohol1"
            case .p12: return "3alcohol2"
            case .p13: return "3amine1"
            case .p14: return "3amine2"
            }
        }
    }
    
    static func getQuestions() ->[LevelTwoQuestion] {
        return [p01, p02, p03, p04, p05, p06, p07, p08, p09, p10, p11, p12, p13, p14, NilQuestion]
    }
    
}
