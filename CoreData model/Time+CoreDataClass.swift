//
//  Time+CoreDataClass.swift
//  Alarm
//
//  Created by Dheepthaa Anand on 23/11/17.
//  Copyright © 2017 Dheepthaa Anand. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Time)
public class Time: NSManagedObject {
    
    func getContext() -> NSManagedObjectContext{
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func save1(_ value1: [String], _ datestring: String){
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Time", in: context)!
        let timeobj = NSManagedObject(entity: entity, insertInto: context) as! Time
        
            timeobj.days = value1[0]
            timeobj.label = value1[1]
            timeobj.time = datestring
            timeobj.isOn = true
            
            do
            {
                try context.save()
            }
            catch
            {
                fatalError("Failed to save: \(error)")
            }
    }
    
    func saveSwitch(obj: Time, isOn: Bool)
    {
        let context = self.getContext()
       obj.isOn = isOn
        do
        {
            try context.save()
        }
        catch
        {
            fatalError("Failed to save: \(error)")
        }
        
    }
    
    func fetch() -> Array<Time>{
        var timeobj: [Time] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Time")
        request.returnsObjectsAsFaults = false
        do{
            timeobj = try getContext().fetch(request) as! [Time]}
        catch {
            fatalError("Failed to fetch time: \(error)")
        }
        return timeobj
        
    }
    
    func update(_ value1: [String], _ datestring: String,_ obj: Time){
       
        obj.days = value1[0]
        obj.label = value1[1]
        obj.time = datestring
        let context = self.getContext()
        do
        {
            try context.save()
        }
        catch
        {
            fatalError("Failed to save: \(error)")
        }
        
    }
    
    func delete(obj: Time){
        let context = self.getContext()
        context.delete(obj)
        do
        {
            try context.save()
        }
        catch
        {
            fatalError("Failed to save: \(error)")
        }
        
        
    }
    
}
