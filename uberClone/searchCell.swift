//
//  searchCell.swift
//  uberClone
//
//  Created by A on 3/29/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit

import MapKit

class searchCell: UITableViewCell {
    
    
    @IBOutlet weak var placeName: UILabel!
    
    func configureCell(item: MKMapItem) {
        
        self.placeName.text = item.name
        
    }
 

}
