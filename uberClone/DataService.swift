//
//  DataService.swift
//  uberClone
//
//  Created by A on 3/27/18.
//  Copyright © 2018 A. All rights reserved.
//

import Foundation

import Firebase

import MapKit

let DATABASE_REF = Database.database().reference()

class DataService {
    
  
    
    private var _USERS_REF: DatabaseReference = DATABASE_REF.child("users")
    
    private var _DRIVERS_REF: DatabaseReference = DATABASE_REF.child("drivers")
    
    private var _TRIPS_REF: DatabaseReference = DATABASE_REF.child("trips")
    
    var TRIPS_REF: DatabaseReference {
        
        get {
            
            return _TRIPS_REF
        }
    }
    
    var USERS_REF: DatabaseReference {
        
        get {
            
            return _USERS_REF
            
        }
        
    }
    
    var DRIVERS_REF: DatabaseReference {
        
        get {
            
            return _DRIVERS_REF
        }
    }
    
    static let instance = DataService()
    
    private init() {
        
    }
    
    func registerUser(Data: [String: String], isDriver: Bool, completion: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        let id = Auth.auth().currentUser?.uid
        
        if isDriver {
            
          self.DRIVERS_REF.child(id!).updateChildValues(["pickedupModeEnabled": false, "onTripModeEnabled": false, "email": Data["email"]], withCompletionBlock: { (error, driver) in
            
            if (error != nil) {
                
                completion(false, error)
            } else {
        
                self.fillAuthUserData(data: ["email": Data["email"] as AnyObject, "isDriver": (true as? AnyObject)!, "coordinate": CLLocationCoordinate2D() as AnyObject])
                
                
                completion(true, nil)
                
            }
          })
            
        } else {
        
        self.USERS_REF.child(id!).updateChildValues(Data) { (error, user) in
            
            if (error != nil) {
                
                completion(false, error)
                
            } else {
                
                 self.fillAuthUserData(data: ["email": Data["email"] as AnyObject, "isDriver": (false as? AnyObject)!, "coordinate": CLLocationCoordinate2D() as AnyObject])
                
                completion(true, nil)
            }
            
            }
        }
        
        
    }
    
    func observeTrip(key: String, handler: @escaping (_ status: Bool) -> ()) {
        
        self.TRIPS_REF.child(key).observe(.value, with: { (snapshot) in
            
            if let tripSnapshot = snapshot.value as? [String: AnyObject] {
                
                if tripSnapshot["tripAccepted"] as? Bool == true {
                    
                    handler(true)
                    
                }
                
                else {
                    handler(false)
                }
            }
            
        })
        
    }
    
    func isDriverOnTrip(handler: @escaping (_ status: Bool) -> ()) {
        
        self.DRIVERS_REF.child((Auth.auth().currentUser?.uid)!).child("onTripModeEnabled").observe(.value, with: { (snapshot) in
            
            if let mode = snapshot.value as? Bool {
                
              handler(mode)
                
                
            }
        })
        
    }
    
    func isPassengerOnTrip(handler: @escaping (_ status: Bool) -> ()) {
        
        self.TRIPS_REF.child((Auth.auth().currentUser?.uid)!).observe(.value, with: { (snapshot) in
            
            if(snapshot == nil) {
                handler(false)
            } else {
                handler(true)
            }
        })
        
    }
    
    
    func isDriverAvailable(handler: @escaping (_ status: Bool) -> ()) {
        
        self.DRIVERS_REF.child((Auth.auth().currentUser?.uid)!).observe(.value, with: { (snapshot) in
            
            if let driverSnapshot = snapshot.value as? [String: AnyObject] {
                
                print("diver func")
                if driverSnapshot["pickedupModeEnabled"] as? Bool == true {
                    
                    print("mode enabled")
                    
                    if driverSnapshot["onTripModeEnabled"] as? Bool == false {
                        handler(true)
                        
                        
                    }
                }
             handler(false)
            }
        })
        
    }
    
    func fillAuthUserData(data: [String: AnyObject]) {
        
        AuthUser.instance.email = (data["email"] as? String)!
        
        AuthUser.instance.isDriver = (data["isDriver"] as? Bool)!
        
        AuthUser.instance.coordinate = (data["coordinate"] as? CLLocationCoordinate2D)!
        
    }
    
    func addDestinationCoordinate(coordinate: CLLocationCoordinate2D) {
        
        self.USERS_REF.child((Auth.auth().currentUser?.uid)!).updateChildValues(["tripCoordinate": [coordinate.latitude, coordinate.longitude]])
        
    }
    
    func observeAcceptedTrips(handler: @escaping (_ coordinate: CLLocationCoordinate2D) -> ()) {
        
       self.TRIPS_REF.child((Auth.auth().currentUser?.uid)!).observe(.value, with: { (snapshot) in
            print("not driver")
            if let dicit = snapshot.value as? [String: AnyObject] {
                
                if dicit["tripAccepted"] as? Bool == true {
                    
                    if let location = dicit["driverPosition"] as? NSArray {
                        
                        let coordinate = CLLocationCoordinate2D(latitude: location[0] as! CLLocationDegrees, longitude: location[1] as! CLLocationDegrees)
                        
                        handler(coordinate)
                        
                    }
                    
                }
            }
        })
        
        
    }
    
    
    func observeTrips(handler: @escaping (_ Dict: [String: AnyObject]) -> ()) {
        
        self.TRIPS_REF.observe(.value, with: { (snapshot) in
            
            if let tripsnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                
                for trip in tripsnapshot {
                    
                    handler(trip.value as! [String : AnyObject])
                }
                
            }
        })
        
    }
    
    
    
}
