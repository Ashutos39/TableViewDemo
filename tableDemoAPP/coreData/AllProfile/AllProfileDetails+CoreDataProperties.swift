//
//  AllProfileDetails+CoreDataProperties.swift
//  tableDemoAPP
//
//  Created by Sds mac mini on 07/12/18.
//  Copyright © 2018 straightdrive.co.in. All rights reserved.
//

import Foundation
import CoreData

extension ALLProfile {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ALLProfile> {
        return NSFetchRequest<ALLProfile>(entityName: "ALLProfile")
    }
    
    @NSManaged public var indiProfileList: NSOrderedSet?
}

// MARK: Generated accessors for profileList
extension ALLProfile {
    
    @objc(insertObject:inSurveyListAtIndex:)
    @NSManaged func insertIntoSurveyList(_ value: ALLProfile, at idx: Int)
    
    @objc(removeObjectFromSurveyListAtIndex:)
    @NSManaged func removeFromSurveyList(at idx: Int)
    
    @objc(insertSurveyList:atIndexes:)
    @NSManaged func insertIntoSurveyList(_ values: [ALLProfile], at indexes: NSIndexSet)
    
    @objc(removeSurveyListAtIndexes:)
    @NSManaged func removeFromSurveyList(at indexes: NSIndexSet)
    
    @objc(replaceObjectInSurveyListAtIndex:withObject:)
    @NSManaged func replaceSurveyList(at idx: Int, with value: ALLProfile)
    
    @objc(replaceSurveyListAtIndexes:withPackageList:)
    @NSManaged func replaceSurveyList(at indexes: NSIndexSet, with values: [ALLProfile])
    
    @objc(addSurveyListObject:)
    @NSManaged func addToSurveyList(_ value: ALLProfile)
    
    @objc(removeSurveyListObject:)
    @NSManaged func removeFromSurveyList(_ value: ALLProfile)
    
    @objc(addSurveyList:)
    @NSManaged public func addToSurveyList(_ values: NSOrderedSet)
    
    @objc(removeSurveyList:)
    @NSManaged public func removeFromSurveyList(_ values: NSOrderedSet)
}


