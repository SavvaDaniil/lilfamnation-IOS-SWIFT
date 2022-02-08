//
//  TechData+CoreDataProperties.swift
//  LilFam NATION 3
//
//  Created by Daniil Savva on 20.01.2022.
//
//

import Foundation
import CoreData


extension TechData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TechData> {
        return NSFetchRequest<TechData>(entityName: "TechData")
    }

    @NSManaged public var value_: String?
    @NSManaged public var name: String?

}

extension TechData : Identifiable {

}
