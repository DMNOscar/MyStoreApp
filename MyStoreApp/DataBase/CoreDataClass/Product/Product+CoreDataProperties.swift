//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Oscar Martinez on 15/01/25.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var productDescription: String?
    @NSManaged public var category: String?
    @NSManaged public var image: String?
    @NSManaged public var rate: Double
    @NSManaged public var count: Int64

}
