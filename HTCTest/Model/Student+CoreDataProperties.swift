//
//  Student+CoreDataProperties.swift
//  HTCTest
//
//  Created by Антон Чушъялов on 30.03.2022.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var gpa: String?
    @NSManaged public var lastName: String?

}

extension Student : Identifiable {

}
