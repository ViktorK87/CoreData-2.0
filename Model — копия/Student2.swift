
import Foundation
import CoreData

@objc(Student2)

final class Student2: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var id: UUID
    @NSManaged public var university: University? 
}

extension Student2 : Identifiable {
    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: University)
    
    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: University)
    
    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ value: NSSet)
    
    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ value: NSSet)
    
}
