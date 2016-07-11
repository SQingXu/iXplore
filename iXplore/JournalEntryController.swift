//
//  JournalEntryController.swift
//  iXplore
//
//  Created by David Xu on 7/8/16.
//  Copyright © 2016 David Xu. All rights reserved.
///Users/davidxu/Desktop/ClassFolder/iXplore/iXplore/JournalEntryController.swift:37:60: Cannot convert value of type 'Float?' to expected argument type 'CLLocationDegrees' (aka 'Double')

import Foundation
import MapKit
class JournalEntryController{
    static var sharedInstance = JournalEntryController()
    
    var entry1 = JournalEntry(coordinate: CLLocationCoordinate2D(latitude: -31.906764,longitude: 17.4164983), title: "0605")
    var entry2 = JournalEntry(coordinate: CLLocationCoordinate2D(latitude: -34.906764,longitude: 20.4164983), title: "0606")
    var entry3 = JournalEntry(coordinate: CLLocationCoordinate2D(latitude: -30.906764,longitude: 18.4164983), title: "0607")
    var entry4 = JournalEntry(coordinate: CLLocationCoordinate2D(latitude: -29.906764,longitude: 19.4164983), title: "0608")
    var entry5 = JournalEntry(coordinate: CLLocationCoordinate2D(latitude: -28.906764,longitude: 18.4164983), title: "0609")
    
    
    var currentEntries:[JournalEntry]
    
    private init(){
        currentEntries = [entry1,entry2,entry3,entry4,entry5]
    }
    func getCurrentEntries()->[JournalEntry]{
        return currentEntries
    }
    func getStringEntries()->[String]{
        var stringList = [String]()
        for entry in currentEntries{
            stringList.append(entry.title!)
        }
        return stringList
    }
    func addEntry(title:String, notes:String, dates: String, latitude:String, longitude:String){
        let coordinates = CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
        let newEntry = JournalEntry(coordinate: coordinates, title: title)
        newEntry.dates = dates
        newEntry.notes = notes
        
        currentEntries.append(newEntry)
    }
    
}