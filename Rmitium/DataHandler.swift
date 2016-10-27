//
//  DataHandler.swift
//  Rmitium
//
//  Created by Aoi Mizu on 8/10/16.
//  Copyright © 2016 RMIT. All rights reserved.
//
//  Custom Controller to read/write local settings and score

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
    
    // First time create database
    static func initSettings() {
        if checkDataIsEmpty() {
            let entity = NSEntityDescription.insertNewObjectForEntityForName("Settings", inManagedObjectContext: settings) as! Settings
            entity.setValue(true, forKey: "sound")
            entity.setValue(true, forKey: "rightHand")
            entity.setValue(true, forKey: "effect")
            entity.setValue(UtilitiesPortal.firstTime, forKey: "levelOne")
            entity.setValue(UtilitiesPortal.firstTime, forKey: "levelTwo")
            entity.setValue(UtilitiesPortal.firstTime, forKey: "levelThree")
            entity.setValue(UtilitiesPortal.firstTime, forKey: "levelTwoTrial")
            entity.setValue(UtilitiesPortal.firstTime, forKey: "levelTwoExtreme")
            entity.setValue(UtilitiesPortal.defaultScore, forKey: "levelOneScore")
            entity.setValue(UtilitiesPortal.defaultScore, forKey: "levelThreeScore")
            do {
                try settings.save()
                //localSetting = entity
            }
            catch {
                fatalError("Failure to save Settings: \(error)")
            }
        }
    }
    
    // Reset all database
    static func resetSettings() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            object.setValue(true, forKey: "sound")
            object.setValue(true, forKey: "rightHand")
            object.setValue(true, forKey: "effect")
            object.setValue(UtilitiesPortal.firstTime, forKey: "levelOne")
            object.setValue(UtilitiesPortal.firstTime, forKey: "levelTwo")
            object.setValue(UtilitiesPortal.firstTime, forKey: "levelThree")
            object.setValue(UtilitiesPortal.firstTime, forKey: "levelTwoTrial")
            object.setValue(UtilitiesPortal.firstTime, forKey: "levelTwoExtreme")
            object.setValue(UtilitiesPortal.defaultScore, forKey: "levelOneScore")
            object.setValue(UtilitiesPortal.defaultScore, forKey: "levelThreeScore")
            try settings.save()
            //localSetting = object
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    // Reset all scores
    static func resetScores() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            object.setValue(UtilitiesPortal.defaultScore, forKey: "levelOne")
            object.setValue(UtilitiesPortal.defaultScore, forKey: "levelTwo")
            object.setValue(UtilitiesPortal.defaultScore, forKey: "levelThree")
            object.setValue(UtilitiesPortal.defaultScore, forKey: "levelTwoTrial")
            object.setValue(UtilitiesPortal.defaultScore, forKey: "levelTwoExtreme")
            object.setValue(UtilitiesPortal.defaultScore, forKey: "levelOneScore")
            object.setValue(UtilitiesPortal.defaultScore, forKey: "levelThreeScore")
            try settings.save()
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    // Get the local settings
    static func getSettings() -> Settings {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            /*print("Lvl 1 Score: \(result.first!.levelOne)")
            print("Lvl 1 Percent: \(result.first!.levelOneScore)")
            print("Lvl 3 Score: \(result.first!.levelThree)")
            print("Lvl 3 Percent: \(result.first!.levelThreeScore)")
            print("Lvl 2 Standard: \(result.first!.levelTwo)")
            print("Lvl 2 Trial: \(result.first!.levelTwoTrial)")
            print("Lvl 2 Extreme: \(result.first!.levelTwoExtreme)")*/
            return result.first!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func getLocalSetting() -> Settings {
        return localSetting
    }
    
    // Level 1
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
    
    // Save Level 1 first info layout
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
    
    // Save Level 1 result info layout
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
    
    // Level 2
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
    
    // Save Level 2 info layout
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
                if object.levelTwoExtreme == UtilitiesPortal.firstTime {
                    object.setValue(UtilitiesPortal.firstResult, forKey: "levelTwoExtreme")
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
    
    // Level 2 - Time Trial
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

    // Level 2 - Extreme
    
    static func getLevelTwoExtremeScore() -> NSNumber {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            return result.first!.levelTwoExtreme!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func saveLevelTwoExtremeScore() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            let x = object.levelTwoExtreme as! Int
            if x < UtilitiesPortal.score {
                object.setValue(UtilitiesPortal.score, forKey: "levelTwoExtreme")
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
    
    // Save level 3 first info layout
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
    
    // Save level three result info layout
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
    
    // Check if the database is empty (for when installing the app)
    static func checkDataIsEmpty() -> Bool {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            return result.count == 0
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    // Update settings based on user references
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
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
        
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
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
    
    // Get the medal images for each level
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
                // Level 2 Standard
                if mode == UtilitiesPortal.modeStandard {
                    score = Double((result.first?.levelTwo)!)
                    if score <= 70  && score >= 0 {
                        return "Medal1-Diamondsparkles"
                    }
                    else if score <= 120 && score > 70 {
                        return "Medal2-Gold"
                    }
                    else if score <= 180 && score > 120 {
                        return "Medal3-Silver"
                    }
                    else if score <= 240 && score > 180 {
                        return "Medal4-Bronze"
                    }
                    else if score > 240 {
                        return "Medal5-Rust"
                    }
                    else {
                        return ""
                    }
                    
                }
                // Level 2 Trial
                else if mode == UtilitiesPortal.modeTrial {
                    //score = Double((result.first?.levelTwoTrial)!) + Double(UtilitiesPortal.level2TrialTime)
                    score = Double((result.first?.levelTwoTrial)!)
                    if score > 240 {
                        return "Medal1-Diamondsparkles"
                    }
                    if score > 180 && score <= 240 {
                        return "Medal2-Gold"
                    }
                    if score > 120 && score <= 180 {
                        return "Medal3-Silver"
                    }
                    if score > 70 && score <= 120 {
                        return "Medal4-Bronze"
                    }
                    if score <= 70 && score >= 0 {
                        return "Medal5-Rust"
                    }
                    else {
                        return ""
                    }
                }
                // Level 2 Extreme
                else if mode == UtilitiesPortal.modeExtreme {
                    //score = 300 - Double((result.first?.levelTwoExtreme)!)
                    score = Double((result.first?.levelTwoExtreme)!)
                    if score > 240 {
                        return "Medal1-Diamondsparkles"
                    }
                    if score > 180 && score <= 240 {
                        return "Medal2-Gold"
                    }
                    if score > 120 && score <= 180 {
                        return "Medal3-Silver"
                    }
                    if score > 70 && score <= 120 {
                        return "Medal4-Bronze"
                    }
                    if score <= 70 && score >= 0 {
                        return "Medal5-Rust"
                    }
                    else {
                        return ""
                    }
                }
            }
            // Level 1 or 3
            if score >= 1 {
                return "Medal1-Diamondsparkles"
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
            else if score < 0.5 && score >= 0 {
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
