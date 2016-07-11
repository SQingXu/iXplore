//
//  entryModel.swift
//  iXplore
//
//  Created by David Xu on 7/8/16.
//  Copyright © 2016 David Xu. All rights reserved.
//

import Foundation
import MapKit
class JournalEntry:NSObject,MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title:String?
    var notes :String?
    var dates: String?
    init(coordinate: CLLocationCoordinate2D, title:String){
        self.coordinate = coordinate
        self.title = title
        
    }
    
}
