//
//  FlickrRecentPhotosTests.swift
//  FlickrRecentPhotosTests
//
//  Created by Hana  Demas on 9/7/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import XCTest
import CoreData
import ObjectMapper
@testable import FlickrRecentPhotos


class FlickrRecentPhotosTests: XCTestCase {
    
    let store = RecentPhotosStore()
    
    override func setUp() {
        super.setUp()
    }
    
    func testNetworkRespose() {
        let testExpectation =  expectation(description: "Flickr photos info expectation")
        store.fetchRecentPhotos() {
            (sucess, error, response) -> Void in
            if (sucess) {
                if let photos = response?.result.value?.photos {
                    XCTAssert(photos.count == 100, "more or less photos than expected \(photos.count)")
                }
                testExpectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testEntityCreation() {
        let context = setUpInMemoryManagedObjectContext()
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context) as! Photo
        XCTAssertNotNil(entity, "unable to create a Photo")
    }
    
    func testObjectMapping() {
        let jsonDictionary: [String: Any] = ["id": 10, "title": "pic1", "url_s": "https://farm5.staticflickr.com/4416/36347884713_a3127b0c24_m.jpg", "url_m": "https://farm5.staticflickr.com/4411/36347901593_58dbac1d0b.jpg", "datetaken" : ""]
        let photo = Mapper<Photo>().map(JSON: jsonDictionary)
        
        XCTAssertEqual(photo?.photoId, 10)
        XCTAssertEqual(photo?.title, "pic1")
        XCTAssertEqual(photo?.remoteUrlStringSmall, "https://farm5.staticflickr.com/4416/36347884713_a3127b0c24_m.jpg")
        XCTAssertEqual(photo?.remoteUrlStringMedium, "https://farm5.staticflickr.com/4411/36347901593_58dbac1d0b.jpg", "datetaken")
        XCTAssertEqual(photo?.isSelected, false)
    }
}

func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
    let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
    try! persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
    
    return managedObjectContext
}


