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
            entity.setValue(0, forKey: "levelOne")
            entity.setValue(0, forKey: "levelTwo")
            entity.setValue(0, forKey: "levelThree")
            
            do {
                try settings.save()
            }
            catch {
                fatalError("Failure to save Settings: \(error)")
            }
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
    
    static func updateSound(sound: Bool) {
        let setting = NSFetchRequest(entityName: "Settings")
        do {
            let result = try settings.executeFetchRequest(setting) as! [Settings]
            let object = result.first!
            object.setValue(sound, forKey: "sound")
            try settings.save()
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
}