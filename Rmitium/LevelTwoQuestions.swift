//
//  LevelTwoQuestions.swift
//  Rmitium
//
//  Created by Max on 15/09/2016.
//  Copyright © 2016 Spencer and Jones. All rights reserved.
//

import Foundation

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
        case 15: self = .p15
        case 16: self = .p16
        case 17: self = .p17
        case 18: self = .p18
        case 19: self = .p19
        case 20: self = .p20
        case 21: self = .p21
        case 22: self = .p22
        case 23: self = .p23
        case 24: self = .p24
        default: return nil
        }
    }
    
    case NilQuestion=0, p01, p02, p03, p04, p05, p06, p07, p08, p09, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24
    
    /*var imageName:String {
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
    }*/
    /*
    var imageName:String {
        get {
            switch self
            {
            case .NilQuestion: return "nil"
            case .p01:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "1-amine-1-\(random)"
            case .p02: return "1-amine-2-0"
            case .p03:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "1-amine-1-\(random)"
            case .p04: return "1-amine-2-0"
            case .p05:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "1-amine-1-\(random)"
            case .p06: return "1-amine-2-0"
            case .p07:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "1-amine-1-\(random)"
            case .p08: return "1-amine-2-0"
            case .p09:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "1-amine-1-\(random)"
            case .p10: return "1-amine-2-0"
            case .p11:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "1-amine-1-\(random)"
            case .p12: return "1-amine-2-0"
            case .p13:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "1-amine-1-\(random)"
            case .p14: return "1-amine-2-0"
            default: return "nil"
            }
        }
    }*/
    
    var imageName:String {
        get {
            switch self
            {
            case .NilQuestion: return "nil"
            case .p01:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "1-amine-1-\(random)"
            case .p02: return "1-amine-2-0"
            case .p03:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "2-amine-1-\(random)"
            case .p04: return "2-amine-2-0"
                
            case .p05:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "3-amine-1-\(random)"
            case .p06: return "3-amine-2-0"
            case .p07:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "1-alcohol-1-\(random)"
            case .p08: return "1-alcohol-2-0"
            case .p09:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "2-alcohol-1-\(random)"
            case .p10: return "2-alcohol-2-0"
            case .p11:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "3-alcohol-1-\(random)"
            case .p12: return "3-alcohol-2-0"
                
            case .p13:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "1-alkyl-1-\(random)"
            case .p14: return "1-alkyl-2-0"
            case .p15:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "2-alkyl-1-\(random)"
            case .p16: return "2-alkyl-2-0"
            case .p17:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "3-alkyl-1-\(random)"
            case .p18: return "3-alkyl-2-0"
                
            case .p19:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "1-carbo-1-\(random)"
            case .p20: return "1-carbo-2-0"
            case .p21:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "2-carbo-1-\(random)"
            case .p22: return "2-carbo-2-0"
            case .p23:
                let random = Int(arc4random_uniform(UInt32(4)))+1
                return "3-carbo-1-\(random)"
            case .p24: return "3-carbo-2-0"
            }
        }
    }
    
    static func getQuestions() ->[LevelTwoQuestion] {
        return [p01, p02, p03, p04, p05, p06, p07, p08, p09, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, NilQuestion]
    }/*
    static func getQuestions() ->[LevelTwoQuestion] {
        return [p01, p02, p03, p04, p05, p06, p07, p08, p09, p10, p11, p12, p13, p14, NilQuestion]
    }*/
    
}
