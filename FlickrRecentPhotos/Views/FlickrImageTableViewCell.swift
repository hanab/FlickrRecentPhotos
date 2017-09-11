//
//  FlickrImageTableViewCell.swift
//  FlickrRecentPhotos
//
//  Created by Hana  Demas on 9/9/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import UIKit

class FlickrImageTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet var FlickrImageTitle: UILabel!
    @IBOutlet var FlickrImageView: UIImageView!
    
    //MARK: overriden initializers
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: custom functions
    // setup the cell from photo
    func setUpCell(photo: Photo) {
        FlickrImageTitle.font = Font.regular17
        
        DispatchQueue.main.async {
            self.FlickrImageTitle.text =  photo.title ?? "Unnamed photo"
            //setup cell color based on the cell being clicked
            if(photo.isSelected) {
                self.backgroundColor = UIColor.white
            } else {
                self.backgroundColor = UIColor.lightBlue()
            }
            
            if let url = photo.remoteUrlStringSmall {
                self.FlickrImageView.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
            }
        }
    }
}
