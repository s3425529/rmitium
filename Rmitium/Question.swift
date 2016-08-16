//
//  Question.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/17/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation

class Question {
    var imgQuestion: String
    var imgAnswer: String
    var facts: [String]
    var positions: [Position]
    
    init(imgQuestion: String, imgAnswer: String) {
        self.imgQuestion = imgQuestion
        self.imgAnswer = imgAnswer
        facts = []
        positions = []
    }
    
    func addFact(fact: String) {
        facts.append(fact)
    }
    
    func addPosition(position: Position) {
        positions.append(position)
    }
}