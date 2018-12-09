//
//  Profile+CoreDataClass.swift
//  tableDemoAPP
//
//  Created by Sds mac mini on 06/12/18.
//  Copyright © 2018 straightdrive.co.in. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Profiles)
public class Profiles: NSManagedObject {
    public static func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    public static func insertEntity(indiProfile: [String:AnyObject])->Profiles{
        
        let moc = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Profiles", in: moc)
        let  managedObj = NSManagedObject(entity:entity!,insertInto: moc)
        
        
        let email = indiProfile["emailId"] as! String
        managedObj.setValue(email, forKey: "email")
        
        let imageUrl = indiProfile["imageUrl"] as! String
        managedObj.setValue(imageUrl, forKey: "imageUrl")
        
        let firstName = indiProfile["firstName"] as! String
        let lastName =  indiProfile["lastName"] as! String
        let name = firstName + " " + lastName
        managedObj.setValue(name, forKey: "name")
        
        return managedObj as! Profiles
    }
    
    public static func fetchReq() -> Profiles?{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Profiles")
        let context = getContext()
        weak var moc = context
        var entity : Profiles? = nil
        
        moc?.performAndWait ({
            do{
                
                let objects = try (moc?.fetch(request))! as? [Profiles]
                
                if let objects = objects{
                    
                    if objects.count  > 0 {
                        entity = objects.last
                    }
                    print("data is entering to data base")
                }
            }catch{
                
            }
        })
        return entity
    }
}
