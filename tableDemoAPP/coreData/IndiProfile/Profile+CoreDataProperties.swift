//
//  Profile+CoreDataProperties.swift
//  tableDemoAPP
//
//  Created by Sds mac mini on 06/12/18.
//  Copyright © 2018 straightdrive.co.in. All rights reserved.
//

import Foundation
import CoreData


extension Profiles {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profiles> {
        return NSFetchRequest<Profiles>(entityName: "Profiles")
    }
    
    @NSManaged public var email: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    
    @NSManaged public var indiData : ALLProfile?
}
