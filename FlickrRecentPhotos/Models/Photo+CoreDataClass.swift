//
//  Photo+CoreDataClass.swift
//  FlickrRecentPhotos
//
//  Created by Hana  Demas on 9/9/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import CoreData
import AlamofireObjectMapper
import ObjectMapper

@objc(Photo)
public class Photo: NSManagedObject, Mappable {
    
    //MARK: inits
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: CoreDataStack.sharedInstance.persistentContainer.viewContext)
    }
    
    required public init?(map: Map) {
        let context =  CoreDataStack.sharedInstance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Photo", in: context)
        super.init(entity: entity!, insertInto: context)
        
        mapping(map: map)
    }
    
    public func mapping(map: Map) {
        title      <- map["title"]
        remoteUrlStringSmall    <- map["url_s"]
        remoteUrlStringMedium  <- map["url_m"]
        photoId     <- map["id"]
        dateTaken    <- (map["datetaken"], DateTransform())
        isSelected = false
    }
}

//Class for mapping Api response
final class PhotoResponse: Mappable {
    
    //MARK: Properties
    var photos: [Photo]?
    
    //MARK: Inits
    required init?(map: Map){
    }
    
    func mapping(map: Map) {
        // this might not be the best place to clear the data
        CoredataManager.clearData()
        
        photos <- map["photos.photo"]
        
        CoredataManager.saveInCoreData()
    }
}


