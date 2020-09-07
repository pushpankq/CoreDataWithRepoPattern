//
//  CDEmployee+CoreDataProperties.swift
//  RepoPattern
//
//  Created by Pushpank Kumar on 28/08/20.
//  Copyright © 2020 Pushpank Kumar. All rights reserved.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var profilePic: Data?
    
    func convertToEmployee() -> Employee {
        return Employee(email: self.email, id: self.id!, name: self.name, profilePic: self.profilePic)
    }

}
