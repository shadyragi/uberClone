//
//  presentLoadingView.swift
//  uberClone
//
//  Created by A on 4/2/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentLoadingView(_ status: Bool) {
        
        var loadingView: UIView!
        
        if status {
            
            print("hit")
            for subview in view.subviews {
                
                if subview.tag == 20 {
                    
                    return
                }
            }
            
            loadingView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            
            loadingView.backgroundColor = UIColor.black
            
            loadingView.tag = 20
            
            loadingView.alpha = 0.4
            
            let spinner = UIActivityIndicatorView()
            
            spinner.color = UIColor.black
            
            spinner.activityIndicatorViewStyle = .whiteLarge
            
            spinner.center = view.center
            
            UIView.animate(withDuration: 0.3, animations: { 
                
                loadingView.addSubview(spinner)
                
                self.view.addSubview(loadingView)
                
                spinner.startAnimating()
            })
            
        } else {
            
            for subview in self.view.subviews {
      
                if subview.tag == 20 {
                    
                    UIView.animate(withDuration: 0.3, animations: {
                    
                    subview.removeFromSuperview()
                    }
                    )
            }

        }
        
    }
    
}
}
