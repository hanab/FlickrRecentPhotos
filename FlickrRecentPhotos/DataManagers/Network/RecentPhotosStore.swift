//
//  RecentPhotosStore.swift
//  FlickrRecentPhotos
//
//  Created by Hana  Demas on 9/7/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

//Class for fetching pics from flickr
class RecentPhotosStore {
    
    //MARK: Functions
    private func executeRequestURL(_ requestURL: URL, taskCallback: @escaping (Bool, Error?, DataResponse<PhotoResponse>?) -> ()) {
        Alamofire.request(requestURL)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseObject { (response: DataResponse<PhotoResponse>) in
                switch(response.result) {
                case .success(_):
                    taskCallback(true, nil, response)
                    break
                case .failure(_):
                    print("** Error while fetching url: \(response.result.error ?? "error" as! Error) **")
                    taskCallback(false, response.result.error, nil)
                    break
                }
        }
    }
    
    func fetchRecentPhotos(taskCallback: @escaping (Bool, Error?, DataResponse<PhotoResponse>?) -> Void) {
        let url = FlickrAPI.recentPhotosURL()
        executeRequestURL(url, taskCallback: taskCallback)
    }
}
