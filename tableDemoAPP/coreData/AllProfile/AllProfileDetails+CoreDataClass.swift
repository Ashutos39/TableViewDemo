//
//  AllProfileDetails+CoreDataClass.swift
//  tableDemoAPP
//
//  Created by Sds mac mini on 07/12/18.
//  Copyright © 2018 straightdrive.co.in. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(ALLProfile)
public class ALLProfile: NSManagedObject{
    
    public static func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    public static func insertToDbWithProfileDatails(indiProfile: [[String:AnyObject]]){
        let moc = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "ALLProfile", in: moc)
        let managedObj = NSManagedObject(entity: entity!, insertInto: moc)
        var allProfileArray = [Profiles]()
        
        for indiPro in indiProfile{
            let profile = Profiles.insertEntity(indiProfile: indiPro)
            allProfileArray.append(profile)
        }
        managedObj.setValue(NSOrderedSet(array: allProfileArray), forKey: "indiProfileList")
        
        do{
            try moc.save() // to save in our table
            print("saved!")
        }catch{
            print(error.localizedDescription)
        }
        print(self.fetchProfileList()?.indiProfileList?.array.count)
    }
    
    public static func fetchProfileList() -> ALLProfile?{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ALLProfile")
        let context = getContext()
        weak var moc = context
        var entity : ALLProfile? = nil
        
        moc?.performAndWait ({
            do{
                
                let objects = try (moc?.fetch(request))! as? [ALLProfile]
                
                if let objects = objects{
                    
                    if objects.count  > 0 {
                        entity = objects.last
                    }
                    print("Profile fetching from data base")
                }
            }catch{
                
            }
        })
        return entity
    }
    
     public static func resetAllRecords(){
        
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ALLProfile")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
}
