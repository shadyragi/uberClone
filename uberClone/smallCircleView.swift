//
//  smallCircleView.swift
//  uberClone
//
//  Created by A on 3/25/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit

class smallCircleView: UIView {
    
    @IBInspectable var bordercolor: UIColor! {
    
        didSet {
            
            setView()
        }
    }
    
  
    
    func setView() {
        
        self.layer.cornerRadius = self.frame.width / 2
        
        self.layer.borderColor = bordercolor.cgColor
        
    }

}
