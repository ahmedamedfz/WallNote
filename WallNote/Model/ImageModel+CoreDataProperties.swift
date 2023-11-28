//
//  ImageModel+CoreDataProperties.swift
//  WallNote
//
//  Created by Ahmad Fariz on 26/05/23.
//
//

import Foundation
import CoreData


extension ImageModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageModel> {
        return NSFetchRequest<ImageModel>(entityName: "ImageModel")
    }

    @NSManaged public var filePath: String?
    @NSManaged public var order: Int64

}

extension ImageModel : Identifiable {

}
