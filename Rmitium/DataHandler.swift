//
//  DataHandler.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/10/16.
//  Copyright © 2016 RMIT. All rights reserved.
//

import CoreData
import Foundation

class DataHandler {
    class var sharedInstance: DataHandler {
        struct Static {
            static let instance = DataHandler()
        }
        return Static.instance
    }
    static var settings = DataController().managedObjectContext
    static var localSetting: Settings = DataHandler.getSettings()
    
    static func initSettings() {
        if checkDataIsEmpty() {
            let entity = NSEntityDescription.insertNewObjectForEntityForName("Settings", inManagedObjectContext: settings) as! Settings
            entity.setValue(true, forKey: "sound")
            entity.setValue(true, forKey: "rightHand")
            entity.setValue(true, forKey: "effect")
            entity.setValue(-2, forKey: "levelOne")
            entity.setValue(-2, forKey: "levelTwo")
            entity.setValue(-2, forKey: "levelThree")
            entity.setValue(-2, forKey: "levelTwoTrial")
            entity.setValue(-2, forKey: "levelTwoBeat")
            entity.setValue(0, forKey: "levelOneScore")
            entity.setValue(0, forKey: "levelThreeScore")
            do {
                try settings.save()
                //localSetting = entity
            }
            catch {
                fatalError("Failure to save Settings: \(error)")
            }
        }
    }
    
    static func resetSettings() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            object.setValue(true, forKey: "sound")
            object.setValue(true, forKey: "rightHand")
            object.setValue(true, forKey: "effect")
            object.setValue(-2, forKey: "levelOne")
            object.setValue(-2, forKey: "levelTwo")
            object.setValue(-2, forKey: "levelThree")
            object.setValue(-2, forKey: "levelTwoTrial")
            object.setValue(-2, forKey: "levelTwoBeat")
            object.setValue(0, forKey: "levelOneScore")
            object.setValue(0, forKey: "levelThreeScore")
            try settings.save()
            //localSetting = object
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func resetScores() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            print("Scores: \(object.levelOne), \(object.levelTwo), \(object.levelThree)")
            object.setValue(-1, forKey: "levelOne")
            object.setValue(-1, forKey: "levelTwo")
            object.setValue(-1, forKey: "levelThree")
            object.setValue(-1, forKey: "levelTwoTrial")
            object.setValue(-1, forKey: "levelTwoBeat")
            object.setValue(0, forKey: "levelOneScore")
            object.setValue(0, forKey: "levelThreeScore")
            try settings.save()
            
            
            let result1 = try settings.executeFetchRequest(setting) as! [Settings]
            let object1 = result1.first!
            print("Reset to: \(object1.levelOne), \(object1.levelTwo), \(object1.levelThree)")
            //localSetting = result1.first!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func resetToDefault() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            print("Scores: \(object.levelOne), \(object.levelTwo), \(object.levelThree)")
            object.setValue(-2, forKey: "levelOne")
            object.setValue(-2, forKey: "levelTwo")
            object.setValue(-2, forKey: "levelThree")
            object.setValue(-2, forKey: "levelTwoTrial")
            object.setValue(-2, forKey: "levelTwoBeat")
            object.setValue(0, forKey: "levelOneScore")
            object.setValue(0, forKey: "levelThreeScore")
            try settings.save()
            
            
            let result1 = try settings.executeFetchRequest(setting) as! [Settings]
            let object1 = result1.first!
            print("Reset to: \(object1.levelOne), \(object1.levelTwo), \(object1.levelThree)")
            //localSetting = result1.first!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func getSettings() -> Settings {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            print("Lvl 1 Score: \(result.first!.levelOne)")
            print("Lvl 1 Percent: \(result.first!.levelOneScore)")
            print("Lvl 3 Score: \(result.first!.levelThree)")
            print("Lvl 3 Percent: \(result.first!.levelThreeScore)")
            print("Lvl 2 Standard: \(result.first!.levelTwo)")
            print("Lvl 2 Trial: \(result.first!.levelTwoTrial)")
            print("Lvl 2 Extreme: \(result.first!.levelTwoBeat)")
            return result.first!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func getLocalSetting() -> Settings {
        return localSetting
    }
    
