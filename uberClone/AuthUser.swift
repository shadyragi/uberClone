//
//  AuthUser.swift
//  uberClone
//
//  Created by A on 3/28/18.
//  Copyright © 2018 A. All rights reserved.
//

import Foundation

import MapKit
class AuthUser {
    
    static let instance = AuthUser()
    
    private init() {
        
    }
    
    private var _email: String!
    
    private var _isDriver: Bool!
    
    private var _coordinate: CLLocationCoordinate2D!
    
    
    var email: String {
        
        set {
            
            _email = newValue
        }
        
        get {
            
            if _email == nil {
                _email = ""
            }
            
            return _email
        }
        
    }
    
    var isDriver: Bool {
        
        set {
            _isDriver = newValue
        }
        
        get {
            
            if _isDriver == nil {
                
                _isDriver = false
                
            }
            
            return _isDriver
        }
        
    }
    
    var coordinate: CLLocationCoordinate2D {
        
        set {
            
            _coordinate = newValue
        }
        
        get {
            
            return _coordinate
        }
    }
    
    
    
    
    
}
