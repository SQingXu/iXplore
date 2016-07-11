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
        
        //asking for autherization
        
        //set up navigationBarItems
        self.navigationItem.title = "iXplore"
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(self.addButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = addBarButton
        
        //set up map view
        mapView.delegate = self
        mapView.addAnnotations(JournalEntryController.sharedInstance.getCurrentEntries())
        
        
        //set up table view
        tableView.delegate = self
           //create a new cell under table view with identifier "Strings"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Strings")

        tableView.dataSource = self
      
    }
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        mapView.addAnnotations(JournalEntryController.sharedInstance.getCurrentEntries())
        mapView.reloadInputViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Strings", forIndexPath: indexPath)
        cell.textLabel?.text = String(JournalEntryController.sharedInstance.getStringEntries()[indexPath.row])
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalEntryController.sharedInstance.getStringEntries().count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let entryNum = indexPath.row
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let location = JournalEntryController.sharedInstance.getCurrentEntries()[entryNum].coordinate
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
       
    }
    func addButtonPressed(sender:UIBarButtonItem){
        self.navigationController?.pushViewController(AddEntryViewController(), animated: true)
        
    }
    


}
