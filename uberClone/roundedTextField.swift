//
//  roundedTextField.swift
//  uberClone
//
//  Created by A on 3/26/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit

class roundedTextField: UITextField {
    
    override func awakeFromNib() {
        
        setView()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let offset: CGFloat = 20.0
        
       return CGRect(x: 0 + offset, y: 0 + (offset / 2), width: self.frame.width - offset, height: self.frame.height + offset)
        
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let offset: CGFloat = 20.0
        
        return CGRect(x: 0 + offset, y: 0 + (offset / 2), width: self.frame.width - offset, height: self.frame.height + offset)
    }
    
    func setView() {
        
        self.layer.cornerRadius = self.frame.height / 2
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        
        self.layer.shadowRadius = 5.0
        
    }

}
