//
//  AddEntryViewController.swift
//  iXplore
//
//  Created by David Xu on 7/9/16.
//  Copyright © 2016 David Xu. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AddEntryViewController: UIViewController,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    @IBOutlet weak var datesField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBAction func cancelPressed(sender: UIButton) {
        datesField.text = ""
        titleTextField.text = ""
        notesField.text = ""
        longitudeTextField.text = ""
        latitudeTextField.text = ""
    }
    @IBAction func savePressed(sender: UIButton) {
        JournalEntryController.sharedInstance.addEntry(titleTextField.text!, notes:notesField.text! , dates: datesField.text!, latitude: latitudeTextField.text!, longitude: longitudeTextField.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func currentLocationPressed(sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latitudeTextField.text = String(locations.last!.coordinate.latitude)
        longitudeTextField.text = String(locations.last!.coordinate.longitude)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
