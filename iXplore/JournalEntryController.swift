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
    
    var currentEntries: [JournalEntry] = []
    
    private init() {
        let manager = NSFileManager.defaultManager()
        let document = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        
        do {
            let fileList = try manager.contentsOfDirectoryAtURL(document, includingPropertiesForKeys: nil, options: [])
            for file in fileList {
                if let entry = NSKeyedUnarchiver.unarchiveObjectWithFile(file.path!) as? JournalEntry {
                    currentEntries.append(entry)
                }
            }
        }
        catch {}
    }
    
    func addEntry(newEntry: JournalEntry){
        currentEntries.append(newEntry)
        let manager = NSFileManager.defaultManager()
        let document = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let url = document.URLByAppendingPathComponent(newEntry.ID.UUIDString)
        NSKeyedArchiver.archiveRootObject(newEntry, toFile: url.path!)
    }
    func removeEntry(index:Int){
        
        let manager = NSFileManager.defaultManager()
        let document = manager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let url = document.URLByAppendingPathComponent(currentEntries[index].ID.UUIDString)
        currentEntries.removeAtIndex(index)
        do {
            try manager.removeItemAtURL(url)
        } catch {}
        
    }
    
}