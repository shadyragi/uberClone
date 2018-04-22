//
//  placeAnnotation.swift
//  uberClone
//
//  Created by A on 3/31/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit

import MapKit

class placeAnnotation: NSObject, MKAnnotation {
    
    dynamic var coordinate: CLLocationCoordinate2D
    
    var identifer: String
    
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        
        self.coordinate = coordinate
        
        self.identifer = identifier
    }
    
}
