//
//  DataHandler.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/10/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation

class DataHandler {
    let totalQuestions = 1;
    var questions: [Question]
    
    init() {
        questions = []
        
        let q01 = Question(imgQuestion: "test_ans", imgAnswer: "test_sol")
        
        q01.addFact("Fact 1 aaaaaaaaaaaa")
        q01.addFact("Fact 2 bbbbbbbbbbbb")
        q01.addFact("Fact 3 cccccccccccc")
        
        q01.addPosition(Position(x:0.38, y:0.75))
        q01.addPosition(Position(x:0.18, y:0.47))
        q01.addPosition(Position(x:0.68, y:0.42))
        q01.addPosition(Position(x:0.15, y:0.29))
        q01.addPosition(Position(x:0.59, y:0.25))
        
        questions.append(q01)
    }
}