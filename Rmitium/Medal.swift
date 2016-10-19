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
    var newRecord = Bool()
    
    // Assign medal and messages for Level 1 and Level 3
    func assignMedal(level: Int) -> (medalName:String , information:[String], newRecord: Bool) {
        var score = 0.0
        percent = Double(UtilitiesPortal.score) / Double(UtilitiesPortal.totalQuestions)
        let scorePercent = round((percent) * 100) / 1
        //percent = 1
        var firstTime = -2
        
        // Level 1 and Level 3 - checking if this is the user's first time playing 
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
   
        // Assign the reward medal that is based on different score
        
        // If they score 100%
        if percent == 1 {
            medalName = "Medal1-Diamond"
            words = ["Congratulations!"]
            // if this is the user's first time playing
            if firstTime < 0 {
                words.append("Your knowledge is obviously crystal clear. You got \(Int(scorePercent))%!")
            }
            else {
                words.append("Your knowledge is obviously crystal clear. You got \(Int(scorePercent))%. Your best was \(Int(score))%!")
            }
        }
        if percent >= 0.9 && percent < 1 {
            medalName = "Medal2-Gold"
            words = ["Well done!"]
            if firstTime < 0 {
                words.append("Your chemistry prowess is gold standard. You got \(Int(scorePercent))%!")
            }
            else {
                words.append("Your chemistry prowess is gold standard. You got \(Int(scorePercent))%. Your best was \(Int(score))%!")
            }
        }
        if percent >= 0.7 && percent < 0.9 {
            medalName = "Medal3-Silver"
            words = ["Great work!"]
            if firstTime < 0 {
                words.append("With that sterling effort you got \(Int(scorePercent))%!")
            }
            else {
                words.append("With that sterling effort you got \(Int(scorePercent))%. Your best was \(Int(score))%!")
            }
        }
        if percent >= 0.5 && percent < 0.7 {
            medalName = "Medal4-Bronze"
            words = ["Nice try!"]
            if firstTime < 0 {
                words.append("You joined tin and copper with \(Int(scorePercent))%!")
            }
            else {
                words.append("You joined tin and copper with \(Int(scorePercent))%. Your best was \(Int(score))%!")
            }
        }
        if percent < 0.5 {
            medalName = "Medal5-Rust"
            words = ["Good effort!"]
            if firstTime < 0 {
                words.append("But your chemistry is a little rusty. You got \(Int(scorePercent))%!")
            }
            else {
                words.append("But your chemistry is a little rusty. You got \(Int(scorePercent))%. Your best was \(Int(score))%!")
            }
        }
        // Checking if the user has a new record
        if scorePercent > score || firstTime < 0 {
            newRecord = true
        }
        else {
            newRecord = false
        }
        return (medalName, words, newRecord)
    }
   
    // Assign medal image and messages for Level 2
    func level2(mode:String) -> (medalName:String , information:[String], newRecord: Bool) {
        var score = 0 // Current Record
        var message:String!
        var bestTime:String!
        var min = UtilitiesPortal.score/60
        var sec = UtilitiesPortal.score%60
        var firstTime = -2
        
        // Checking whether is the first time playing Level 2
        // Standard
        if mode == "stand" {
            score = DataHandler.getLevelTwoScore() as Int
            firstTime = DataHandler.getLevelTwoScore() as Int
        }
        // Time Trial
        if mode == "trial" {
            score = DataHandler.getLevelTwoTrialScore() as Int
            firstTime = DataHandler.getLevelTwoTrialScore() as Int
        }
        // Extreme
        if mode == "extreme" {
            score = DataHandler.getLevelTwoExtremeScore() as Int
            firstTime = DataHandler.getLevelTwoExtremeScore() as Int
            if UtilitiesPortal.score > 300{
                print("Time error")
            }else{
                min = (300 - UtilitiesPortal.score)/60
                sec = (300 - UtilitiesPortal.score)%60
            }
            
        }
        
        // Converting the score to seconds/minutes
        let scoreMin = score/60
        let scoreSec = score%60
        let result = UtilitiesPortal.score
        
        // Format the output of time
        if min == 0 {
            message = "You took \(sec) seconds."
        }
        else if min == 1 {
            message = "You took \(min) minute \(sec) seconds."
        }
        else if min > 1 {
            message = "You took \(min) minutes \(sec) seconds."
        }
        
        if scoreSec < 10 {
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
        
        print("first: \(firstTime), score: \(UtilitiesPortal.score))")
        
        // Standard
        
        if mode == "stand" {
            if UtilitiesPortal.score < 20 {
                medalName = "Medal1-Diamond"
                words = ["Congratulations!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }
            }
            if UtilitiesPortal.score < 30 && UtilitiesPortal.score >= 20 {
                medalName = "Medal2-Gold"
                words = ["Well done!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }
            }
            if UtilitiesPortal.score < 40 && UtilitiesPortal.score >= 30 {
                medalName = "Medal3-Silver"
                words = ["Great work!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }

            }
            if UtilitiesPortal.score < 60 && UtilitiesPortal.score >= 40 {
                medalName = "Medal4-Bronze"
                words = ["Nice try!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }

            }
            if UtilitiesPortal.score >= 60 {
                medalName = "Medal5-Rust"
                words = ["Good effort!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }

            }
            
            // Checking if the user has a new record
            if UtilitiesPortal.score < score || firstTime < 0{
                newRecord = true
            }
            else {
                newRecord = false
            }
        }
        
        // Time Trial
        
        if mode == "trial" {
            
            if UtilitiesPortal.score >= 150 {
                medalName = "Medal1-Diamond"
                words = ["Congratulations!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }

            }
            if UtilitiesPortal.score >= 120 && UtilitiesPortal.score < 150 {
                medalName = "Medal2-Gold"
                words = ["Well done!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }

            }
            if UtilitiesPortal.score >= 90 && UtilitiesPortal.score < 120 {
                medalName = "Medal3-Silver"
                words = ["Great work!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }
            }
            if UtilitiesPortal.score >= 60 && UtilitiesPortal.score < 90 {
                medalName = "Medal4-Bronze"
                words = ["Nice try!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }

            }
            if result < 60 {
                medalName = "Medal5-Rust"
                words = ["Good effort!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }

            }

            // Checking if the user has a new record
            if UtilitiesPortal.score > score || firstTime < 0 {
                newRecord = true
            }
            else {
                newRecord = false
            }
        }
        
        // Extreme
        
        if mode == "extreme" {
            if UtilitiesPortal.score >= 150 {
                medalName = "Medal1-Diamond"
                words = ["Congratulations!"]
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }

            }
            if UtilitiesPortal.score >= 120 && UtilitiesPortal.score < 150 {
                medalName = "Medal2-Gold"
                words = ["Well done!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }

            }
            if UtilitiesPortal.score >= 90 && UtilitiesPortal.score < 120 {
                medalName = "Medal3-Silver"
                words = ["Great work!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }

            }
            if UtilitiesPortal.score >= 60 && UtilitiesPortal.score < 90 {
                medalName = "Medal4-Bronze"
                words = ["Nice try!"]
              
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }

            }
            if result < 60 {
                medalName = "Medal5-Rust"
                words = ["Good effort!"]
                
                if firstTime < 0 {
                    words.append(message)
                }
                else {
                    words.append("\(message) Your best was \(bestTime)!")
                }

            }

            // Checking if the user has a new record
            if (UtilitiesPortal.level2ExtremeTime - UtilitiesPortal.score) < score || firstTime < 0 {
                newRecord = true
            }
            else {
                newRecord = false
            }
        }
        
        return (medalName, words, newRecord)
    }
}
