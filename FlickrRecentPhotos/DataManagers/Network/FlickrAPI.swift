//
//  FlickrAPI.swift
//  FlickrRecentPhotos
//
//  Created by Hana  Demas on 9/7/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation

enum Method: String {
    case RecentPhotos = "flickr.photos.getRecent"
}

// structure for generating the full url
struct FlickrAPI {
    
    //MARK: Properies
    fileprivate static let baseURLString = "https://api.flickr.com/services/rest"
    fileprivate static let APIKey="cc515094ccc0e681f4f310ea2dc07d7b"
    
    //MARK: Methods
    fileprivate static func flickrURL(method: Method, parameters: [String:String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback":"1",
            "api_key": APIKey
        ]
        
        for (key,value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key,value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        return components.url!
    }
    
    //static function to get the recent photos full url
    static func recentPhotosURL() -> URL {
        return flickrURL(method: Method.RecentPhotos, parameters: ["extras": "url_s, url_m, date_taken"])
    }
}


