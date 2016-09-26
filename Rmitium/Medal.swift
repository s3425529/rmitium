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
   
        //let percentString = Int(percent*100)
        if percent == 1 {
            medalName = "Medal1-Diamond"
            words = ["Congratulations!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("A perfect score. Your chemistry knowledge is obviously crystal clear. Your best was \(score)!")
            }
            else {
                words.append("A perfect score. Your chemistry knowledge is obviously crystal clear.")
            }
        }
        if percent >= 0.9 && percent < 1 {
            medalName = "Medal2-Gold"
            words = ["Well done!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("You got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your best was \(score)!")
            }
            else {
                words.append("You got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your chemistry prowess is gold standard.")
            }
        }
        if percent >= 0.7 && percent < 0.9 {
            medalName = "Medal3-Silver"
            words = ["Great work!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("With that sterling effort you got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your best was \(score)!")
            }
            else {
                words.append("With that sterling effort you got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions).")
            }
        }
        if percent >= 0.5 && percent < 0.7 {
            medalName = "Medal4-Bronze"
            words = ["Nice try!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("You joined tin and you got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your best was \(score)!")
            }
            else {
                words.append("You joined tin and you got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions).")
            }
        }
        if percent < 0.5 {
            medalName = "Medal5-Rust"
            words = ["Good effort!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("But your chemistry is a little rusty. you got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your best was \(score)!")
            }
            else {
                words.append("But your chemistry is a little rusty. You got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions).")
            }
        }
        return (medalName, words)
    }
    func level2() -> (medalName:String , information:[String]){
        
        let min = UtilitiesPortal.score/60
        let sec = UtilitiesPortal.score%60
        score = DataHandler.getLevelTwoScore() as Int
        let scoreMin = score/60
        let scireSec = score%60
        let result = UtilitiesPortal.score
        if result < 20 {
            medalName = "Medal1-Diamond"
            words = ["Congratulations!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("2A perfect score. Your chemistry knowledge is obviously crystal clear. Your best was \(scoreMin):\(scireSec)")
            }
            else {
                words.append("1A perfect score. Your chemistry knowledge is obviously crystal clear.")
            }
        }
        if result < 30 && result >= 20  {
            medalName = "Medal2-Gold"
            words = ["Well done!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("You took \(min) minutes \(sec) seconds. Your chemistry prowess is gold standard. Your best was \(scoreMin):\(scireSec)")
            }
            else {
                words.append("You took \(min) minutes \(sec) seconds. Your chemistry prowess is gold standard.")
            }
        }
        if result < 40 && result >= 30 {
            medalName = "Medal3-Silver"
            words = ["Great work!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("You took \(min) minutes \(sec) seconds. Your best was \(scoreMin):\(scireSec)")
            }
            else {
                words.append("You took \(min) minutes \(sec) seconds.")
            }
        }
        if result < 60 && result >= 40{
            medalName = "Medal4-Bronze"
            words = ["Nice try!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("You took \(min) minutes \(sec) seconds. Your best was \(scoreMin):\(scireSec)")
            }
            else {
                words.append("You took \(min) minutes \(sec) seconds.")
            }
        }
        if result > 60 {
            medalName = "Medal5-Rust"
            words = ["Good effort!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("You took \(min) minutes \(sec) seconds. Your best was \(scoreMin):\(scireSec)")
            }
            else {
                words.append("You took \(min) minutes \(sec) seconds.")
            }
        }
        return (medalName, words)
    }
 
}
