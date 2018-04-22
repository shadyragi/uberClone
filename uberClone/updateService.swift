//
//  updateService.swift
//  uberClone
//
//  Created by A on 3/28/18.
//  Copyright © 2018 A. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import MapKit

class updateService {
    
    static let instance = updateService()
    
    private init() {
        
    }
    
    let id = Auth.auth().currentUser?.uid
    
    func updateUserLocation(coordinate: CLLocationCoordinate2D) {
        
        DataService.instance.USERS_REF.child(id!).updateChildValues(["coordinate": [coordinate.latitude, coordinate.longitude]])
        
    }
    
    func updateDriveLocation(coordinate: CLLocationCoordinate2D) {
        
        DataService.instance.DRIVERS_REF.child(id!).updateChildValues(["coordinate": [coordinate.latitude, coordinate.longitude]])
        
    }
    
    func cancelTrip(forId: String) {
        
        DataService.instance.USERS_REF.child(forId).child("tripCoordinate").removeValue()
        
        DataService.instance.TRIPS_REF.child(forId).child("driverKey").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let key = snapshot.value as? String {
                
                DataService.instance.DRIVERS_REF.child(key).updateChildValues(["onTripModeEnabled": false])
                
            }
        })
        
        DataService.instance.TRIPS_REF.child(forId).removeValue()
        
        
        
        
    }
    
    func updateTrip(handler: @escaping () -> ()) {
        
        let id = Auth.auth().currentUser?.uid
        
        DataService.instance.USERS_REF.child(id!).observeSingleEvent(of: .value, with: { (userSnapshot) in
            
            let pickUpArray = userSnapshot.childSnapshot(forPath: "coordinate").value as! NSArray
            
            let destArray = userSnapshot.childSnapshot(forPath: "tripCoordinate").value as! NSArray
            
              DataService.instance.TRIPS_REF.child(id!).updateChildValues(["pickUpArray": pickUpArray, "destArray": destArray, "passengerKey": id!, "tripAccepted": false])
            
            handler()
            
        })
        
      
        
    }
    
    func accepttrip(key: String, locationCoordinate: CLLocationCoordinate2D, handler: @escaping (_ status: Bool) -> ()) {
        
        
        DataService.instance.DRIVERS_REF.child((Auth.auth().currentUser?.uid)!).updateChildValues(["onTripModeEnabled": true])
        
        
        
        DataService.instance.TRIPS_REF.child(key).updateChildValues(["tripAccepted": true, "driverPosition": [locationCoordinate.latitude, locationCoordinate.longitude] , "driverKey": (Auth.auth().currentUser?.uid)!])

        
        handler(true)
        
    }
}
