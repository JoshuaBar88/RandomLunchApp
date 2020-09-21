//
//  CustomButton.swift
//  APIptmilli
//
//  Created by Joshua Barnett on 5/22/20.
//  Copyright © 2020 Joshua Barnett. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton{
    var customTag:String = ""
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setupButton()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
        self.isSelected = false
    }
    
    
    func setupButton(){
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        //layer.cornerRadius = 0.5 * self.size.width
    }
    
    
}
