//
//  Pair+CoreDataProperties.swift
//  zmobileTest
//
//  Created by 天天 on 2025/9/3.
//
//

import Foundation
import CoreData


extension Pair {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pair> {
        return NSFetchRequest<Pair>(entityName: "Pair")
    }



    @NSManaged public var originCity: String?
    @NSManaged public var destinationCity: String?
    @NSManaged public var origin: Address?
    @NSManaged public var destination: Address?

}

extension Pair : Identifiable {

}

