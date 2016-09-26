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
    static var settings = DataController().managedObjectContext
    
    static func initSettings() {
        if checkDataIsEmpty() {
            let entity = NSEntityDescription.insertNewObjectForEntityForName("Settings", inManagedObjectContext: settings) as! Settings
            entity.setValue(true, forKey: "sound")
            entity.setValue(true, forKey: "rightHand")
            entity.setValue(-1, forKey: "levelOne")
            entity.setValue(-1, forKey: "levelTwo")
            entity.setValue(-1, forKey: "levelThree")
            
            do {
                try settings.save()
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
            object.setValue(-1, forKey: "levelOne")
            object.setValue(-1, forKey: "levelTwo")
            object.setValue(-1, forKey: "levelThree")
            try settings.save()
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    static func getSettings() -> Settings {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            return result.first!
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
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
    
    static func saveLevelOneScore() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            object.setValue(UtilitiesPortal.score, forKey: "levelOne")
            try settings.save()
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
    
    static func saveLevelTwoScore() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            object.setValue(UtilitiesPortal.score, forKey: "levelTwo")
            try settings.save()
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
    
    static func saveLevelThreeScore() {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            object.setValue(UtilitiesPortal.score, forKey: "levelThree")
            try settings.save()
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
            object.setValue(values[1], forKey: "rightHand")
            try settings.save()
            print("Trying to Save value: Sound(\(values[0])), RightHand(\(values[1]))")
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
        
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            print("Load value: Sound(\(result.first!.getSound)), RightHand(\(result.first!.getRightHand))")
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
}
