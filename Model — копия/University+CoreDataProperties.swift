//
//  University+CoreDataProperties.swift
//  MyCoreData
//
//  Created by MacOs on 22.10.2023.
//
//

import Foundation
import CoreData

@objc(University)
final class University: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var id: UUID
    @NSManaged public var students: NSSet?
}

extension University {
    
    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: Student2)
    
    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: Student2)
    
    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ value: NSSet)
    
    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ value: NSSet)
    
}

extension University : Identifiable {

}
