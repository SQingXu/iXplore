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

class AddEntryViewController: UIViewController,CLLocationManagerDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate {
    
    let locationManager = CLLocationManager()
    let imagePicker = UIImagePickerController()
    
    var activityIndicator = UIActivityIndicatorView()
    var messageFrame = UIView()
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBAction func cancelPressed(sender: UIButton) {
        titleTextField.text = ""
        notesTextView.text = ""
        longitudeTextField.text = ""
        latitudeTextField.text = ""
    }
    @IBOutlet weak var dateTextField: DatePickTextField!
    
    @IBAction func savePressed(sender: UIButton) {
        
        if titleTextField.text != "" && Double(latitudeTextField.text!) != nil && Double(longitudeTextField.text!) != nil {
            let newEntry = JournalEntry(coordinate: CLLocationCoordinate2D(latitude: Double(self.latitudeTextField.text!)!,longitude: Double(self.longitudeTextField.text!)!), title: self.titleTextField.text!)
            newEntry.image = self.previewImage.image
            newEntry.dates = self.dateTextField.text
            newEntry.notes = self.notesTextView.text
            JournalEntryController.sharedInstance.addEntry(newEntry)
            
            
            navigationController?.popViewControllerAnimated(true)
        }
        else{
            let alert = UIAlertController(title: "Illegal Entry", message: "The title cannot be empty, and coordinates need to be numbers", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // delegate all text fields
        locationManager.delegate = self
        
        titleTextField.delegate = self
        latitudeTextField.delegate = self
        longitudeTextField.delegate = self
        
        notesTextView.layer.cornerRadius = 5
       // notesTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        //notesTextView.layer.borderWidth = 1
        
        imagePicker.delegate = self
        
        let gesturer = UITapGestureRecognizer(target: self, action: #selector(self.selectImage))
        previewImage.addGestureRecognizer(gesturer)
        //previewImage.image = UIImage(named: "preview_image.png")
        previewImage.userInteractionEnabled = true
        
        
    }

    func selectImage(){
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func currentLocationPressed(sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        let location = locationManager.location
        if location != nil{
         updateToCurrentLocation()
        }
        else{
            let alert = UIAlertController(title: "Sorry", message: "we are not allowed to provide location service on this device", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse{
            locationManager.startUpdatingLocation()
        }
        else{
            
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //make sure the keyboard come down when return key hit
        titleTextField.resignFirstResponder()
        latitudeTextField.resignFirstResponder()
        longitudeTextField.resignFirstResponder()

        if Double(latitudeTextField.text!) != nil && Double(longitudeTextField.text!) != nil{
            let location = CLLocation(latitude: Double(latitudeTextField.text!)!, longitude: Double(longitudeTextField.text!)!)
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location, completionHandler: {placemarkers, error in
                if let placemarker = placemarkers?.first{
                    self.locationLabel.text = placemarker.name
                }
                else{
                    self.locationLabel.text = "Place Not Found"
                }
            })

        }
        return true
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            previewImage.contentMode = .ScaleAspectFit
            previewImage.image = selectedImage
            previewImage.backgroundColor = UIColor.clearColor()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func updateToCurrentLocation(){
        latitudeTextField.text = String(locationManager.location!.coordinate.latitude)
        longitudeTextField.text = String(locationManager.location!.coordinate.longitude)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(locationManager.location!, completionHandler: {placemarkers, error in
            if let placemarker = placemarkers?.first{
                self.locationLabel.text = placemarker.name
            }
        })
    }
    
    func progressBarDisplayer(msg:String, _ indicator:Bool ) {
        let strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.whiteColor()
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 25 , width: 180, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        view.addSubview(messageFrame)
    }
    
    
}
