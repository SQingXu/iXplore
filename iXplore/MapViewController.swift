//
//  MapViewController.swift
//  iXplore
//
//  Created by David Xu on 7/8/16.
//  Copyright © 2016 David Xu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController,MKMapViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up navigationBarItems
        self.navigationItem.title = "iXplore"
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(self.addButtonPressed(_:)))
        
        self.navigationItem.rightBarButtonItem = addBarButton
        
        //set up map view
        mapView.delegate = self
        mapView.addAnnotations(JournalEntryController.sharedInstance.currentEntries)
        if locationManager.location != nil{
            let span = MKCoordinateSpanMake(1, 1)
            let location = locationManager.location?.coordinate
            let region = MKCoordinateRegion(center: location!, span: span)
            mapView.setRegion(region, animated: true)
        }
        
        //set up table view
        tableView.delegate = self
        tableView.dataSource = self
        //create a new cell under table view with identifier "Strings"
        tableView.registerNib(UINib(nibName: "EntryCell",bundle: nil), forCellReuseIdentifier: "entry")
        
    }
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        mapView.addAnnotations(JournalEntryController.sharedInstance.currentEntries)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entry", forIndexPath: indexPath) as! EntryCell
        
        cell.smallImage.image = JournalEntryController.sharedInstance.currentEntries[indexPath.row].image
        if JournalEntryController.sharedInstance.currentEntries[indexPath.row].dates != nil {
        cell.datesLabel.text = JournalEntryController.sharedInstance.currentEntries[indexPath.row].dates!
        }
        else{
            cell.datesLabel.text = "Unknown Date"
        }
        cell.titleLabel.text = String(JournalEntryController.sharedInstance.currentEntries[indexPath.row].title!)
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalEntryController.sharedInstance.currentEntries.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let entryNum = indexPath.row
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let location = JournalEntryController.sharedInstance.currentEntries[entryNum].coordinate
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation is MKUserLocation) {
            return nil
        }
        let identity = "pin"
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identity)
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identity)
            annotationView?.image = UIImage(named: "map_pin.png")
            annotationView?.canShowCallout = true
            var frame = annotationView?.frame
            frame?.size.width = 25
            frame?.size.height = 40
            annotationView?.frame = frame!
        }
        annotationView?.annotation = annotation
        return annotationView
    }
    
    
    func addButtonPressed(sender:UIBarButtonItem){
        self.navigationController?.pushViewController(AddEntryViewController(), animated: true)
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let remove = UITableViewRowAction(style: .Default, title: "Remove", handler: {action, index in
            let annotation = JournalEntryController.sharedInstance.currentEntries[indexPath.row]
            JournalEntryController.sharedInstance.removeEntry(indexPath.row)
            self.mapView.removeAnnotation(annotation)
            self.mapView.addAnnotations(JournalEntryController.sharedInstance.currentEntries)
            tableView.reloadData()
            
        })
        return [remove]
    }
    
    
    
}
