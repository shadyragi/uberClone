//
//  bindKeyBoard.swift
//  uberClone
//
//  Created by A on 3/26/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit

extension UIView {
    
    func addBindObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(bindKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    @objc func bindKeyboard(_ notification: NSNotification) {
        
        
        
        if let keyboardsize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
            
            let endingframe = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
            
            let delta = keyboardsize.cgRectValue.origin.y - (endingframe?.cgRectValue.origin.y)!
            
                self.frame.origin.y -= delta

        }
        
        
    }
    
    @objc func hideKeyboard(_ notification: NSNotification) {
        
       
        
        if let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
            
            let endingFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
            
            let delta = keyboardSize.cgRectValue.origin.y - (endingFrame?.cgRectValue.origin.y)!
    
            
            self.frame.origin.y -= delta
            
        }
        
    }
    
}
