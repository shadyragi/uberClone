//
//  roundedImage.swift
//  uberClone
//
//  Created by A on 3/25/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit

class roundedImage: UIImageView {
    
    override func awakeFromNib() {
        
        setupView()
    }
    
    func setupView() {
        
        self.layer.cornerRadius = self.frame.width / 2
        
        self.clipsToBounds = true
        
    }

}
