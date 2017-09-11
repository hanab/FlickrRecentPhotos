//
//  PhotoListViewModel.swift
//  FlickrRecentPhotos
//
//  Created by Hana  Demas on 9/9/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import CoreData

class CoredataManager {
    
    //MARK: Functions
    static func clearData() {
        do {
            let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Photo.self))
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let objects  = try context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print("ERROR DELETING : \(error)")
            }
        }
    }
    
    static func saveInCoreData() {
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
}
