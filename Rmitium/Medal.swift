//
//  Medal.swift
//  Rmitium
//
//  Created by Max on 17/09/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
class medalClass {
    var percent: Double!
    var medalName: String!
    var words = [String]()
    
    func assignMedal(level: Int) -> (medalName:String , information:[String]) {
        var score = 0.0
        percent = Double(UtilitiesPortal.score) / Double(UtilitiesPortal.totalQuestions)
        let scorePercent = round((percent) * 10000) / 100
        //percent = 1
        var firstTime = -2
        if level == UtilitiesPortal.levelOne {
            firstTime = DataHandler.getLevelOneScore() as Int
        }
        else if level == UtilitiesPortal.levelThree {
            firstTime = DataHandler.getLevelThreeScore() as Int
        }
        
        if level == UtilitiesPortal.levelOne {
            score = round(Double(DataHandler.getLevelOnePercentage()) * 100) / 1
        }
        else if level == UtilitiesPortal.levelThree {
           score = round(Double(DataHandler.getLevelThreePercentage()) * 100) / 1
        }
   
        //let percentString = Int(percent*100)
        if percent == 1 {
            medalName = "Medal1-Diamond"
            words = ["Congratulations!"]
            // New record - beating your previous best score
            if score < percent {
                words.append("Your knowledge is obviously crystal clear. You got \(Int(scorePercent))%.")
            }
            else {
                // First time playing the level
                if firstTime < 0 {
                    words.append("Your knowledge is obviously crystal clear. You got \(Int(scorePercent))%!")
                }
                else {
                    words.append("Your knowledge is obviously crystal clear. You got \(Int(scorePercent))%. Your best was \(Int(score))%!")
                }
            }
        }
        if percent >= 0.9 && percent < 1 {
            medalName = "Medal2-Gold"
            words = ["Well done!"]
            if score < percent {
                words.append("Your chemistry prowess is gold standard. You got \(Int(scorePercent))%!")
            }
            else {
                if firstTime < 0 {
                    words.append("Your chemistry prowess is gold standard. You got \(Int(scorePercent))%!")
                }
                else {
                    words.append("Your chemistry prowess is gold standard. You got \(Int(scorePercent))%. Your best was \(Int(score))%!")
                }
            }
        }
        if percent >= 0.7 && percent < 0.9 {
            medalName = "Medal3-Silver"
            words = ["Great work!"]
            if score < percent {
                words.append(" With that sterling effort you got \(Int(scorePercent))%!")
            }
            else {
                if firstTime < 0 {
                    words.append("With that sterling effort you got \(Int(scorePercent))%!")
                }
                else {
                    words.append("With that sterling effort you got \(Int(scorePercent))%. Your best was \(Int(score))%!")
                }
            }
        }
        if percent >= 0.5 && percent < 0.7 {
            medalName = "Medal4-Bronze"
            words = ["Nice try!"]
            if score < percent {
                words.append("You joined in and got \(Int(scorePercent))%!")
            }
            else {
                if firstTime < 0 {
                    words.append("You joined tin and got \(Int(scorePercent))%!")
                }
                else {
                    words.append("You joined tin and got \(Int(scorePercent))%. Your best was \(Int(score))%!")
                }
            }
        }
        if percent < 0.5 {
            medalName = "Medal5-Rust"
            words = ["Good effort!"]
            if score < percent {
                words.append("But your chemistry is a little rusty. You got \(Int(scorePercent))%!")
            }
            else {
                if firstTime < 0 {
                    words.append("But your chemistry is a little rusty. You got \(Int(scorePercent))%!")
                }
                else {
                    words.append("But your chemistry is a little rusty. You got \(Int(scorePercent))%. Your best was \(Int(score))%!")
                }
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
        if mode == "stand" {
            score = DataHandler.getLevelTwoScore() as Int
        }
        if mode == "trial" {
            score = DataHandler.getLevelTwoTrialScore() as Int
        }
        if mode == "beat" {
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
                    words.append("A perfect score. Your best was \(bestTime).")
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
                    words.append("\(message) Your best was \(bestTime).")
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
                    words.append("\(message) Your best was \(bestTime).")
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
                    words.append("\(message) Your best was \(bestTime).")
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
                    words.append("\(message) Your best was \(bestTime).")
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
                    words.append("\(message) Your best was \(bestTime).")
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
                    words.append("\(message) Your best was \(bestTime).")
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
                    words.append("\(message) Your best was \(bestTime).")
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
                    words.append("\(message) Your best was \(bestTime).")
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
                    words.append("\(message) Your best was \(bestTime).")
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
