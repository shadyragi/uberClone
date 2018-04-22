//
//  AuthService.swift
//  uberClone
//
//  Created by A on 3/27/18.
//  Copyright © 2018 A. All rights reserved.
//

import Foundation

import Firebase

import MapKit

class AuthService {
    
    static let instance = AuthService()
    
    private init() {
        
    }
    
    func signIn(email: String, pwd: String, isDriver: Bool, completion: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: pwd) { (user, error) in
            
            if let user = user {
                
                
                DataService.instance.fillAuthUserData(data: ["email": (email as? AnyObject)!, "isDriver": (isDriver as? AnyObject)!, "coordinate": CLLocationCoordinate2D() as AnyObject])
                
                completion(true, nil)
                
            } else {
                
                completion(false, error)
                
            }
            
            
        }
        
    }
    
    func signOut(completion: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        do {
            
            try Auth.auth().signOut()
            
            completion(true, nil)
            
        } catch let err as NSError {
            
            completion(false, err)
            
        }
        
    }
    
    func signUp(email: String, pwd: String, completion: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: pwd) { (user, error) in
            
            if let user = user {
                
                completion(true, nil)
                
            } else {
                
                completion(false, error)
                
            }
        }
        
    }
    
    func checkAccount(accountType type: String, completion: @escaping (_ status: Bool) -> ()) {
        
        let id = Auth.auth().currentUser?.uid
        
        if type == "driver" {
            
            DataService.instance.DRIVERS_REF.child(id!).observe(.value, with: { (snapshot) in
                
                if let dicit = snapshot.value as? [String: AnyObject] {
                    
                    completion(true)
                    
                } else {
                    
                    completion(false)
                }
            })
            
        } else {
            
            DataService.instance.USERS_REF.child(id!).observe(.value, with: { (snapshot) in
                
                if let dicit = snapshot.value as? [String: AnyObject] {
                    
                    completion(true)
                    
                } else {
                    
                    completion(false)
                }
                
            })
            
        }
     
        return
    }
    
    
    
}
