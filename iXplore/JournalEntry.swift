//
//  entryModel.swift
//  iXplore
//
//  Created by David Xu on 7/8/16.
//  Copyright © 2016 David Xu. All rights reserved.
//

import Foundation
import MapKit

class JournalEntry:NSObject,MKAnnotation,NSCoding{
    
    
    var ID:NSUUID
    var coordinate: CLLocationCoordinate2D
    var title:String?
    var notes :String?
    var dates: String?
    var image: UIImage? {
        didSet {
            if let image = image {
                let ratio = 300 / image.size.width
                
                UIGraphicsBeginImageContext(CGSize(width: 300, height: image.size.height * ratio))
                image.drawInRect(CGRect(x: 0, y: 0, width: 300, height: image.size.height * ratio))
                self.image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
            }
        }
    }
    
    
    
    
    init(coordinate: CLLocationCoordinate2D, title:String){
        ID = NSUUID()
        self.coordinate = coordinate
        self.title = title
    }
    
    required init(coder:NSCoder) {
        ID = (coder.decodeObjectForKey("ID") as? NSUUID) ?? NSUUID()
        image = (coder.decodeObjectForKey("image") as? UIImage) ?? nil
        title = (coder.decodeObjectForKey("title") as? String) ?? ""
        notes = (coder.decodeObjectForKey("notes") as? String) ?? ""
        dates = (coder.decodeObjectForKey("dates") as? String) ?? ""
        let longitude = (coder.decodeObjectForKey("longitude") as? Double) ?? 0.0
        let latitude = (coder.decodeObjectForKey("latitude") as? Double) ?? 0.0
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
    }
    func encodeWithCoder(aCoder: NSCoder) {
        let longitude = coordinate.longitude
        let latitude = coordinate.latitude
        aCoder.encodeObject(longitude,forKey: "longitude")
        aCoder.encodeObject(latitude,forKey: "latitude")
        aCoder.encodeObject(title,forKey: "title")
        aCoder.encodeObject(notes,forKey: "notes")
        aCoder.encodeObject(dates,forKey: "dates")
        aCoder.encodeObject(image,forKey: "image")
        aCoder.encodeObject(ID, forKey: "ID")
    }
    
}
