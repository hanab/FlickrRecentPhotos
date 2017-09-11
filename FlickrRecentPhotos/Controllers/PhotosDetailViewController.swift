//
//  PhotosDetailViewController.swift
//  FlickrRecentPhotos
//
//  Created by Hana  Demas on 9/7/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import UIKit

class PhotosDetailViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet var flickrMediumImage: UIImageView!
    @IBOutlet var imageTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    //MARK: Properties
    var selectedImage: Photo?
    let dateFormatter = "dd-MM-yyyy"
    
    //MARK: viewcontroller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageTitleLabel.font = Font.regular17
        self.dateLabel.font = Font.regular12
        self.dateLabel.textColor = UIColor.darkGray()
        
        updateViewsWithPhoto()
    }
    
    //MARK: custom functions
    //setup ui with selected photo
    func updateViewsWithPhoto() {
        if let photo = selectedImage {
            DispatchQueue.main.async {
                self.title = photo.title ?? "Unnamed"
                self.imageTitleLabel.text =  photo.title ?? "Unnamed image"
                if let date = photo.dateTaken, let formateDate = date.stringFromDate(inputFormat: self.dateFormatter) {
                    self.dateLabel.text = "Date taken: " + formateDate
                }
                
                if let url = photo.remoteUrlStringMedium {
                    self.flickrMediumImage.loadImageUsingCacheWithURLString(url, placeHolder: UIImage(named: "placeholder"))
                }
            }
        }
    }
}
