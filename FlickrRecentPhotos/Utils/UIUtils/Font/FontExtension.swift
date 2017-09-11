//
//  FontExtension.swift
//  FlickrRecentPhotos
//
//  Created by Hana  Demas on 9/11/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func fontRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    class func fontBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
}

struct Font {
    static let regular17 = UIFont.fontRegular(17)
    static let regular12 = UIFont.fontRegular(12)
    static let bold18 = UIFont.fontBold(18)
}
