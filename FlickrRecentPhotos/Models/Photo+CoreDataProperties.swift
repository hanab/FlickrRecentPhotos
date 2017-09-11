//
//  Photo+CoreDataProperties.swift
//  FlickrRecentPhotos
//
//  Created by Hana  Demas on 9/10/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var dateTaken: Date?
    @NSManaged public var photoId: Int32
    @NSManaged public var remoteUrlStringMedium: String?
    @NSManaged public var remoteUrlStringSmall: String?
    @NSManaged public var title: String?
    @NSManaged public var isSelected: Bool

}
