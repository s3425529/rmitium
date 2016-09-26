//
//  Medal.swift
//  Rmitium
//
//  Created by Max on 17/09/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
class medalClass {
    var percent: Float!
    var medalName: String!
    var words = [String]()
    var score = 0
    func assignMedal(level: Int) -> (medalName:String , information:[String]) {
        percent = Float(UtilitiesPortal.score) / Float(UtilitiesPortal.totalQuestions)
        //percent = 1
        
        if level == UtilitiesPortal.levelOne {
            score = DataHandler.getLevelOneScore() as Int
        }
        else if level == UtilitiesPortal.levelTwo {
            score = DataHandler.getLevelTwoScore() as Int
        }
        else if level == UtilitiesPortal.levelThree {
            score = DataHandler.getLevelThreeScore() as Int
        }
   
        let percentString = Int(percent*100)
        if percent == 1 {
            medalName = "Medal1-Diamond"
            words = ["Congratulations!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("A perfect score. Your chemistry knowledge is obviously crystal clear. Your best was \(score)!")
            }
            else {
                words.append("A perfect score. Your chemistry knowledge is obviously crystal clear. Your best was \(score)!")
            }
        }
        if percent >= 0.9 && percent < 1 {
            medalName = "Medal2-Gold"
            words = ["Well done!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("You got \(percentString)%. Your chemistry prowess is gold standard. Your best was \(score)!")
            }
            else {
                words.append("You got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your chemistry prowess is gold standard. Your best was \(score)!")
            }
        }
        if percent >= 0.7 && percent < 0.9 {
            medalName = "Medal3-Silver"
            words = ["Great work!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("With that sterling effort you got \(percentString)%. Your best was \(score)!")
            }
            else {
                words.append("With that sterling effort you got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your best was \(score)!")
            }
        }
        if percent >= 0.5 && percent < 0.7 {
            medalName = "Medal4-Bronze"
            words = ["Nice try!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("You joined tin and copper with \(percentString)%. Your best was \(score)!")
            }
            else {
                words.append("You joined tin and you got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your best was \(score)!")
            }
        }
        if percent < 0.5 {
            medalName = "Medal5-Rust"
            words = ["Good effort!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("But your chemistry is a little rusty. You got \(percentString)%. Your best was \(score)!")
            }
            else {
                words.append("But your chemistry is a little rusty. You got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your best was \(score)!")
            }
        }
        return (medalName, words)
    }
    func level2() -> (medalName:String , information:[String]){
        
      
        score = DataHandler.getLevelTwoScore() as Int
        let result = UtilitiesPortal.score
        if result < 20 {
            medalName = "Medal1-Diamond"
            words = ["Congratulations!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("2A perfect score. Your chemistry knowledge is obviously crystal clear. Your best was \(timeFormat(score))!")
            }
            else {
                words.append("1A perfect score. Your chemistry knowledge is obviously crystal clear. Your best was \(timeFormat(score))!")
            }
        }
        if result < 30 && result >= 20  {
            medalName = "Medal2-Gold"
            words = ["Well done!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("2You have taken \(timeFormat(result)). Your chemistry prowess is gold standard. Your best was \(timeFormat(score))!")
            }
            else {
                words.append("1You have taken \(timeFormat(result)). Your chemistry prowess is gold standard. Your best was \(timeFormat(score))!")
            }
        }
        if result < 40 && result >= 30 {
            medalName = "Medal3-Silver"
            words = ["Great work!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("2You have taken \(timeFormat(result)). Your best was \(timeFormat(score))!")
            }
            else {
                words.append("1You have taken \(timeFormat(result)). Your best was \(timeFormat(score))!")
            }
        }
        if result < 60 && result >= 40{
            medalName = "Medal4-Bronze"
            words = ["Nice try!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("2You have taken \(timeFormat(result)). Your best was \(timeFormat(score))!")
            }
            else {
                words.append("1You have taken \(timeFormat(result)). Your best was \(timeFormat(score))!")
            }
        }
        if result > 60 {
            medalName = "Medal5-Rust"
            words = ["Good effort!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("2You have taken \(timeFormat(result)). Your best was \(timeFormat(score))!")
            }
            else {
                words.append("1You have taken \(timeFormat(result)). Your best was \(timeFormat(score))!")
            }
        }
        return (medalName, words)
    }
    func  timeFormat(score:Int) -> String{
        let hour = score/3600
        let min = score/60
        let sec = score%60
        return"\(hour):\(min):\(sec)"
    }
}
