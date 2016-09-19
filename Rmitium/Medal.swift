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
    
    func assignMedal(level: Int) -> (medalName:String , information:[String]) {
        percent = Float(UtilitiesPortal.score) / Float(UtilitiesPortal.totalQuestions)
        
        var score = 0
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
                words.append("A perfect score. Your chemistry knowledge is obviously crystal clear. Your last record is \(score)!")
            }
            else {
                words.append("A perfect score. Your chemistry knowledge is obviously crystal clear.")
            }
        }
        if percent >= 0.9 && percent < 1 {
            medalName = "Medal2-Gold"
            words = ["Well done!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("You got \(percentString)%. Your chemistry prowess is gold standard. Your last record is \(score)!")
            }
            else {
                words.append("You got \(percentString)%. Your chemistry prowess is gold standard.")
            }
        }
        if percent >= 0.7 && percent < 0.9 {
            medalName = "Medal3-Silver"
            words = ["Great work!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("With that sterling effort you got \(percentString)%. Your last record is \(score)!")
            }
            else {
                words.append("With that sterling effort you got \(percentString)%.")
            }
        }
        if percent >= 0.5 && percent < 0.7 {
            medalName = "Medal4-Bronze"
            words = ["Nice try!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("You joined tin and copper with \(percentString)%. Your last record is \(score)!")
            }
            else {
                words.append("You joined tin and copper with \(percentString)%.")
            }
        }
        if percent < 0.5 {
            medalName = "Medal5-Rust"
            words = ["Good effort!"]
            if score > UtilitiesPortal.defaultScore {
                words.append("But your chemistry is a little rusty. You got \(percentString)%. Your last record is \(score)!")
            }
            else {
                words.append("But your chemistry is a little rusty. You got \(percentString)%.")
            }
        }
        return (medalName, words)
    }
}
