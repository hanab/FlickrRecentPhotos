//
//  AppDelegate.swift
//  FlickrRecentPhotos
//
//  Created by Hana  Demas on 9/7/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let rootViewController = window!.rootViewController as! UINavigationController
        let photosViewController = rootViewController.topViewController as! PhotosListViewController
        photosViewController.store = RecentPhotosStore()
        CoreDataStack.sharedInstance.applicationDocumentsDirectory()
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: Font.bold18
        ]

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
    
    }
}

