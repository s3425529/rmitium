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
        var score = 0.0
        percent = Float(UtilitiesPortal.score) / Float(UtilitiesPortal.totalQuestions)
        //percent = 1
        
        if level == UtilitiesPortal.levelOne {
            score = round(Double(DataHandler.getLevelOnePercentage()) * 10000) / 100
        }
        else if level == UtilitiesPortal.levelThree {
           score = round(Double(DataHandler.getLevelThreePercentage()) * 10000) / 100
        }
   
        //let percentString = Int(percent*100)
        if percent == 1 {
            medalName = "Medal1-Diamond"
            words = ["Congratulations!"]
            if score < Double(UtilitiesPortal.score)/Double(UtilitiesPortal.totalQuestions) {
                words.append("A perfect score. Your chemistry knowledge is obviously crystal clear. Your best was \(score)%!")
            }
            else {
                words.append("A perfect score. Your chemistry knowledge is obviously crystal clear.")
            }
        }
        if percent >= 0.9 && percent < 1 {
            medalName = "Medal2-Gold"
            words = ["Well done!"]
            if score < Double(UtilitiesPortal.score)/Double(UtilitiesPortal.totalQuestions) {
                words.append("You got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your best was \(score)%!")
            }
            else {
                words.append("You got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your chemistry prowess is gold standard.")
            }
        }
        if percent >= 0.7 && percent < 0.9 {
            medalName = "Medal3-Silver"
            words = ["Great work!"]
            if score < Double(UtilitiesPortal.score)/Double(UtilitiesPortal.totalQuestions) {
                words.append("With that sterling effort you got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your best was \(score)%!")
            }
            else {
                words.append("With that sterling effort you got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions).")
            }
        }
        if percent >= 0.5 && percent < 0.7 {
            medalName = "Medal4-Bronze"
            words = ["Nice try!"]
            if score < Double(UtilitiesPortal.score)/Double(UtilitiesPortal.totalQuestions) {
                words.append("You joined tin and you got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your best was \(score)%!")
            }
            else {
                words.append("You joined tin and you got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions).")
            }
        }
        if percent < 0.5 {
            medalName = "Medal5-Rust"
            words = ["Good effort!"]
            if score < Double(UtilitiesPortal.score)/Double(UtilitiesPortal.totalQuestions) {
                words.append("But your chemistry is a little rusty. You got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions). Your best was \(score)%!")
            }
            else {
                words.append("But your chemistry is a little rusty. You got \(UtilitiesPortal.score) out of \(UtilitiesPortal.totalQuestions).")
            }
        }
        return (medalName, words)
    }
   
    func level2(mode:String) -> (medalName:String , information:[String]) {
        var score = 0
        var message:String!
        var bestTime:String!
        let min = UtilitiesPortal.score/60
        let sec = UtilitiesPortal.score%60
        if mode == "stand"{
            score = DataHandler.getLevelTwoScore() as Int
        }
        if mode == "trial"{
            score = DataHandler.getLevelTwoTrialScore() as Int
        }
        if mode == "beat"{
            score = DataHandler.getLevelTwoBeatScore() as Int
        
        }
        
        let scoreMin = score/60
        let scoreSec = score%60
        let result = UtilitiesPortal.score
        
        if min == 0 {
            message = "You took \(sec) seconds."
        }
        else {
        
            message = "You took \(min) minutes \(sec) seconds."
        }
        
        if  scoreSec < 10 {
            if scoreSec == -1 {
            
                bestTime = "\(scoreMin):00"
            }
            else {
                bestTime = "\(scoreMin):0\(scoreSec)"
            }
        }
        else {
            bestTime = "\(scoreMin):\(scoreSec)"
        }
        if mode == "stand" {
            if UtilitiesPortal.score < 20 {
                medalName = "Medal1-Diamond"
                
                if score > UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("A perfect score.  Your best was \(bestTime).")
                }
                else {
                    words = ["Congratulations!"]
                    words.append("\(message) Your chemistry knowledge is obviously crystal clear.")
                }
            }
            if UtilitiesPortal.score < 30 && UtilitiesPortal.score >= 20 {
                medalName = "Medal2-Gold"
                words = ["Well done!"]
                if score > UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("\(message) Your best was \(bestTime).")
                }
                else {
                    words.append("\(message) Your chemistry prowess is gold standard.")
                }
            }
            if UtilitiesPortal.score < 40 && UtilitiesPortal.score >= 30 {
                medalName = "Medal3-Silver"
                words = ["Great work!"]
                if score > UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("\(message) Your best was \(bestTime).")
                }
                else {
                    words.append("\(message)")
                }
            }
            if UtilitiesPortal.score < 60 && UtilitiesPortal.score >= 40 {
                medalName = "Medal4-Bronze"
                words = ["Nice try!"]
                if score > UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("\(message) Your best was \(bestTime).")
                }
                else {
                    words.append("\(message)")
                }
            }
            if UtilitiesPortal.score >= 60 {
                medalName = "Medal5-Rust"
                words = ["Good effort!"]
                if score > UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("\(message) Your best was \(bestTime).")
                }
                else {
                    words.append("\(message)")
                }
            }
        }
        
        if mode == "trial" {
            
            if UtilitiesPortal.score >= 150 {
                medalName = "Medal1-Diamond"
                                if score < UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("A perfect score. Your best was \(bestTime).")
                }
                else {
                    words = ["Congratulations!"]
                    words.append("\(message) Your chemistry knowledge is obviously crystal clear.")
                }
            }
            if UtilitiesPortal.score >= 120 && UtilitiesPortal.score < 150 {
                medalName = "Medal2-Gold"
                
                if score < UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("\(message) Your best was \(bestTime).")
                }
                else {
                    words = ["Well done!"]
                    words.append("\(message) Your chemistry prowess is gold standard.")
                }
            }
            if UtilitiesPortal.score >= 90 && UtilitiesPortal.score < 120 {
                medalName = "Medal3-Silver"
                
                if score < UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("\(message) Your best was \(bestTime).")
                }
                else {
                    words = ["Great work!"]
                    words.append("\(message)")
                }
            }
            if UtilitiesPortal.score >= 60 && UtilitiesPortal.score < 90 {
                medalName = "Medal4-Bronze"
                
                if score < UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("\(message) Your best was \(bestTime).")
                }
                else {
                    words = ["Nice try!"]
                    words.append("\(message)")
                }
            }
            if result < 60 {
                medalName = "Medal5-Rust"
                
                if score < UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("\(message) Your best was \(bestTime).")
                }
                else {
                    words = ["Good effort!"]
                    words.append("\(message)")
                }
            }
        }
        
        if mode == "beat" {
            if UtilitiesPortal.score >= 150 {
                medalName = "Medal1-Diamond"
                
                if score > UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("A perfect score. Your chemistry knowledge is obviously crystal clear. Your best was \(bestTime).")
                }
                else {
                    words = ["Congratulations!"]
                    words.append("\(message) Your chemistry knowledge is obviously crystal clear.")
                }
            }
            if UtilitiesPortal.score >= 120 && UtilitiesPortal.score < 150 {
                medalName = "Medal2-Gold"
                
                if score > UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("\(message) Your chemistry prowess is gold standard. Your best was \(bestTime)")
                }
                else {
                    words = ["Well done!"]
                    words.append("\(message) Your chemistry prowess is gold standard.")
                }
            }
            if UtilitiesPortal.score >= 90 && UtilitiesPortal.score < 120 {
                medalName = "Medal3-Silver"
                
                if score > UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("\(message) Your best was \(bestTime).")
                }
                else {
                    words = ["Great work!"]
                    words.append("\(message)")
                }
            }
            if UtilitiesPortal.score >= 60 && UtilitiesPortal.score < 90 {
                medalName = "Medal4-Bronze"
              
                if score > UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("\(message) Your best was \(bestTime).")
                }
                else {
                    words = ["Nice try!"]
                    words.append("\(message)")
                }
            }
            if result < 60 {
                medalName = "Medal5-Rust"
                
                if score > UtilitiesPortal.score {
                    words = ["New record!"]
                    words.append("\(message) Your best was \(bestTime).")
                }
                else {
                    words = ["Good effort!"]
                    words.append("\(message)")
                }
            }
        }
        
        return (medalName, words)
    }
}
