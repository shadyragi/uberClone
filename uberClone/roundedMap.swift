//
//  roundedMap.swift
//  uberClone
//
//  Created by A on 4/7/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit
import MapKit
class roundedMap: MKMapView {
    
    override func awakeFromNib() {
        setMap()
    }
    
    func setMap() {
        
        self.layer.cornerRadius = self.frame.width / 2
        
        
        
    }

}
