//
//  roundedBtn.swift
//  uberClone
//
//  Created by A on 3/25/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit

class roundedBtn: UIButton {
    
    var originalFrames: CGRect?
   
    override func awakeFromNib() {
        
        setView()
    }
    
    func setView() {
        
        self.layer.cornerRadius = 5.0
        
        self.layer.shadowRadius = 10.0
        
        self.layer.shadowOpacity = 0.3
        
        self.layer.shadowColor = UIColor.darkGray.cgColor
        
        self.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        
    }
    
    func animateBtn(shouldLoad: Bool, withMessage message: String) {
        
        self.setTitle("", for: .normal)
        
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView()
        
        spinner.color = UIColor.darkGray
        
        spinner.activityIndicatorViewStyle = .whiteLarge
        
        spinner.alpha = 0.0
        
        spinner.hidesWhenStopped = true
        
        self.addSubview(spinner)
        
        if shouldLoad {
            
            self.isUserInteractionEnabled = false
            
            self.backgroundColor = UIColor.lightGray
            
            self.setTitle(message, for: .normal)
            
            /*UIView.animate(withDuration: 0.3, animations: {
                
                self.layer.cornerRadius = self.frame.width / 2
                
                self.frame = CGRect(x: self.frame.midX - (self.frame.width / 2), y: self.frame.origin.y, width: self.frame.width, height: self.frame.height)
            }, completion: { (finished) in
                
                if finished {
                    
                    spinner.center = CGPoint(x: self.frame.width / 2 , y: self.frame.height / 2)

                     spinner.alpha = 1.0
                    
                    spinner.startAnimating()
                    
                    
                }
                
            })*/
            
        } else {
            
            self.setTitle("REQUEST RIDE", for: .normal)
            
            self.backgroundColor = UIColor.white
            
            self.isUserInteractionEnabled = true
            
        }
        
    }
}
