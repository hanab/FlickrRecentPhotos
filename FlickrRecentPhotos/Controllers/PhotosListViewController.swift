//
//  ViewController.swift
//  FlickrRecentPhotos
//
//  Created by Hana  Demas on 9/7/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import UIKit
import CoreData

class PhotosListViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet var flickrTableView: UITableView!
    
    //MARK: Properties
    var store:RecentPhotosStore?
    fileprivate let cellID = "cell"
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Photo.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "photoId", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    private lazy var refreshControl: UIRefreshControl = UIRefreshControl()
    
    //MARK: Viewcontroller life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flickrTableView.dataSource = self
        flickrTableView.dataSource = self
        
        self.title = "Photos Feed"
        view.backgroundColor = .white
        
        refreshControl.addTarget(self, action: #selector(PhotosListViewController.refresh(sender:)), for: UIControlEvents.valueChanged)
        if #available(iOS 10.0, *) {
            flickrTableView.refreshControl = refreshControl
        } else {
            flickrTableView.backgroundView = refreshControl
        }
        updateTableContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        flickrTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destination = segue.destination as? PhotosDetailViewController,
                let indexPath = flickrTableView.indexPathForSelectedRow {
                if let photo = fetchedhResultController.object(at: indexPath) as? Photo {
                    destination.selectedImage = photo
                }
                
                //mark photo as selected
                if let selectedPhoto = fetchedhResultController.sections?[0].objects?[indexPath.row] as? Photo {
                    selectedPhoto.isSelected = true
                    CoredataManager.saveInCoreData()
                }
            }
        }
    }
    
    func refresh(sender: UIRefreshControl) {
        updateTableContent()
        self.refreshControl.endRefreshing()
    }
    
    func updateTableContent() {
        do {
            try self.fetchedhResultController.performFetch()
            print("FETCHED FIRST: \(self.fetchedhResultController.sections?[0].numberOfObjects ?? 0)")
        } catch let error  {
            print("ERROR: \(error)")
        }
        
        store?.fetchRecentPhotos() {
            (sucess, error, response) -> Void in
            if (!sucess) {
                DispatchQueue.main.async {
                    if let error = error {
                        self.displayAlertWith(title: "Error", message: error.localizedDescription)
                    }
                }
            }
        }
    }
}

//MARK: viewcontroller extension for implementing datasource and delegates of uitableview
extension PhotosListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerCellsForTableView(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FlickrImageTableViewCell
        if let photo = fetchedhResultController.object(at: indexPath) as? Photo {
            cell.setUpCell(photo: photo)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fetchedhResultController.sections?.first?.numberOfObjects {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: tableView)
        self.flickrTableView.deselectRow(at: self.flickrTableView.indexPathForSelectedRow!, animated: true)
    }
}

//MARK: viewcontroller extension to implement NSFetchedResultsControllerDelegate
extension PhotosListViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.flickrTableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            self.flickrTableView.deleteRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.flickrTableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        flickrTableView.beginUpdates()
    }
}



