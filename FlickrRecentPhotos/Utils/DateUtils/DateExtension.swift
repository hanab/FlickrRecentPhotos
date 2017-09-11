//
//  DateExtension.swift
//  FlickrRecentPhotos
//
//  Created by Hana  Demas on 9/11/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation

//DATE extention
extension Date {
    
    //to get String from date
    func stringFromDate(inputFormat: String ) -> String? {
        let dateFormatter = setupDateFormatter(inputFormat: inputFormat)
        return dateFormatter.string(from: self)
    }
}
//function to setup dateformatter
func setupDateFormatter(inputFormat: String )->DateFormatter{
    TimeZone.ReferenceType.default = TimeZone(abbreviation: "UTC+2:00")!
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = inputFormat
    dateFormatter.timeZone = TimeZone.ReferenceType.default
    dateFormatter.locale = Locale.init(identifier: "en_GB")
    return dateFormatter
}
