//
//  Helpers.swift
//  uberClone
//
//  Created by A on 3/27/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit


class Helpers {
    
    static let instance = Helpers()
    
    private init() {
        
    }
    
    func displayError(error: String) -> UIAlertController {
        
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alertController.addAction(action)
        
        return alertController
        
    }
    
}