    // Level One
    static func getLevelOneScore() -> NSNumber {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            return result.first!.levelOne!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func getLevelOnePercentage() -> NSNumber {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            return result.first!.levelOneScore!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func saveLevelOneFirstTime() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            object.setValue(UtilitiesPortal.firstResult, forKey: "levelOne")
            try settings.save()
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func saveLevelOneFirstResult() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            object.setValue(UtilitiesPortal.defaultScore, forKey: "levelOne")
            try settings.save()
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func saveLevelOneScore() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first! 
            let oldScore = object.levelOne as! Int
           
            if oldScore < UtilitiesPortal.score {
                object.setValue(UtilitiesPortal.score, forKey: "levelOne")
                try settings.save()
            }
            
            let percentage = object.levelOneScore! as Double
            let newPercent = Double(UtilitiesPortal.score)/Double(UtilitiesPortal.totalQuestions)
            if percentage < newPercent {
                object.setValue(newPercent, forKey: "levelOneScore")
                try settings.save()
            }
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    // Level Two
    static func getLevelTwoScore() -> NSNumber {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            return result.first!.levelTwo!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func saveLevelTwoFirstTime(mode: String) {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            
            if mode == UtilitiesPortal.modeLabelTexts[0] {
                if object.levelTwo == UtilitiesPortal.firstTime {
                    object.setValue(UtilitiesPortal.firstResult, forKey: "levelTwo")
                }
            }
            if mode == UtilitiesPortal.modeLabelTexts[1] {
                if object.levelTwoTrial == UtilitiesPortal.firstTime {
                    object.setValue(UtilitiesPortal.firstResult, forKey: "levelTwoTrial")
                }
            }
            if mode == UtilitiesPortal.modeLabelTexts[2] {
                if object.levelTwoBeat == UtilitiesPortal.firstTime {
                    object.setValue(UtilitiesPortal.firstResult, forKey: "levelTwoBeat")
                }
            }
            try settings.save()
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func saveLevelTwoScore() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            let x = object.levelTwo as! Int
            if x < 0 || UtilitiesPortal.score < x {
                object.setValue(UtilitiesPortal.score, forKey: "levelTwo")
                try settings.save()
            }
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    //level2  Trial
    static func getLevelTwoTrialScore() -> NSNumber {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            return result.first!.levelTwoTrial!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func saveLevelTwoTrialScore() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            let x = object.levelTwoTrial as! Int
            if  x < UtilitiesPortal.score {
                object.setValue(UtilitiesPortal.score, forKey: "levelTwoTrial")
                try settings.save()
            }
            
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }

    //level2 beat
    
    static func getLevelTwoBeatScore() -> NSNumber {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            return result.first!.levelTwoBeat!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func saveLevelTwoBeatScore() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            let x = object.levelTwoBeat as! Int
            print("Extreme: old: \(x), current: \(UtilitiesPortal.score)")
            if x < UtilitiesPortal.score {
                object.setValue(UtilitiesPortal.score, forKey: "levelTwoBeat")
                try settings.save()
            }
            
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }

    
    // Level Three
    static func getLevelThreeScore() -> NSNumber {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            return result.first!.levelThree!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func getLevelThreePercentage() -> NSNumber {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            return result.first!.levelThreeScore!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func saveLevelThreeFirstTime() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            object.setValue(UtilitiesPortal.firstResult, forKey: "levelThree")
            try settings.save()
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func saveLevelThreeFirstResult() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            object.setValue(UtilitiesPortal.defaultScore, forKey: "levelThree")
            try settings.save()
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func saveLevelThreeScore() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            let oldScore = object.levelThree as! Int
            
            if oldScore < UtilitiesPortal.score{
                object.setValue(UtilitiesPortal.score, forKey: "levelThree")
                try settings.save()
            }
            
            let percentage = object.levelThreeScore! as Double
            let newPercent = Double(UtilitiesPortal.score)/Double(UtilitiesPortal.totalQuestions)
            if percentage < newPercent {
                object.setValue(newPercent, forKey: "levelThreeScore")
                try settings.save()
            }
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func checkDataIsEmpty() -> Bool {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            print("Database count: \(result.count)")
            return result.count == 0
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func updateSettings(values: [Bool]) {
        if values.count != 3 {
            print("Settings fails with count: \(values.count)")
            return
        }
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            object.setValue(values[0], forKey: "sound")
            object.setValue(values[1], forKey: "effect")
            object.setValue(values[2], forKey: "rightHand")
            try settings.save()
            print("Trying to Save value: Sound(\(values[0])), Effect(\(values[1]), RightHand(\(values[2]))")
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
        
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            print("Load value: Sound(\(result.first!.getSound)), Effect(\(result.first!.getEffect), RightHand(\(result.first!.getRightHand))")
            localSetting = result.first!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func getScore(level: Int) -> NSNumber {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            if level == UtilitiesPortal.levelOne {
                return result.first!.levelOne!
            }
            else if level == UtilitiesPortal.levelTwo {
                return result.first!.levelTwo!
            }
            else if level == UtilitiesPortal.levelThree {
                return result.first!.levelThree!
            }
            else {
                return 0;
            }
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func getMedal(level: Int, mode: Int) -> String {
        let setting = NSFetchRequest(entityName: "Settings")
        var score = 0.0
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            if level == UtilitiesPortal.levelOne {
                score = result.first!.levelOneScore! as Double
            }
            else if level == UtilitiesPortal.levelThree {
                score = result.first!.levelThreeScore! as Double
            }
            else {
                if mode == UtilitiesPortal.modeStandard {
                    score = Double((result.first?.levelTwo)!)
                    if score < 20  && score > 0 {
                        return "Medal1-Diamond"
                    }
                    else if score < 30 && score >= 20 {
                        return "Medal2-Gold"
                    }
                    else if score < 40 && score >= 30 {
                        return "Medal3-Silver"
                    }
                    else if score < 60 && score >= 40 {
                        return "Medal4-Bronze"
                    }
                    else if score >= 60 {
                        return "Medal5-Rust"
                    }
                    else {
                        return ""
                    }
                    
                }
                else if mode == UtilitiesPortal.modeTrial {
                    score = Double((result.first?.levelTwoTrial)!)
                    if score >= 150 {
                        return "Medal1-Diamond"
                    }
                    if score >= 120 && score < 150 {
                        return "Medal2-Gold"
                    }
                    if score >= 90 && score < 120 {
                        return "Medal3-Silver"
                    }
                    if score >= 60 && score < 90 {
                        return "Medal4-Bronze"
                    }
                    if score < 60 && score > 0 {
                        return "Medal5-Rust"
                    }
                    else {
                        return ""
                    }
                }
                else if mode == UtilitiesPortal.modeBeat {
                    score = Double((result.first?.levelTwoBeat)!)
                    if score >= 150 {
                        return "Medal1-Diamond"
                    }
                    if score >= 120 && score < 150 {
                        return "Medal2-Gold"
                    }
                    if score >= 90 && score < 120 {
                        return "Medal3-Silver"
                    }
                    if score >= 60 && score < 90 {
                        return "Medal4-Bronze"
                    }
                    if score < 60 && score > 0 {
                        return "Medal5-Rust"
                    }
                    else {
                        return ""
                    }
                }
            }
            
            if score >= 1 {
                return "Medal1-Diamond"
            }
            else if score >= 0.9 && score < 1 {
                return "Medal2-Gold"
            }
            else if score >= 0.7 && score < 0.9 {
                return "Medal3-Silver"
            }
            else if score >= 0.5 && score < 0.7 {
                return "Medal4-Bronze"
            }
            else if score < 0.5 && score > 0 {
                return "Medal5-Rust"
            }
            else {
                return ""
            }
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
}
