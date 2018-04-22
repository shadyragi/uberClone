//
//  pickUpVC.swift
//  uberClone
//
//  Created by A on 4/7/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class pickUpVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapview: roundedMap!
    
    var pickUpLocation: CLLocationCoordinate2D!
    
    var passengerKey: String!
    
    var manager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        
        manager.delegate = self
        
        
        mapview.delegate = self
        
        mapview.isUserInteractionEnabled = true
        
        dropPin(locationCoordinate: pickUpLocation)
        
        centerLocation(location: pickUpLocation)
        
        DataService.instance.observeTrip(key: passengerKey) { (status) in
            
            if status {
                
                self.dismiss(animated: true, completion: nil)
            }
        }

    }
    
  

    @IBAction func cancelBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func AcceptTripPressed(_ sender: Any) {
        
        
        updateService.instance.accepttrip(key: passengerKey, locationCoordinate: (manager.location?.coordinate)!) { (status) in
            
            if status {
              
                self.dismiss(animated: true, completion: nil)
               
                
            }
        }
        
    }
    
    func initData(pickUpLocation: CLLocationCoordinate2D, passengerKey: String) {
        

        
        self.pickUpLocation = pickUpLocation
        
        self.passengerKey = passengerKey
        
    }


}

extension pickUpVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pickUP")
        
        if(annotationView == nil) {
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pickUP")
        } else {
            
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "destinationAnnotation");
        
        return annotationView
    }
    
    func centerLocation(location: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegionMakeWithDistance(location, 2000, 2000)
        
        self.mapview.setRegion(region, animated: true)
        
    }
    
    func dropPin(locationCoordinate: CLLocationCoordinate2D) {
        
        print("coordinate \(locationCoordinate)")
        
        let annotaion = placeAnnotation(coordinate: locationCoordinate, identifier: "userAnnotation")
        
        self.mapview.addAnnotation(annotaion)
    }
    
}
