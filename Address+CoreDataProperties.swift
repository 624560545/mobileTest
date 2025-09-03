//
//  Address+CoreDataProperties.swift
//  zmobileTest
//
//  Created by 天天 on 2025/9/3.
//
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }


     @NSManaged public var code: String?
    @NSManaged public var displayName: String?
    @NSManaged public var url: String?

}

extension Address : Identifiable {

}
