//
//  SocialClass.swift
//  Rmitium
//
//  Created by Max on 21/09/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
//  Custom SpriteNode with an user defined string to store custom value

import Foundation
import CoreData

class SocialClass {
    var context = DataController().managedObjectContext
    var facebook, twitter:Bool!
    
    // Initialize Facebook and Twitter
    func initClass() {
        if checkDataIsEmpty() == true {
            let entity = NSEntityDescription.insertNewObjectForEntityForName("Social", inManagedObjectContext: context)
            entity.setValue(false, forKey: "facebook")
            entity.setValue(false, forKey: "twitter")
            entity.setValue(NSDate(), forKey: "time")
            do {
                try context.save()
            }
            catch {
                print("Error!")
            }
        }
    }
    
    // Read the record
    func getRecord() {
        let request = NSFetchRequest(entityName: "Social")
        do {
            let results = try context.executeFetchRequest(request)
            for item in results as! [Social] {
                print(item.facebook)
                print(item.twitter)
               
                facebook = item.facebook
                twitter = item.twitter
            }
            
            
        }
        catch {
            print("Error!")
        }
    }
    
    // Set Facebook or Twitter with true after the first time of accessing
    func setValue(keyString: String) {
        delCoreData()
        let entity = NSEntityDescription.insertNewObjectForEntityForName("Social", inManagedObjectContext: context)
        if keyString == "facebook" {
            entity.setValue(true, forKey: "facebook")
            
            entity.setValue(twitter, forKey: "twitter")
        }
        if keyString == "twitter" {
            entity.setValue(true, forKey: "twitter")
            entity.setValue(facebook, forKey: "facebook")
        }
        do {
            try context.save()
        }
        catch {
            print("Error!")
        }
        getRecord()
    }
    
    func checkDataIsEmpty() -> Bool {
        let setting = NSFetchRequest(entityName: "Social")
        do {
            let result = try context.executeFetchRequest(setting) as! [Social]
            print("Database count: \(result.count)")
            return result.count == 0
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }
    
    // Clean the core data
    func delCoreData() {
        let setting = NSFetchRequest(entityName: "Social")
        do {
            let results = try context.executeFetchRequest(setting)
            for item:AnyObject in results {
               
                context.deleteObject(item as! NSManagedObject)
            }
            try context.save()
        }
        catch {
            fatalError("Failure reading from coredata: \(error)")
        }
    }//func delCoreData
    
}

